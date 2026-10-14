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

abstract class MaintenanceJob
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  MaintenanceJob._({
    this.id,
    required this.workspaceId,
    required this.unitId,
    required this.title,
    required this.notes,
    required this.dueAt,
    required this.cost,
    required this.status,
    required this.updatedAt,
  });

  factory MaintenanceJob({
    int? id,
    required int workspaceId,
    required int unitId,
    required String title,
    required String notes,
    required DateTime dueAt,
    required double cost,
    required String status,
    required DateTime updatedAt,
  }) = _MaintenanceJobImpl;

  factory MaintenanceJob.fromJson(Map<String, dynamic> jsonSerialization) {
    return MaintenanceJob(
      id: jsonSerialization['id'] as int?,
      workspaceId: jsonSerialization['workspaceId'] as int,
      unitId: jsonSerialization['unitId'] as int,
      title: jsonSerialization['title'] as String,
      notes: jsonSerialization['notes'] as String,
      dueAt: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['dueAt']),
      cost: (jsonSerialization['cost'] as num).toDouble(),
      status: jsonSerialization['status'] as String,
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int workspaceId;

  int unitId;

  String title;

  String notes;

  DateTime dueAt;

  double cost;

  String status;

  DateTime updatedAt;

  /// Returns a shallow copy of this [MaintenanceJob]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  MaintenanceJob copyWith({
    int? id,
    int? workspaceId,
    int? unitId,
    String? title,
    String? notes,
    DateTime? dueAt,
    double? cost,
    String? status,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MaintenanceJob',
      if (id != null) 'id': id,
      'workspaceId': workspaceId,
      'unitId': unitId,
      'title': title,
      'notes': notes,
      'dueAt': dueAt.toJson(),
      'cost': cost,
      'status': status,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MaintenanceJob',
      if (id != null) 'id': id,
      'workspaceId': workspaceId,
      'unitId': unitId,
      'title': title,
      'notes': notes,
      'dueAt': dueAt.toJson(),
      'cost': cost,
      'status': status,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MaintenanceJobImpl extends MaintenanceJob {
  _MaintenanceJobImpl({
    int? id,
    required int workspaceId,
    required int unitId,
    required String title,
    required String notes,
    required DateTime dueAt,
    required double cost,
    required String status,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         workspaceId: workspaceId,
         unitId: unitId,
         title: title,
         notes: notes,
         dueAt: dueAt,
         cost: cost,
         status: status,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [MaintenanceJob]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  MaintenanceJob copyWith({
    Object? id = _Undefined,
    int? workspaceId,
    int? unitId,
    String? title,
    String? notes,
    DateTime? dueAt,
    double? cost,
    String? status,
    DateTime? updatedAt,
  }) {
    return MaintenanceJob(
      id: id is int? ? id : this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      unitId: unitId ?? this.unitId,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      dueAt: dueAt ?? this.dueAt,
      cost: cost ?? this.cost,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
