import 'dart:convert';
import 'dart:isolate';
import 'dart:math';
import 'package:cryptography/cryptography.dart';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import 'access_control.dart';

class AccountEndpoint extends Endpoint {
  static final _attempts = <String, List<DateTime>>{};
  static String _token() => '${const Uuid().v4()}${const Uuid().v4()}';
  static String _email(String value) {
    final email = value.trim().toLowerCase();
    if (email.length > 254 ||
        !RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email)) {
      throw DispatchException(message: 'Enter a valid email address.');
    }
    return email;
  }

  static void _password(String password) {
    if (password.length < 12 || password.length > 128) {
      throw DispatchException(message: 'Use a password of 12–128 characters.');
    }
  }

  static void _name(String value) {
    if (value.trim().length < 2 || value.trim().length > 100) {
      throw DispatchException(message: 'Use a name of 2–100 characters.');
    }
  }

  static void _rate(String key) {
    final now = DateTime.now().toUtc();
    _attempts.removeWhere(
      (_, v) => v.isEmpty || now.difference(v.last).inMinutes > 15,
    );
    if (_attempts.length > 10000) {
      throw DispatchException(message: 'Please try again later.');
    }
    final attempts = _attempts.putIfAbsent(key, () => []);
    attempts.removeWhere((d) => now.difference(d).inMinutes >= 15);
    if (attempts.length >= 10) {
      throw DispatchException(
        message: 'Too many attempts. Try again in 15 minutes.',
      );
    }
    attempts.add(now);
  }

  static Future<(String, String)> _hashPassword(
    String password, [
    String? existingSalt,
  ]) async {
    final salt =
        existingSalt ??
        base64Encode(List.generate(32, (_) => Random.secure().nextInt(256)));
    final hash = await Isolate.run(() async {
      final key = await Pbkdf2.hmacSha256(
        iterations: 600000,
        bits: 256,
      ).deriveKeyFromPassword(password: password, nonce: base64Decode(salt));
      return base64Encode(await key.extractBytes());
    });
    return (salt, hash);
  }

  static bool _equal(String a, String b) {
    var result = a.length ^ b.length;
    for (var i = 0; i < a.length && i < b.length; i++) {
      result |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
    }
    return result == 0;
  }

  Future<AuthAccess> registerOrganization(
    Session session,
    String organization,
    String name,
    String email,
    String password,
  ) async {
    email = _email(email);
    _name(name);
    _name(organization);
    _password(password);
    _rate('register:$email');
    final (salt, hash) = await _hashPassword(password);
    return session.db.transaction((tx) async {
      if (await StaffAccount.db.findFirstRow(
            session,
            where: (t) => t.email.equals(email),
            transaction: tx,
          ) !=
          null) {
        throw DispatchException(
          message:
              'Unable to create this account. Sign in or contact your administrator.',
        );
      }
      final workspace = await DispatchSession.db.insertRow(
        session,
        DispatchSession(
          tokenHash: AccessControl.digest(_token()),
          expiresAt: DateTime.utc(2100),
          revision: 0,
          name: organization.trim(),
          isDemo: false,
        ),
        transaction: tx,
      );
      await seedWorkspace(session, workspace.id!, tx);
      final account = await StaffAccount.db.insertRow(
        session,
        StaffAccount(
          workspaceId: workspace.id!,
          email: email,
          name: name.trim(),
          role: 'admin',
          passwordSalt: salt,
          passwordHash: hash,
          active: true,
          createdAt: DateTime.now().toUtc(),
        ),
        transaction: tx,
      );
      final recovery = _token();
      await StaffInvite.db.insertRow(
        session,
        StaffInvite(
          workspaceId: workspace.id!,
          tokenHash: AccessControl.digest(recovery),
          email: email,
          role: 'admin',
          recoveryAccountId: account.id!,
          expiresAt: DateTime.now().toUtc().add(const Duration(days: 365)),
        ),
        transaction: tx,
      );
      return (await _loginSession(
        session,
        account,
        tx,
      )).copyWith(recoveryCode: recovery);
    });
  }

  Future<AuthAccess> login(
    Session session,
    String email,
    String password,
  ) async {
    email = _email(email);
    _rate('login:$email');
    if (password.length > 128) {
      throw DispatchException(message: 'Email or password is incorrect.');
    }
    final account = await StaffAccount.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email),
    );
    final (_, hash) = await _hashPassword(
      password,
      account?.passwordSalt ?? base64Encode(List.filled(32, 0)),
    );
    if (account == null ||
        !account.active ||
        !_equal(hash, account.passwordHash)) {
      throw DispatchException(message: 'Email or password is incorrect.');
    }
    return session.db.transaction((tx) async {
      await DispatchSession.db.findById(
        session,
        account.workspaceId,
        transaction: tx,
        lockMode: LockMode.forUpdate,
      );
      final fresh = await StaffAccount.db.findById(
        session,
        account.id!,
        transaction: tx,
      );
      if (fresh == null ||
          !fresh.active ||
          fresh.passwordHash != account.passwordHash) {
        throw DispatchException(message: 'Email or password is incorrect.');
      }
      return _loginSession(session, fresh, tx);
    });
  }

  Future<void> logout(Session session, String token) async {
    late DispatchSession workspace;
    await session.db.transaction((tx) async {
      final access = await AccessControl.resolve(
        session,
        token,
        transaction: tx,
      );
      workspace = access.workspace;
      await StaffSession.db.deleteWhere(
        session,
        where: (t) => t.tokenHash.equals(AccessControl.digest(token)),
        transaction: tx,
      );
    });
    await AccessControl.signal(session, workspace);
  }

  Future<InviteAccess> invite(
    Session session,
    String token,
    String email,
    String role,
    int? unitId,
    bool recovery,
  ) async {
    email = _email(email);
    if (!['admin', 'dispatcher', 'crew', 'citizen'].contains(role)) {
      throw DispatchException(message: 'Choose a valid role.');
    }
    final raw = _token();
    final result = await session.db.transaction((tx) async {
      final access = await AccessControl.resolve(
        session,
        token,
        transaction: tx,
      );
      access.require(['admin']);
      if (access.workspace.isDemo) {
        throw DispatchException(
          message: 'Create an organization account before inviting people.',
        );
      }
      final existing = await StaffAccount.db.findFirstRow(
        session,
        where: (t) => t.email.equals(email),
        transaction: tx,
      );
      if (recovery &&
          (existing == null ||
              existing.workspaceId != access.workspace.id ||
              !existing.active)) {
        throw DispatchException(
          message: 'Active account not found in this organization.',
        );
      }
      if (!recovery && existing != null) {
        throw DispatchException(message: 'This email already has an account.');
      }
      if (role == 'crew' && !recovery) {
        final unit = unitId == null
            ? null
            : await DispatchUnit.db.findById(session, unitId, transaction: tx);
        if (unit == null ||
            unit.workspaceId != access.workspace.id ||
            !unit.active) {
          throw DispatchException(
            message: 'Select an active ambulance for the crew.',
          );
        }
      }
      await StaffInvite.db.deleteWhere(
        session,
        where: (t) =>
            t.workspaceId.equals(access.workspace.id!) &
            t.email.equals(email) &
            t.usedAt.equals(null),
        transaction: tx,
      );
      final expires = DateTime.now().toUtc().add(
        recovery ? const Duration(minutes: 30) : const Duration(days: 2),
      );
      await StaffInvite.db.insertRow(
        session,
        StaffInvite(
          workspaceId: access.workspace.id!,
          tokenHash: AccessControl.digest(raw),
          email: email,
          role: recovery ? existing!.role : role,
          assignedUnitId: role == 'crew' ? unitId : null,
          recoveryAccountId: recovery ? existing!.id : null,
          expiresAt: expires,
        ),
        transaction: tx,
      );
      return InviteAccess(
        token: raw,
        email: email,
        role: recovery ? existing!.role : role,
        expiresAt: expires,
        recovery: recovery,
      );
    });
    return result;
  }

  Future<AuthAccess> acceptInvite(
    Session session,
    String inviteToken,
    String name,
    String password,
  ) async {
    _name(name);
    _password(password);
    _rate('invite:${AccessControl.digest(inviteToken)}');
    final (salt, hash) = await _hashPassword(password);
    final access = await session.db.transaction((tx) async {
      final invite = await StaffInvite.db.findFirstRow(
        session,
        where: (t) => t.tokenHash.equals(AccessControl.digest(inviteToken)),
        transaction: tx,
      );
      if (invite == null ||
          invite.usedAt != null ||
          !invite.expiresAt.isAfter(DateTime.now().toUtc())) {
        throw DispatchException(message: 'Invitation expired or already used.');
      }
      final workspace = await DispatchSession.db.findById(
        session,
        invite.workspaceId,
        transaction: tx,
        lockMode: LockMode.forUpdate,
      );
      if (workspace == null) {
        throw DispatchException(message: 'Organization unavailable.');
      }
      final freshInvite = await StaffInvite.db.findById(
        session,
        invite.id!,
        transaction: tx,
        lockMode: LockMode.forUpdate,
      );
      if (freshInvite == null ||
          freshInvite.usedAt != null ||
          !freshInvite.expiresAt.isAfter(DateTime.now().toUtc())) {
        throw DispatchException(message: 'Invitation expired or already used.');
      }
      StaffAccount account;
      if (invite.recoveryAccountId != null) {
        final existing = await StaffAccount.db.findById(
          session,
          invite.recoveryAccountId!,
          transaction: tx,
        );
        if (existing == null ||
            !existing.active ||
            existing.workspaceId != workspace.id) {
          throw DispatchException(message: 'Account unavailable.');
        }
        existing.passwordSalt = salt;
        existing.passwordHash = hash;
        account = await StaffAccount.db.updateRow(
          session,
          existing,
          transaction: tx,
        );
        await StaffSession.db.deleteWhere(
          session,
          where: (t) => t.accountId.equals(account.id!),
          transaction: tx,
        );
      } else {
        if (await StaffAccount.db.findFirstRow(
              session,
              where: (t) => t.email.equals(invite.email),
              transaction: tx,
            ) !=
            null) {
          throw DispatchException(message: 'Account already exists.');
        }
        account = await StaffAccount.db.insertRow(
          session,
          StaffAccount(
            workspaceId: invite.workspaceId,
            email: invite.email,
            name: name.trim(),
            role: invite.role,
            passwordSalt: salt,
            passwordHash: hash,
            active: true,
            assignedUnitId: invite.assignedUnitId,
            createdAt: DateTime.now().toUtc(),
          ),
          transaction: tx,
        );
      }
      invite.usedAt = DateTime.now().toUtc();
      await StaffInvite.db.updateRow(session, invite, transaction: tx);
      workspace.revision++;
      await DispatchSession.db.updateRow(session, workspace, transaction: tx);
      await AccessControl.signal(session, workspace);
      return _loginSession(session, account, tx);
    });
    return access;
  }

  Future<void> changePassword(
    Session session,
    String token,
    String oldPassword,
    String newPassword,
  ) async {
    _password(newPassword);
    final access = await AccessControl.resolve(session, token);
    if (access.account == null) {
      throw DispatchException(message: 'Demo accounts have no password.');
    }
    _rate('password:${access.accountId}');
    final (_, oldHash) = await _hashPassword(
      oldPassword,
      access.account!.passwordSalt,
    );
    if (!_equal(oldHash, access.account!.passwordHash)) {
      throw DispatchException(message: 'Current password is incorrect.');
    }
    final (salt, hash) = await _hashPassword(newPassword);
    await session.db.transaction((tx) async {
      final fresh = await AccessControl.resolve(
        session,
        token,
        transaction: tx,
      );
      final account = fresh.account!;
      if (account.passwordHash != oldHash) {
        throw DispatchException(message: 'Account changed. Sign in again.');
      }
      account.passwordSalt = salt;
      account.passwordHash = hash;
      await StaffAccount.db.updateRow(session, account, transaction: tx);
      await StaffSession.db.deleteWhere(
        session,
        where: (t) =>
            t.accountId.equals(account.id!) &
            t.tokenHash.notEquals(AccessControl.digest(token)),
        transaction: tx,
      );
      await AccessControl.signal(session, fresh.workspace);
    });
  }

  Future<void> updateMember(
    Session session,
    String token,
    int accountId,
    bool active,
    int? unitId,
  ) async {
    late DispatchSession workspace;
    await session.db.transaction((tx) async {
      final access = await AccessControl.resolve(
        session,
        token,
        transaction: tx,
      );
      access.require(['admin']);
      workspace = access.workspace;
      final account = await StaffAccount.db.findById(
        session,
        accountId,
        transaction: tx,
      );
      if (account == null || account.workspaceId != workspace.id) {
        throw DispatchException(message: 'Account not found.');
      }
      if (account.id == access.accountId && !active) {
        throw DispatchException(
          message: 'You cannot deactivate your own account.',
        );
      }
      if (unitId != null) {
        final unit = await DispatchUnit.db.findById(
          session,
          unitId,
          transaction: tx,
        );
        if (account.role != 'crew' ||
            unit == null ||
            unit.workspaceId != workspace.id ||
            !unit.active) {
          throw DispatchException(message: 'Select a valid crew unit.');
        }
      }
      account.active = active;
      account.assignedUnitId = account.role == 'crew' ? unitId : null;
      await StaffAccount.db.updateRow(session, account, transaction: tx);
      if (!active) {
        await StaffSession.db.deleteWhere(
          session,
          where: (t) => t.accountId.equals(accountId),
          transaction: tx,
        );
      }
      workspace.revision++;
      await DispatchSession.db.updateRow(session, workspace, transaction: tx);
    });
    await AccessControl.signal(session, workspace);
  }

  Future<AuthAccess> _loginSession(
    Session session,
    StaffAccount account,
    Transaction tx,
  ) async {
    final raw = _token(),
        expires = DateTime.now().toUtc().add(const Duration(hours: 12));
    await StaffSession.db.insertRow(
      session,
      StaffSession(
        accountId: account.id!,
        tokenHash: AccessControl.digest(raw),
        expiresAt: expires,
      ),
      transaction: tx,
    );
    return AuthAccess(
      token: raw,
      expiresAt: expires,
      profile: AccessControl.profile(account),
    );
  }

  static Future<void> seedWorkspace(
    Session session,
    int id,
    Transaction tx,
  ) async {
    for (final (call, crew, lat, lng) in [
      ('MEDIC 01', 'Crew one', 14.5995, 120.9842),
      ('MEDIC 02', 'Crew two', 14.6095, 120.9942),
      ('MEDIC 03', 'Crew three', 14.5795, 120.9742),
    ]) {
      await DispatchUnit.db.insertRow(
        session,
        DispatchUnit(
          workspaceId: id,
          callSign: call,
          crew: crew,
          latitude: lat,
          longitude: lng,
          status: 'available',
          unitType: 'ALS',
        ),
        transaction: tx,
      );
    }
    await Hospital.db.insertRow(
      session,
      Hospital(
        workspaceId: id,
        name: 'Demo receiving hospital',
        address: 'Manila · replace with your receiving facility',
        phone: '',
        latitude: 14.604,
        longitude: 120.986,
        active: true,
      ),
      transaction: tx,
    );
  }
}
