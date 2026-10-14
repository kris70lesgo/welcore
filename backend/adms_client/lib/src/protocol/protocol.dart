/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'dispatch/auth_access.dart' as _i8nqich0;
import 'dispatch/care_report.dart' as _ioq64fq7;
import 'dispatch/demo_access.dart' as _ibw91gj7;
import 'dispatch/dispatch_event.dart' as _i3il5by7;
import 'dispatch/dispatch_exception.dart' as _ianatnwr;
import 'dispatch/dispatch_incident.dart' as _ij4w9jgx;
import 'dispatch/dispatch_snapshot.dart' as _iua6f297;
import 'dispatch/dispatch_unit.dart' as _iyuv25k5;
import 'dispatch/hospital.dart' as _i10k8j4y;
import 'dispatch/invite_access.dart' as _i1mq8ass;
import 'dispatch/maintenance_job.dart' as _iwc209pn;
import 'dispatch/staff_profile.dart' as _inpgeoak;
import 'dispatch/workspace_config.dart' as _i7a46nnq;
export 'dispatch/auth_access.dart';
export 'dispatch/care_report.dart';
export 'dispatch/demo_access.dart';
export 'dispatch/dispatch_event.dart';
export 'dispatch/dispatch_exception.dart';
export 'dispatch/dispatch_incident.dart';
export 'dispatch/dispatch_snapshot.dart';
export 'dispatch/dispatch_unit.dart';
export 'dispatch/hospital.dart';
export 'dispatch/invite_access.dart';
export 'dispatch/maintenance_job.dart';
export 'dispatch/staff_profile.dart';
export 'dispatch/workspace_config.dart';
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(dynamic data, [Type? t]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i8nqich0.AuthAccess) {
      return _i8nqich0.AuthAccess.fromJson(data) as T;
    }
    if (t == _ioq64fq7.CareReport) {
      return _ioq64fq7.CareReport.fromJson(data) as T;
    }
    if (t == _ibw91gj7.DemoAccess) {
      return _ibw91gj7.DemoAccess.fromJson(data) as T;
    }
    if (t == _i3il5by7.DispatchEvent) {
      return _i3il5by7.DispatchEvent.fromJson(data) as T;
    }
    if (t == _ianatnwr.DispatchException) {
      return _ianatnwr.DispatchException.fromJson(data) as T;
    }
    if (t == _ij4w9jgx.DispatchIncident) {
      return _ij4w9jgx.DispatchIncident.fromJson(data) as T;
    }
    if (t == _iua6f297.DispatchSnapshot) {
      return _iua6f297.DispatchSnapshot.fromJson(data) as T;
    }
    if (t == _iyuv25k5.DispatchUnit) {
      return _iyuv25k5.DispatchUnit.fromJson(data) as T;
    }
    if (t == _i10k8j4y.Hospital) {
      return _i10k8j4y.Hospital.fromJson(data) as T;
    }
    if (t == _i1mq8ass.InviteAccess) {
      return _i1mq8ass.InviteAccess.fromJson(data) as T;
    }
    if (t == _iwc209pn.MaintenanceJob) {
      return _iwc209pn.MaintenanceJob.fromJson(data) as T;
    }
    if (t == _inpgeoak.StaffProfile) {
      return _inpgeoak.StaffProfile.fromJson(data) as T;
    }
    if (t == _i7a46nnq.WorkspaceConfig) {
      return _i7a46nnq.WorkspaceConfig.fromJson(data) as T;
    }
    if (t == _isc.getType<_i8nqich0.AuthAccess?>()) {
      return (data != null ? _i8nqich0.AuthAccess.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ioq64fq7.CareReport?>()) {
      return (data != null ? _ioq64fq7.CareReport.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ibw91gj7.DemoAccess?>()) {
      return (data != null ? _ibw91gj7.DemoAccess.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i3il5by7.DispatchEvent?>()) {
      return (data != null ? _i3il5by7.DispatchEvent.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ianatnwr.DispatchException?>()) {
      return (data != null ? _ianatnwr.DispatchException.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ij4w9jgx.DispatchIncident?>()) {
      return (data != null ? _ij4w9jgx.DispatchIncident.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iua6f297.DispatchSnapshot?>()) {
      return (data != null ? _iua6f297.DispatchSnapshot.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iyuv25k5.DispatchUnit?>()) {
      return (data != null ? _iyuv25k5.DispatchUnit.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i10k8j4y.Hospital?>()) {
      return (data != null ? _i10k8j4y.Hospital.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i1mq8ass.InviteAccess?>()) {
      return (data != null ? _i1mq8ass.InviteAccess.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iwc209pn.MaintenanceJob?>()) {
      return (data != null ? _iwc209pn.MaintenanceJob.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_inpgeoak.StaffProfile?>()) {
      return (data != null ? _inpgeoak.StaffProfile.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i7a46nnq.WorkspaceConfig?>()) {
      return (data != null ? _i7a46nnq.WorkspaceConfig.fromJson(data) : null)
          as T;
    }
    if (t == List<_i10k8j4y.Hospital>) {
      return (data as List)
              .map((e) => deserialize<_i10k8j4y.Hospital>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_i10k8j4y.Hospital>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i10k8j4y.Hospital>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_ioq64fq7.CareReport>) {
      return (data as List)
              .map((e) => deserialize<_ioq64fq7.CareReport>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_ioq64fq7.CareReport>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_ioq64fq7.CareReport>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_iwc209pn.MaintenanceJob>) {
      return (data as List)
              .map((e) => deserialize<_iwc209pn.MaintenanceJob>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_iwc209pn.MaintenanceJob>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_iwc209pn.MaintenanceJob>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_inpgeoak.StaffProfile>) {
      return (data as List)
              .map((e) => deserialize<_inpgeoak.StaffProfile>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_inpgeoak.StaffProfile>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_inpgeoak.StaffProfile>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_ij4w9jgx.DispatchIncident>) {
      return (data as List)
              .map((e) => deserialize<_ij4w9jgx.DispatchIncident>(e))
              .toList()
          as T;
    }
    if (t == List<_iyuv25k5.DispatchUnit>) {
      return (data as List)
              .map((e) => deserialize<_iyuv25k5.DispatchUnit>(e))
              .toList()
          as T;
    }
    if (t == List<_i3il5by7.DispatchEvent>) {
      return (data as List)
              .map((e) => deserialize<_i3il5by7.DispatchEvent>(e))
              .toList()
          as T;
    }
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i8nqich0.AuthAccess => 'AuthAccess',
      _ioq64fq7.CareReport => 'CareReport',
      _ibw91gj7.DemoAccess => 'DemoAccess',
      _i3il5by7.DispatchEvent => 'DispatchEvent',
      _ianatnwr.DispatchException => 'DispatchException',
      _ij4w9jgx.DispatchIncident => 'DispatchIncident',
      _iua6f297.DispatchSnapshot => 'DispatchSnapshot',
      _iyuv25k5.DispatchUnit => 'DispatchUnit',
      _i10k8j4y.Hospital => 'Hospital',
      _i1mq8ass.InviteAccess => 'InviteAccess',
      _iwc209pn.MaintenanceJob => 'MaintenanceJob',
      _inpgeoak.StaffProfile => 'StaffProfile',
      _i7a46nnq.WorkspaceConfig => 'WorkspaceConfig',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('adms.', '');
    }

    switch (data) {
      case _i8nqich0.AuthAccess():
        return 'AuthAccess';
      case _ioq64fq7.CareReport():
        return 'CareReport';
      case _ibw91gj7.DemoAccess():
        return 'DemoAccess';
      case _i3il5by7.DispatchEvent():
        return 'DispatchEvent';
      case _ianatnwr.DispatchException():
        return 'DispatchException';
      case _ij4w9jgx.DispatchIncident():
        return 'DispatchIncident';
      case _iua6f297.DispatchSnapshot():
        return 'DispatchSnapshot';
      case _iyuv25k5.DispatchUnit():
        return 'DispatchUnit';
      case _i10k8j4y.Hospital():
        return 'Hospital';
      case _i1mq8ass.InviteAccess():
        return 'InviteAccess';
      case _iwc209pn.MaintenanceJob():
        return 'MaintenanceJob';
      case _inpgeoak.StaffProfile():
        return 'StaffProfile';
      case _i7a46nnq.WorkspaceConfig():
        return 'WorkspaceConfig';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AuthAccess') {
      return deserialize<_i8nqich0.AuthAccess>(data['data']);
    }
    if (dataClassName == 'CareReport') {
      return deserialize<_ioq64fq7.CareReport>(data['data']);
    }
    if (dataClassName == 'DemoAccess') {
      return deserialize<_ibw91gj7.DemoAccess>(data['data']);
    }
    if (dataClassName == 'DispatchEvent') {
      return deserialize<_i3il5by7.DispatchEvent>(data['data']);
    }
    if (dataClassName == 'DispatchException') {
      return deserialize<_ianatnwr.DispatchException>(data['data']);
    }
    if (dataClassName == 'DispatchIncident') {
      return deserialize<_ij4w9jgx.DispatchIncident>(data['data']);
    }
    if (dataClassName == 'DispatchSnapshot') {
      return deserialize<_iua6f297.DispatchSnapshot>(data['data']);
    }
    if (dataClassName == 'DispatchUnit') {
      return deserialize<_iyuv25k5.DispatchUnit>(data['data']);
    }
    if (dataClassName == 'Hospital') {
      return deserialize<_i10k8j4y.Hospital>(data['data']);
    }
    if (dataClassName == 'InviteAccess') {
      return deserialize<_i1mq8ass.InviteAccess>(data['data']);
    }
    if (dataClassName == 'MaintenanceJob') {
      return deserialize<_iwc209pn.MaintenanceJob>(data['data']);
    }
    if (dataClassName == 'StaffProfile') {
      return deserialize<_inpgeoak.StaffProfile>(data['data']);
    }
    if (dataClassName == 'WorkspaceConfig') {
      return deserialize<_i7a46nnq.WorkspaceConfig>(data['data']);
    }
    return super.deserializeByClassName(data);
  }

  @override
  String getModuleName() => 'adms';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
