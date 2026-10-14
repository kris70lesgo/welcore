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

abstract class DispatchEvent
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DispatchEvent._({
    this.id,
    required this.workspaceId,
    required this.incidentId,
    required this.message,
    required this.status,
    required this.createdAt,
  });

  factory DispatchEvent({
    int? id,
    required int workspaceId,
    required int incidentId,
    required String message,
    required String status,
    required DateTime createdAt,
  }) = _DispatchEventImpl;

  factory DispatchEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return DispatchEvent(
      id: jsonSerialization['id'] as int?,
      workspaceId: jsonSerialization['workspaceId'] as int,
      incidentId: jsonSerialization['incidentId'] as int,
      message: jsonSerialization['message'] as String,
      status: jsonSerialization['status'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int workspaceId;

  int incidentId;

  String message;

  String status;

  DateTime createdAt;

  /// Returns a shallow copy of this [DispatchEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DispatchEvent copyWith({
    int? id,
    int? workspaceId,
    int? incidentId,
    String? message,
    String? status,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DispatchEvent',
      if (id != null) 'id': id,
      'workspaceId': workspaceId,
      'incidentId': incidentId,
      'message': message,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DispatchEvent',
      if (id != null) 'id': id,
      'workspaceId': workspaceId,
      'incidentId': incidentId,
      'message': message,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DispatchEventImpl extends DispatchEvent {
  _DispatchEventImpl({
    int? id,
    required int workspaceId,
    required int incidentId,
    required String message,
    required String status,
    required DateTime createdAt,
  }) : super._(
         id: id,
         workspaceId: workspaceId,
         incidentId: incidentId,
         message: message,
         status: status,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [DispatchEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DispatchEvent copyWith({
    Object? id = _Undefined,
    int? workspaceId,
    int? incidentId,
    String? message,
    String? status,
    DateTime? createdAt,
  }) {
    return DispatchEvent(
      id: id is int? ? id : this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      incidentId: incidentId ?? this.incidentId,
      message: message ?? this.message,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
