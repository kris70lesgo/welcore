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

abstract class DispatchUnit
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DispatchUnit._({
    this.id,
    this.plateNumber,
    this.unitType,
    bool? active,
    this.locationUpdatedAt,
    required this.workspaceId,
    required this.callSign,
    required this.crew,
    required this.latitude,
    required this.longitude,
    required this.status,
  }) : active = active ?? true;

  factory DispatchUnit({
    int? id,
    String? plateNumber,
    String? unitType,
    bool? active,
    DateTime? locationUpdatedAt,
    required int workspaceId,
    required String callSign,
    required String crew,
    required double latitude,
    required double longitude,
    required String status,
  }) = _DispatchUnitImpl;

  factory DispatchUnit.fromJson(Map<String, dynamic> jsonSerialization) {
    return DispatchUnit(
      id: jsonSerialization['id'] as int?,
      plateNumber: jsonSerialization['plateNumber'] as String?,
      unitType: jsonSerialization['unitType'] as String?,
      active: jsonSerialization['active'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['active']),
      locationUpdatedAt: jsonSerialization['locationUpdatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['locationUpdatedAt'],
            ),
      workspaceId: jsonSerialization['workspaceId'] as int,
      callSign: jsonSerialization['callSign'] as String,
      crew: jsonSerialization['crew'] as String,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      status: jsonSerialization['status'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String? plateNumber;

  String? unitType;

  bool active;

  DateTime? locationUpdatedAt;

  int workspaceId;

  String callSign;

  String crew;

  double latitude;

  double longitude;

  String status;

  /// Returns a shallow copy of this [DispatchUnit]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DispatchUnit copyWith({
    int? id,
    String? plateNumber,
    String? unitType,
    bool? active,
    DateTime? locationUpdatedAt,
    int? workspaceId,
    String? callSign,
    String? crew,
    double? latitude,
    double? longitude,
    String? status,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DispatchUnit',
      if (id != null) 'id': id,
      if (plateNumber != null) 'plateNumber': plateNumber,
      if (unitType != null) 'unitType': unitType,
      'active': active,
      if (locationUpdatedAt != null)
        'locationUpdatedAt': locationUpdatedAt?.toJson(),
      'workspaceId': workspaceId,
      'callSign': callSign,
      'crew': crew,
      'latitude': latitude,
      'longitude': longitude,
      'status': status,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DispatchUnit',
      if (id != null) 'id': id,
      if (plateNumber != null) 'plateNumber': plateNumber,
      if (unitType != null) 'unitType': unitType,
      'active': active,
      if (locationUpdatedAt != null)
        'locationUpdatedAt': locationUpdatedAt?.toJson(),
      'workspaceId': workspaceId,
      'callSign': callSign,
      'crew': crew,
      'latitude': latitude,
      'longitude': longitude,
      'status': status,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DispatchUnitImpl extends DispatchUnit {
  _DispatchUnitImpl({
    int? id,
    String? plateNumber,
    String? unitType,
    bool? active,
    DateTime? locationUpdatedAt,
    required int workspaceId,
    required String callSign,
    required String crew,
    required double latitude,
    required double longitude,
    required String status,
  }) : super._(
         id: id,
         plateNumber: plateNumber,
         unitType: unitType,
         active: active,
         locationUpdatedAt: locationUpdatedAt,
         workspaceId: workspaceId,
         callSign: callSign,
         crew: crew,
         latitude: latitude,
         longitude: longitude,
         status: status,
       );

  /// Returns a shallow copy of this [DispatchUnit]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DispatchUnit copyWith({
    Object? id = _Undefined,
    Object? plateNumber = _Undefined,
    Object? unitType = _Undefined,
    bool? active,
    Object? locationUpdatedAt = _Undefined,
    int? workspaceId,
    String? callSign,
    String? crew,
    double? latitude,
    double? longitude,
    String? status,
  }) {
    return DispatchUnit(
      id: id is int? ? id : this.id,
      plateNumber: plateNumber is String? ? plateNumber : this.plateNumber,
      unitType: unitType is String? ? unitType : this.unitType,
      active: active ?? this.active,
      locationUpdatedAt: locationUpdatedAt is DateTime?
          ? locationUpdatedAt
          : this.locationUpdatedAt,
      workspaceId: workspaceId ?? this.workspaceId,
      callSign: callSign ?? this.callSign,
      crew: crew ?? this.crew,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      status: status ?? this.status,
    );
  }
}
