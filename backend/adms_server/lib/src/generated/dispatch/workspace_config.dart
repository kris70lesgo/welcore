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

abstract class WorkspaceConfig
    implements _is.SerializableModel, _is.ProtocolSerialization {
  WorkspaceConfig._({
    required this.name,
    required this.isDemo,
    required this.autoDispatch,
    required this.responseTargetMinutes,
  });

  factory WorkspaceConfig({
    required String name,
    required bool isDemo,
    required bool autoDispatch,
    required int responseTargetMinutes,
  }) = _WorkspaceConfigImpl;

  factory WorkspaceConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return WorkspaceConfig(
      name: jsonSerialization['name'] as String,
      isDemo: _is.BoolJsonExtension.fromJson(jsonSerialization['isDemo']),
      autoDispatch: _is.BoolJsonExtension.fromJson(
        jsonSerialization['autoDispatch'],
      ),
      responseTargetMinutes: jsonSerialization['responseTargetMinutes'] as int,
    );
  }

  String name;

  bool isDemo;

  bool autoDispatch;

  int responseTargetMinutes;

  /// Returns a shallow copy of this [WorkspaceConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  WorkspaceConfig copyWith({
    String? name,
    bool? isDemo,
    bool? autoDispatch,
    int? responseTargetMinutes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WorkspaceConfig',
      'name': name,
      'isDemo': isDemo,
      'autoDispatch': autoDispatch,
      'responseTargetMinutes': responseTargetMinutes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WorkspaceConfig',
      'name': name,
      'isDemo': isDemo,
      'autoDispatch': autoDispatch,
      'responseTargetMinutes': responseTargetMinutes,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _WorkspaceConfigImpl extends WorkspaceConfig {
  _WorkspaceConfigImpl({
    required String name,
    required bool isDemo,
    required bool autoDispatch,
    required int responseTargetMinutes,
  }) : super._(
         name: name,
         isDemo: isDemo,
         autoDispatch: autoDispatch,
         responseTargetMinutes: responseTargetMinutes,
       );

  /// Returns a shallow copy of this [WorkspaceConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  WorkspaceConfig copyWith({
    String? name,
    bool? isDemo,
    bool? autoDispatch,
    int? responseTargetMinutes,
  }) {
    return WorkspaceConfig(
      name: name ?? this.name,
      isDemo: isDemo ?? this.isDemo,
      autoDispatch: autoDispatch ?? this.autoDispatch,
      responseTargetMinutes:
          responseTargetMinutes ?? this.responseTargetMinutes,
    );
  }
}
