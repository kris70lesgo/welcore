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

abstract class Hospital
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Hospital._({
    this.id,
    required this.workspaceId,
    required this.name,
    required this.address,
    required this.phone,
    required this.latitude,
    required this.longitude,
    required this.active,
  });

  factory Hospital({
    int? id,
    required int workspaceId,
    required String name,
    required String address,
    required String phone,
    required double latitude,
    required double longitude,
    required bool active,
  }) = _HospitalImpl;

  factory Hospital.fromJson(Map<String, dynamic> jsonSerialization) {
    return Hospital(
      id: jsonSerialization['id'] as int?,
      workspaceId: jsonSerialization['workspaceId'] as int,
      name: jsonSerialization['name'] as String,
      address: jsonSerialization['address'] as String,
      phone: jsonSerialization['phone'] as String,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      active: _isc.BoolJsonExtension.fromJson(jsonSerialization['active']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int workspaceId;

  String name;

  String address;

  String phone;

  double latitude;

  double longitude;

  bool active;

  /// Returns a shallow copy of this [Hospital]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Hospital copyWith({
    int? id,
    int? workspaceId,
    String? name,
    String? address,
    String? phone,
    double? latitude,
    double? longitude,
    bool? active,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Hospital',
      if (id != null) 'id': id,
      'workspaceId': workspaceId,
      'name': name,
      'address': address,
      'phone': phone,
      'latitude': latitude,
      'longitude': longitude,
      'active': active,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Hospital',
      if (id != null) 'id': id,
      'workspaceId': workspaceId,
      'name': name,
      'address': address,
      'phone': phone,
      'latitude': latitude,
      'longitude': longitude,
      'active': active,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _HospitalImpl extends Hospital {
  _HospitalImpl({
    int? id,
    required int workspaceId,
    required String name,
    required String address,
    required String phone,
    required double latitude,
    required double longitude,
    required bool active,
  }) : super._(
         id: id,
         workspaceId: workspaceId,
         name: name,
         address: address,
         phone: phone,
         latitude: latitude,
         longitude: longitude,
         active: active,
       );

  /// Returns a shallow copy of this [Hospital]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Hospital copyWith({
    Object? id = _Undefined,
    int? workspaceId,
    String? name,
    String? address,
    String? phone,
    double? latitude,
    double? longitude,
    bool? active,
  }) {
    return Hospital(
      id: id is int? ? id : this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      active: active ?? this.active,
    );
  }
}
