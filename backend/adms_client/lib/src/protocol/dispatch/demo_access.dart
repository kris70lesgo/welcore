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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class DemoAccess
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DemoAccess._({required this.token, required this.expiresAt});

  factory DemoAccess({required String token, required DateTime expiresAt}) =
      _DemoAccessImpl;

  factory DemoAccess.fromJson(Map<String, dynamic> jsonSerialization) {
    return DemoAccess(
      token: jsonSerialization['token'] as String,
      expiresAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
    );
  }

  String token;

  DateTime expiresAt;

  /// Returns a shallow copy of this [DemoAccess]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DemoAccess copyWith({String? token, DateTime? expiresAt});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DemoAccess',
      'token': token,
      'expiresAt': expiresAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DemoAccess',
      'token': token,
      'expiresAt': expiresAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _DemoAccessImpl extends DemoAccess {
  _DemoAccessImpl({required String token, required DateTime expiresAt})
    : super._(token: token, expiresAt: expiresAt);

  /// Returns a shallow copy of this [DemoAccess]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DemoAccess copyWith({String? token, DateTime? expiresAt}) {
    return DemoAccess(
      token: token ?? this.token,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }
}
