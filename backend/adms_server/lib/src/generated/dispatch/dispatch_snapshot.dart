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
import 'package:adms_server/src/generated/protocol.dart' as _iip78cvr;
import 'package:serverpod/serverpod.dart' as _is;
import '../dispatch/care_report.dart' as _i48hck61;
import '../dispatch/dispatch_event.dart' as _iehe6quo;
import '../dispatch/dispatch_incident.dart' as _ihycgcni;
import '../dispatch/dispatch_unit.dart' as _i7xsrkiu;
import '../dispatch/hospital.dart' as _icwu3xng;
import '../dispatch/maintenance_job.dart' as _it7q91u3;
import '../dispatch/staff_profile.dart' as _in2s7pyn;
import '../dispatch/workspace_config.dart' as _ia75lo3t;

abstract class DispatchSnapshot
    implements _is.SerializableModel, _is.ProtocolSerialization {
  DispatchSnapshot._({
    this.viewer,
    this.config,
    this.hospitals,
    this.careReports,
    this.maintenance,
    this.staff,
    required this.revision,
    required this.incidents,
    required this.units,
    required this.events,
    required this.serverTime,
  });

  factory DispatchSnapshot({
    _in2s7pyn.StaffProfile? viewer,
    _ia75lo3t.WorkspaceConfig? config,
    List<_icwu3xng.Hospital>? hospitals,
    List<_i48hck61.CareReport>? careReports,
    List<_it7q91u3.MaintenanceJob>? maintenance,
    List<_in2s7pyn.StaffProfile>? staff,
    required int revision,
    required List<_ihycgcni.DispatchIncident> incidents,
    required List<_i7xsrkiu.DispatchUnit> units,
    required List<_iehe6quo.DispatchEvent> events,
    required DateTime serverTime,
  }) = _DispatchSnapshotImpl;

  factory DispatchSnapshot.fromJson(Map<String, dynamic> jsonSerialization) {
    return DispatchSnapshot(
      viewer: jsonSerialization['viewer'] == null
          ? null
          : _iip78cvr.Protocol().deserialize<_in2s7pyn.StaffProfile>(
              jsonSerialization['viewer'],
            ),
      config: jsonSerialization['config'] == null
          ? null
          : _iip78cvr.Protocol().deserialize<_ia75lo3t.WorkspaceConfig>(
              jsonSerialization['config'],
            ),
      hospitals: jsonSerialization['hospitals'] == null
          ? null
          : _iip78cvr.Protocol().deserialize<List<_icwu3xng.Hospital>>(
              jsonSerialization['hospitals'],
            ),
      careReports: jsonSerialization['careReports'] == null
          ? null
          : _iip78cvr.Protocol().deserialize<List<_i48hck61.CareReport>>(
              jsonSerialization['careReports'],
            ),
      maintenance: jsonSerialization['maintenance'] == null
          ? null
          : _iip78cvr.Protocol().deserialize<List<_it7q91u3.MaintenanceJob>>(
              jsonSerialization['maintenance'],
            ),
      staff: jsonSerialization['staff'] == null
          ? null
          : _iip78cvr.Protocol().deserialize<List<_in2s7pyn.StaffProfile>>(
              jsonSerialization['staff'],
            ),
      revision: jsonSerialization['revision'] as int,
      incidents: _iip78cvr.Protocol()
          .deserialize<List<_ihycgcni.DispatchIncident>>(
            jsonSerialization['incidents'],
          ),
      units: _iip78cvr.Protocol().deserialize<List<_i7xsrkiu.DispatchUnit>>(
        jsonSerialization['units'],
      ),
      events: _iip78cvr.Protocol().deserialize<List<_iehe6quo.DispatchEvent>>(
        jsonSerialization['events'],
      ),
      serverTime: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['serverTime'],
      ),
    );
  }

  _in2s7pyn.StaffProfile? viewer;

  _ia75lo3t.WorkspaceConfig? config;

  List<_icwu3xng.Hospital>? hospitals;

  List<_i48hck61.CareReport>? careReports;

  List<_it7q91u3.MaintenanceJob>? maintenance;

  List<_in2s7pyn.StaffProfile>? staff;

  int revision;

  List<_ihycgcni.DispatchIncident> incidents;

  List<_i7xsrkiu.DispatchUnit> units;

  List<_iehe6quo.DispatchEvent> events;

  DateTime serverTime;

  /// Returns a shallow copy of this [DispatchSnapshot]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DispatchSnapshot copyWith({
    _in2s7pyn.StaffProfile? viewer,
    _ia75lo3t.WorkspaceConfig? config,
    List<_icwu3xng.Hospital>? hospitals,
    List<_i48hck61.CareReport>? careReports,
    List<_it7q91u3.MaintenanceJob>? maintenance,
    List<_in2s7pyn.StaffProfile>? staff,
    int? revision,
    List<_ihycgcni.DispatchIncident>? incidents,
    List<_i7xsrkiu.DispatchUnit>? units,
    List<_iehe6quo.DispatchEvent>? events,
    DateTime? serverTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DispatchSnapshot',
      if (viewer != null) 'viewer': viewer?.toJson(),
      if (config != null) 'config': config?.toJson(),
      if (hospitals != null)
        'hospitals': hospitals?.toJson(valueToJson: (v) => v.toJson()),
      if (careReports != null)
        'careReports': careReports?.toJson(valueToJson: (v) => v.toJson()),
      if (maintenance != null)
        'maintenance': maintenance?.toJson(valueToJson: (v) => v.toJson()),
      if (staff != null) 'staff': staff?.toJson(valueToJson: (v) => v.toJson()),
      'revision': revision,
      'incidents': incidents.toJson(valueToJson: (v) => v.toJson()),
      'units': units.toJson(valueToJson: (v) => v.toJson()),
      'events': events.toJson(valueToJson: (v) => v.toJson()),
      'serverTime': serverTime.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DispatchSnapshot',
      if (viewer != null) 'viewer': viewer?.toJsonForProtocol(),
      if (config != null) 'config': config?.toJsonForProtocol(),
      if (hospitals != null)
        'hospitals': hospitals?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (careReports != null)
        'careReports': careReports?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (maintenance != null)
        'maintenance': maintenance?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (staff != null)
        'staff': staff?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'revision': revision,
      'incidents': incidents.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'units': units.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'events': events.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'serverTime': serverTime.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DispatchSnapshotImpl extends DispatchSnapshot {
  _DispatchSnapshotImpl({
    _in2s7pyn.StaffProfile? viewer,
    _ia75lo3t.WorkspaceConfig? config,
    List<_icwu3xng.Hospital>? hospitals,
    List<_i48hck61.CareReport>? careReports,
    List<_it7q91u3.MaintenanceJob>? maintenance,
    List<_in2s7pyn.StaffProfile>? staff,
    required int revision,
    required List<_ihycgcni.DispatchIncident> incidents,
    required List<_i7xsrkiu.DispatchUnit> units,
    required List<_iehe6quo.DispatchEvent> events,
    required DateTime serverTime,
  }) : super._(
         viewer: viewer,
         config: config,
         hospitals: hospitals,
         careReports: careReports,
         maintenance: maintenance,
         staff: staff,
         revision: revision,
         incidents: incidents,
         units: units,
         events: events,
         serverTime: serverTime,
       );

  /// Returns a shallow copy of this [DispatchSnapshot]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DispatchSnapshot copyWith({
    Object? viewer = _Undefined,
    Object? config = _Undefined,
    Object? hospitals = _Undefined,
    Object? careReports = _Undefined,
    Object? maintenance = _Undefined,
    Object? staff = _Undefined,
    int? revision,
    List<_ihycgcni.DispatchIncident>? incidents,
    List<_i7xsrkiu.DispatchUnit>? units,
    List<_iehe6quo.DispatchEvent>? events,
    DateTime? serverTime,
  }) {
    return DispatchSnapshot(
      viewer: viewer is _in2s7pyn.StaffProfile?
          ? viewer
          : this.viewer?.copyWith(),
      config: config is _ia75lo3t.WorkspaceConfig?
          ? config
          : this.config?.copyWith(),
      hospitals: hospitals is List<_icwu3xng.Hospital>?
          ? hospitals
          : this.hospitals?.map((e0) => e0.copyWith()).toList(),
      careReports: careReports is List<_i48hck61.CareReport>?
          ? careReports
          : this.careReports?.map((e0) => e0.copyWith()).toList(),
      maintenance: maintenance is List<_it7q91u3.MaintenanceJob>?
          ? maintenance
          : this.maintenance?.map((e0) => e0.copyWith()).toList(),
      staff: staff is List<_in2s7pyn.StaffProfile>?
          ? staff
          : this.staff?.map((e0) => e0.copyWith()).toList(),
      revision: revision ?? this.revision,
      incidents:
          incidents ?? this.incidents.map((e0) => e0.copyWith()).toList(),
      units: units ?? this.units.map((e0) => e0.copyWith()).toList(),
      events: events ?? this.events.map((e0) => e0.copyWith()).toList(),
      serverTime: serverTime ?? this.serverTime,
    );
  }
}
