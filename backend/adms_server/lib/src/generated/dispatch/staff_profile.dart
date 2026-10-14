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

abstract class StaffProfile
    implements _is.SerializableModel, _is.ProtocolSerialization {
  StaffProfile._({
    required this.id,
    required this.workspaceId,
    required this.name,
    required this.email,
    required this.role,
    required this.active,
    this.assignedUnitId,
  });

  factory StaffProfile({
    required int id,
    required int workspaceId,
    required String name,
    required String email,
    required String role,
    required bool active,
    int? assignedUnitId,
  }) = _StaffProfileImpl;

  factory StaffProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return StaffProfile(
      id: jsonSerialization['id'] as int,
      workspaceId: jsonSerialization['workspaceId'] as int,
      name: jsonSerialization['name'] as String,
      email: jsonSerialization['email'] as String,
      role: jsonSerialization['role'] as String,
      active: _is.BoolJsonExtension.fromJson(jsonSerialization['active']),
      assignedUnitId: jsonSerialization['assignedUnitId'] as int?,
    );
  }

  int id;

  int workspaceId;

  String name;

  String email;

  String role;

  bool active;

  int? assignedUnitId;

  /// Returns a shallow copy of this [StaffProfile]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  StaffProfile copyWith({
    int? id,
    int? workspaceId,
    String? name,
    String? email,
    String? role,
    bool? active,
    int? assignedUnitId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StaffProfile',
      'id': id,
      'workspaceId': workspaceId,
      'name': name,
      'email': email,
      'role': role,
      'active': active,
      if (assignedUnitId != null) 'assignedUnitId': assignedUnitId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StaffProfile',
      'id': id,
      'workspaceId': workspaceId,
      'name': name,
      'email': email,
      'role': role,
      'active': active,
      if (assignedUnitId != null) 'assignedUnitId': assignedUnitId,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StaffProfileImpl extends StaffProfile {
  _StaffProfileImpl({
    required int id,
    required int workspaceId,
    required String name,
    required String email,
    required String role,
    required bool active,
    int? assignedUnitId,
  }) : super._(
         id: id,
         workspaceId: workspaceId,
         name: name,
         email: email,
         role: role,
         active: active,
         assignedUnitId: assignedUnitId,
       );

  /// Returns a shallow copy of this [StaffProfile]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  StaffProfile copyWith({
    int? id,
    int? workspaceId,
    String? name,
    String? email,
    String? role,
    bool? active,
    Object? assignedUnitId = _Undefined,
  }) {
    return StaffProfile(
      id: id ?? this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      active: active ?? this.active,
      assignedUnitId: assignedUnitId is int?
          ? assignedUnitId
          : this.assignedUnitId,
    );
  }
}
