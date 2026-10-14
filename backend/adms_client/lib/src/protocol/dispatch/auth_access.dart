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
import 'package:adms_client/src/protocol/protocol.dart' as _izc5jg43;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../dispatch/staff_profile.dart' as _in2s7pyn;

abstract class AuthAccess
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AuthAccess._({
    this.recoveryCode,
    required this.token,
    required this.expiresAt,
    required this.profile,
  });

  factory AuthAccess({
    String? recoveryCode,
    required String token,
    required DateTime expiresAt,
    required _in2s7pyn.StaffProfile profile,
  }) = _AuthAccessImpl;

  factory AuthAccess.fromJson(Map<String, dynamic> jsonSerialization) {
    return AuthAccess(
      recoveryCode: jsonSerialization['recoveryCode'] as String?,
      token: jsonSerialization['token'] as String,
      expiresAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      profile: _izc5jg43.Protocol().deserialize<_in2s7pyn.StaffProfile>(
        jsonSerialization['profile'],
      ),
    );
  }

  String? recoveryCode;

  String token;

  DateTime expiresAt;

  _in2s7pyn.StaffProfile profile;

  /// Returns a shallow copy of this [AuthAccess]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AuthAccess copyWith({
    String? recoveryCode,
    String? token,
    DateTime? expiresAt,
    _in2s7pyn.StaffProfile? profile,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AuthAccess',
      if (recoveryCode != null) 'recoveryCode': recoveryCode,
      'token': token,
      'expiresAt': expiresAt.toJson(),
      'profile': profile.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AuthAccess',
      if (recoveryCode != null) 'recoveryCode': recoveryCode,
      'token': token,
      'expiresAt': expiresAt.toJson(),
      'profile': profile.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AuthAccessImpl extends AuthAccess {
  _AuthAccessImpl({
    String? recoveryCode,
    required String token,
    required DateTime expiresAt,
    required _in2s7pyn.StaffProfile profile,
  }) : super._(
         recoveryCode: recoveryCode,
         token: token,
         expiresAt: expiresAt,
         profile: profile,
       );

  /// Returns a shallow copy of this [AuthAccess]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AuthAccess copyWith({
    Object? recoveryCode = _Undefined,
    String? token,
    DateTime? expiresAt,
    _in2s7pyn.StaffProfile? profile,
  }) {
    return AuthAccess(
      recoveryCode: recoveryCode is String? ? recoveryCode : this.recoveryCode,
      token: token ?? this.token,
      expiresAt: expiresAt ?? this.expiresAt,
      profile: profile ?? this.profile.copyWith(),
    );
  }
}
