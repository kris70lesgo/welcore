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

abstract class DispatchIncident
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DispatchIncident._({
    this.id,
    this.reporterAccountId,
    this.destinationHospitalId,
    this.destinationHospitalName,
    required this.workspaceId,
    required this.description,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.severity,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.assignedUnitId,
    this.assignedCallSign,
    this.dispatchDistanceKm,
    this.dispatchedAt,
    this.onSceneAt,
    this.resolvedAt,
  });

  factory DispatchIncident({
    int? id,
    int? reporterAccountId,
    int? destinationHospitalId,
    String? destinationHospitalName,
    required int workspaceId,
    required String description,
    required String address,
    required double latitude,
    required double longitude,
    required String severity,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
    int? assignedUnitId,
    String? assignedCallSign,
    double? dispatchDistanceKm,
    DateTime? dispatchedAt,
    DateTime? onSceneAt,
    DateTime? resolvedAt,
  }) = _DispatchIncidentImpl;

  factory DispatchIncident.fromJson(Map<String, dynamic> jsonSerialization) {
    return DispatchIncident(
      id: jsonSerialization['id'] as int?,
      reporterAccountId: jsonSerialization['reporterAccountId'] as int?,
      destinationHospitalId: jsonSerialization['destinationHospitalId'] as int?,
      destinationHospitalName:
          jsonSerialization['destinationHospitalName'] as String?,
      workspaceId: jsonSerialization['workspaceId'] as int,
      description: jsonSerialization['description'] as String,
      address: jsonSerialization['address'] as String,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      severity: jsonSerialization['severity'] as String,
      status: jsonSerialization['status'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
      assignedUnitId: jsonSerialization['assignedUnitId'] as int?,
      assignedCallSign: jsonSerialization['assignedCallSign'] as String?,
      dispatchDistanceKm: (jsonSerialization['dispatchDistanceKm'] as num?)
          ?.toDouble(),
      dispatchedAt: jsonSerialization['dispatchedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['dispatchedAt'],
            ),
      onSceneAt: jsonSerialization['onSceneAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['onSceneAt']),
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['resolvedAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int? reporterAccountId;

  int? destinationHospitalId;

  String? destinationHospitalName;

  int workspaceId;

  String description;

  String address;

  double latitude;

  double longitude;

  String severity;

  String status;

  DateTime createdAt;

  DateTime updatedAt;

  int? assignedUnitId;

  String? assignedCallSign;

  double? dispatchDistanceKm;

  DateTime? dispatchedAt;

  DateTime? onSceneAt;

  DateTime? resolvedAt;

  /// Returns a shallow copy of this [DispatchIncident]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DispatchIncident copyWith({
    int? id,
    int? reporterAccountId,
    int? destinationHospitalId,
    String? destinationHospitalName,
    int? workspaceId,
    String? description,
    String? address,
    double? latitude,
    double? longitude,
    String? severity,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? assignedUnitId,
    String? assignedCallSign,
    double? dispatchDistanceKm,
    DateTime? dispatchedAt,
    DateTime? onSceneAt,
    DateTime? resolvedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DispatchIncident',
      if (id != null) 'id': id,
      if (reporterAccountId != null) 'reporterAccountId': reporterAccountId,
      if (destinationHospitalId != null)
        'destinationHospitalId': destinationHospitalId,
      if (destinationHospitalName != null)
        'destinationHospitalName': destinationHospitalName,
      'workspaceId': workspaceId,
      'description': description,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'severity': severity,
      'status': status,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (assignedUnitId != null) 'assignedUnitId': assignedUnitId,
      if (assignedCallSign != null) 'assignedCallSign': assignedCallSign,
      if (dispatchDistanceKm != null) 'dispatchDistanceKm': dispatchDistanceKm,
      if (dispatchedAt != null) 'dispatchedAt': dispatchedAt?.toJson(),
      if (onSceneAt != null) 'onSceneAt': onSceneAt?.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DispatchIncident',
      if (id != null) 'id': id,
      if (reporterAccountId != null) 'reporterAccountId': reporterAccountId,
      if (destinationHospitalId != null)
        'destinationHospitalId': destinationHospitalId,
      if (destinationHospitalName != null)
        'destinationHospitalName': destinationHospitalName,
      'workspaceId': workspaceId,
      'description': description,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'severity': severity,
      'status': status,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (assignedUnitId != null) 'assignedUnitId': assignedUnitId,
      if (assignedCallSign != null) 'assignedCallSign': assignedCallSign,
      if (dispatchDistanceKm != null) 'dispatchDistanceKm': dispatchDistanceKm,
      if (dispatchedAt != null) 'dispatchedAt': dispatchedAt?.toJson(),
      if (onSceneAt != null) 'onSceneAt': onSceneAt?.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DispatchIncidentImpl extends DispatchIncident {
  _DispatchIncidentImpl({
    int? id,
    int? reporterAccountId,
    int? destinationHospitalId,
    String? destinationHospitalName,
    required int workspaceId,
    required String description,
    required String address,
    required double latitude,
    required double longitude,
    required String severity,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
    int? assignedUnitId,
    String? assignedCallSign,
    double? dispatchDistanceKm,
    DateTime? dispatchedAt,
    DateTime? onSceneAt,
    DateTime? resolvedAt,
  }) : super._(
         id: id,
         reporterAccountId: reporterAccountId,
         destinationHospitalId: destinationHospitalId,
         destinationHospitalName: destinationHospitalName,
         workspaceId: workspaceId,
         description: description,
         address: address,
         latitude: latitude,
         longitude: longitude,
         severity: severity,
         status: status,
         createdAt: createdAt,
         updatedAt: updatedAt,
         assignedUnitId: assignedUnitId,
         assignedCallSign: assignedCallSign,
         dispatchDistanceKm: dispatchDistanceKm,
         dispatchedAt: dispatchedAt,
         onSceneAt: onSceneAt,
         resolvedAt: resolvedAt,
       );

  /// Returns a shallow copy of this [DispatchIncident]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DispatchIncident copyWith({
    Object? id = _Undefined,
    Object? reporterAccountId = _Undefined,
    Object? destinationHospitalId = _Undefined,
    Object? destinationHospitalName = _Undefined,
    int? workspaceId,
    String? description,
    String? address,
    double? latitude,
    double? longitude,
    String? severity,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? assignedUnitId = _Undefined,
    Object? assignedCallSign = _Undefined,
    Object? dispatchDistanceKm = _Undefined,
    Object? dispatchedAt = _Undefined,
    Object? onSceneAt = _Undefined,
    Object? resolvedAt = _Undefined,
  }) {
    return DispatchIncident(
      id: id is int? ? id : this.id,
      reporterAccountId: reporterAccountId is int?
          ? reporterAccountId
          : this.reporterAccountId,
      destinationHospitalId: destinationHospitalId is int?
          ? destinationHospitalId
          : this.destinationHospitalId,
      destinationHospitalName: destinationHospitalName is String?
          ? destinationHospitalName
          : this.destinationHospitalName,
      workspaceId: workspaceId ?? this.workspaceId,
      description: description ?? this.description,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      severity: severity ?? this.severity,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      assignedUnitId: assignedUnitId is int?
          ? assignedUnitId
          : this.assignedUnitId,
      assignedCallSign: assignedCallSign is String?
          ? assignedCallSign
          : this.assignedCallSign,
      dispatchDistanceKm: dispatchDistanceKm is double?
          ? dispatchDistanceKm
          : this.dispatchDistanceKm,
      dispatchedAt: dispatchedAt is DateTime?
          ? dispatchedAt
          : this.dispatchedAt,
      onSceneAt: onSceneAt is DateTime? ? onSceneAt : this.onSceneAt,
      resolvedAt: resolvedAt is DateTime? ? resolvedAt : this.resolvedAt,
    );
  }
}
