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

abstract class EquipLinkException
    implements
        _is.SerializableException,
        _is.SerializableModel,
        _is.ProtocolSerialization {
  EquipLinkException._({
    required this.message,
    this.statusCode,
  });

  factory EquipLinkException({
    required String message,
    int? statusCode,
  }) = _EquipLinkExceptionImpl;

  factory EquipLinkException.fromJson(Map<String, dynamic> jsonSerialization) {
    return EquipLinkException(
      message: jsonSerialization['message'] as String,
      statusCode: jsonSerialization['statusCode'] as int?,
    );
  }

  String message;

  int? statusCode;

  /// Returns a shallow copy of this [EquipLinkException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  EquipLinkException copyWith({
    String? message,
    int? statusCode,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EquipLinkException',
      'message': message,
      if (statusCode != null) 'statusCode': statusCode,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EquipLinkException',
      'message': message,
      if (statusCode != null) 'statusCode': statusCode,
    };
  }

  @override
  String toString() {
    return 'EquipLinkException(message: $message, statusCode: $statusCode)';
  }
}

class _Undefined {}

class _EquipLinkExceptionImpl extends EquipLinkException {
  _EquipLinkExceptionImpl({
    required String message,
    int? statusCode,
  }) : super._(
         message: message,
         statusCode: statusCode,
       );

  /// Returns a shallow copy of this [EquipLinkException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  EquipLinkException copyWith({
    String? message,
    Object? statusCode = _Undefined,
  }) {
    return EquipLinkException(
      message: message ?? this.message,
      statusCode: statusCode is int? ? statusCode : this.statusCode,
    );
  }
}
