import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class WorkspaceAccess {
  WorkspaceAccess(this.workspace, this.account);
  final DispatchSession workspace;
  final StaffAccount? account;
  String get role => account?.role ?? 'admin';
  int? get accountId => account?.id;
  StaffProfile get profile => account == null
      ? StaffProfile(
          id: 0,
          workspaceId: workspace.id!,
          name: 'Demo administrator',
          email: '',
          role: 'admin',
          active: true,
        )
      : AccessControl.profile(account!);
  void require(List<String> roles) {
    if (!roles.contains(role)) {
      throw DispatchException(message: 'Your role does not allow this action.');
    }
  }

  void incident(DispatchIncident incident) {
    if (incident.workspaceId != workspace.id ||
        (role == 'citizen' && incident.reporterAccountId != accountId) ||
        (role == 'crew' &&
            (account?.assignedUnitId == null ||
                incident.assignedUnitId != account?.assignedUnitId))) {
      throw DispatchException(
        message: 'Incident is not accessible to your account.',
      );
    }
  }
}

class AccessControl {
  static String digest(String token) =>
      sha256.convert(utf8.encode(token)).toString();
  static StaffProfile profile(StaffAccount a) => StaffProfile(
    id: a.id!,
    workspaceId: a.workspaceId,
    name: a.name,
    email: a.email,
    role: a.role,
    active: a.active,
    assignedUnitId: a.assignedUnitId,
  );

  static Future<WorkspaceAccess> resolve(
    Session session,
    String token, {
    Transaction? transaction,
  }) async {
    if (token.length != 72) {
      throw DispatchException(message: 'Invalid session. Sign in again.');
    }
    final hash = digest(token);
    var login = await StaffSession.db.findFirstRow(
      session,
      where: (t) => t.tokenHash.equals(hash),
      transaction: transaction,
    );
    StaffAccount? account;
    DispatchSession? workspace;
    if (login != null) {
      account = await StaffAccount.db.findById(
        session,
        login.accountId,
        transaction: transaction,
      );
      if (account != null) {
        workspace = await DispatchSession.db.findById(
          session,
          account.workspaceId,
          transaction: transaction,
          lockMode: transaction == null ? null : LockMode.forUpdate,
        );
      }
      // Recheck after the workspace lock so a concurrent logout or revocation wins.
      if (transaction != null && workspace != null) {
        login = await StaffSession.db.findFirstRow(
          session,
          where: (t) => t.tokenHash.equals(hash),
          transaction: transaction,
        );
        account = await StaffAccount.db.findById(
          session,
          account!.id!,
          transaction: transaction,
        );
      }
      if (login == null ||
          account == null ||
          !account.active ||
          !login.expiresAt.isAfter(DateTime.now().toUtc())) {
        throw DispatchException(
          message: 'Session expired or revoked. Sign in again.',
        );
      }
    } else {
      workspace = await DispatchSession.db.findFirstRow(
        session,
        where: (t) => t.tokenHash.equals(hash),
        transaction: transaction,
        lockMode: transaction == null ? null : LockMode.forUpdate,
      );
      if (workspace == null ||
          !workspace.isDemo ||
          !workspace.expiresAt.isAfter(DateTime.now().toUtc())) {
        throw DispatchException(
          message: 'Session expired or revoked. Sign in again.',
        );
      }
    }
    if (workspace == null) {
      throw DispatchException(message: 'Workspace unavailable.');
    }
    return WorkspaceAccess(workspace, account);
  }

  static Future<void> signal(Session session, DispatchSession workspace) async {
    // The shared channel carries only a revision. Each subscriber reads its own
    // authorized snapshot; patient data never enters a broadcast payload.
    await session.messages.postMessage(
      'dispatch-workspace-${workspace.id}',
      DispatchSnapshot(
        revision: workspace.revision,
        incidents: [],
        units: [],
        events: [],
        serverTime: DateTime.now().toUtc(),
      ),
    );
  }
}
