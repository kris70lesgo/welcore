/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;

abstract class InviteAccess
    implements _is.SerializableModel, _is.ProtocolSerialization {
  InviteAccess._({
    required this.token,
    required this.email,
    required this.role,
    required this.expiresAt,
    required this.recovery,
  });

  factory InviteAccess({
    required String token,
    required String email,
    required String role,
    required DateTime expiresAt,
    required bool recovery,
  }) = _InviteAccessImpl;

  factory InviteAccess.fromJson(Map<String, dynamic> jsonSerialization) {
    return InviteAccess(
      token: jsonSerialization['token'] as String,
      email: jsonSerialization['email'] as String,
      role: jsonSerialization['role'] as String,
      expiresAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      recovery: _is.BoolJsonExtension.fromJson(jsonSerialization['recovery']),
    );
  }

  String token;

  String email;

  String role;

  DateTime expiresAt;

  bool recovery;

  /// Returns a shallow copy of this [InviteAccess]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  InviteAccess copyWith({
    String? token,
    String? email,
    String? role,
    DateTime? expiresAt,
    bool? recovery,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InviteAccess',
      'token': token,
      'email': email,
      'role': role,
      'expiresAt': expiresAt.toJson(),
      'recovery': recovery,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'InviteAccess',
      'token': token,
      'email': email,
      'role': role,
      'expiresAt': expiresAt.toJson(),
      'recovery': recovery,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _InviteAccessImpl extends InviteAccess {
  _InviteAccessImpl({
    required String token,
    required String email,
    required String role,
    required DateTime expiresAt,
    required bool recovery,
  }) : super._(
         token: token,
         email: email,
         role: role,
         expiresAt: expiresAt,
         recovery: recovery,
       );

  /// Returns a shallow copy of this [InviteAccess]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  InviteAccess copyWith({
    String? token,
    String? email,
    String? role,
    DateTime? expiresAt,
    bool? recovery,
  }) {
    return InviteAccess(
      token: token ?? this.token,
      email: email ?? this.email,
      role: role ?? this.role,
      expiresAt: expiresAt ?? this.expiresAt,
      recovery: recovery ?? this.recovery,
    );
  }
}
