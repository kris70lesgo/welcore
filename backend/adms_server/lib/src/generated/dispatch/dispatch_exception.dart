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

abstract class DispatchException
    implements
        _is.SerializableException,
        _is.SerializableModel,
        _is.ProtocolSerialization {
  DispatchException._({required this.message});

  factory DispatchException({required String message}) = _DispatchExceptionImpl;

  factory DispatchException.fromJson(Map<String, dynamic> jsonSerialization) {
    return DispatchException(message: jsonSerialization['message'] as String);
  }

  String message;

  /// Returns a shallow copy of this [DispatchException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DispatchException copyWith({String? message});
  @override
  Map<String, dynamic> toJson() {
    return {'__className__': 'DispatchException', 'message': message};
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {'__className__': 'DispatchException', 'message': message};
  }

  @override
  String toString() {
    return 'DispatchException(message: $message)';
  }
}

class _DispatchExceptionImpl extends DispatchException {
  _DispatchExceptionImpl({required String message}) : super._(message: message);

  /// Returns a shallow copy of this [DispatchException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DispatchException copyWith({String? message}) {
    return DispatchException(message: message ?? this.message);
  }
}
