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

abstract class CareReport
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CareReport._({
    this.id,
    required this.workspaceId,
    required this.incidentId,
    required this.patientName,
    this.age,
    required this.condition,
    this.pulse,
    this.systolic,
    this.diastolic,
    this.oxygenSaturation,
    required this.treatment,
    required this.notes,
    required this.handedOverTo,
    required this.signedOff,
    required this.updatedAt,
  });

  factory CareReport({
    int? id,
    required int workspaceId,
    required int incidentId,
    required String patientName,
    int? age,
    required String condition,
    int? pulse,
    int? systolic,
    int? diastolic,
    int? oxygenSaturation,
    required String treatment,
    required String notes,
    required String handedOverTo,
    required bool signedOff,
    required DateTime updatedAt,
  }) = _CareReportImpl;

  factory CareReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return CareReport(
      id: jsonSerialization['id'] as int?,
      workspaceId: jsonSerialization['workspaceId'] as int,
      incidentId: jsonSerialization['incidentId'] as int,
      patientName: jsonSerialization['patientName'] as String,
      age: jsonSerialization['age'] as int?,
      condition: jsonSerialization['condition'] as String,
      pulse: jsonSerialization['pulse'] as int?,
      systolic: jsonSerialization['systolic'] as int?,
      diastolic: jsonSerialization['diastolic'] as int?,
      oxygenSaturation: jsonSerialization['oxygenSaturation'] as int?,
      treatment: jsonSerialization['treatment'] as String,
      notes: jsonSerialization['notes'] as String,
      handedOverTo: jsonSerialization['handedOverTo'] as String,
      signedOff: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['signedOff'],
      ),
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

  int incidentId;

  String patientName;

  int? age;

  String condition;

  int? pulse;

  int? systolic;

  int? diastolic;

  int? oxygenSaturation;

  String treatment;

  String notes;

  String handedOverTo;

  bool signedOff;

  DateTime updatedAt;

  /// Returns a shallow copy of this [CareReport]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CareReport copyWith({
    int? id,
    int? workspaceId,
    int? incidentId,
    String? patientName,
    int? age,
    String? condition,
    int? pulse,
    int? systolic,
    int? diastolic,
    int? oxygenSaturation,
    String? treatment,
    String? notes,
    String? handedOverTo,
    bool? signedOff,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CareReport',
      if (id != null) 'id': id,
      'workspaceId': workspaceId,
      'incidentId': incidentId,
      'patientName': patientName,
      if (age != null) 'age': age,
      'condition': condition,
      if (pulse != null) 'pulse': pulse,
      if (systolic != null) 'systolic': systolic,
      if (diastolic != null) 'diastolic': diastolic,
      if (oxygenSaturation != null) 'oxygenSaturation': oxygenSaturation,
      'treatment': treatment,
      'notes': notes,
      'handedOverTo': handedOverTo,
      'signedOff': signedOff,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CareReport',
      if (id != null) 'id': id,
      'workspaceId': workspaceId,
      'incidentId': incidentId,
      'patientName': patientName,
      if (age != null) 'age': age,
      'condition': condition,
      if (pulse != null) 'pulse': pulse,
      if (systolic != null) 'systolic': systolic,
      if (diastolic != null) 'diastolic': diastolic,
      if (oxygenSaturation != null) 'oxygenSaturation': oxygenSaturation,
      'treatment': treatment,
      'notes': notes,
      'handedOverTo': handedOverTo,
      'signedOff': signedOff,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CareReportImpl extends CareReport {
  _CareReportImpl({
    int? id,
    required int workspaceId,
    required int incidentId,
    required String patientName,
    int? age,
    required String condition,
    int? pulse,
    int? systolic,
    int? diastolic,
    int? oxygenSaturation,
    required String treatment,
    required String notes,
    required String handedOverTo,
    required bool signedOff,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         workspaceId: workspaceId,
         incidentId: incidentId,
         patientName: patientName,
         age: age,
         condition: condition,
         pulse: pulse,
         systolic: systolic,
         diastolic: diastolic,
         oxygenSaturation: oxygenSaturation,
         treatment: treatment,
         notes: notes,
         handedOverTo: handedOverTo,
         signedOff: signedOff,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [CareReport]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CareReport copyWith({
    Object? id = _Undefined,
    int? workspaceId,
    int? incidentId,
    String? patientName,
    Object? age = _Undefined,
    String? condition,
    Object? pulse = _Undefined,
    Object? systolic = _Undefined,
    Object? diastolic = _Undefined,
    Object? oxygenSaturation = _Undefined,
    String? treatment,
    String? notes,
    String? handedOverTo,
    bool? signedOff,
    DateTime? updatedAt,
  }) {
    return CareReport(
      id: id is int? ? id : this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      incidentId: incidentId ?? this.incidentId,
      patientName: patientName ?? this.patientName,
      age: age is int? ? age : this.age,
      condition: condition ?? this.condition,
      pulse: pulse is int? ? pulse : this.pulse,
      systolic: systolic is int? ? systolic : this.systolic,
      diastolic: diastolic is int? ? diastolic : this.diastolic,
      oxygenSaturation: oxygenSaturation is int?
          ? oxygenSaturation
          : this.oxygenSaturation,
      treatment: treatment ?? this.treatment,
      notes: notes ?? this.notes,
      handedOverTo: handedOverTo ?? this.handedOverTo,
      signedOff: signedOff ?? this.signedOff,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
