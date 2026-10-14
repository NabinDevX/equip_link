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

abstract class StudentIdCardUpload
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  StudentIdCardUpload._({
    required this.path,
    required this.uploadDescription,
  });

  factory StudentIdCardUpload({
    required String path,
    required String uploadDescription,
  }) = _StudentIdCardUploadImpl;

  factory StudentIdCardUpload.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudentIdCardUpload(
      path: jsonSerialization['path'] as String,
      uploadDescription: jsonSerialization['uploadDescription'] as String,
    );
  }

  String path;

  String uploadDescription;

  /// Returns a shallow copy of this [StudentIdCardUpload]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  StudentIdCardUpload copyWith({
    String? path,
    String? uploadDescription,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudentIdCardUpload',
      'path': path,
      'uploadDescription': uploadDescription,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StudentIdCardUpload',
      'path': path,
      'uploadDescription': uploadDescription,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _StudentIdCardUploadImpl extends StudentIdCardUpload {
  _StudentIdCardUploadImpl({
    required String path,
    required String uploadDescription,
  }) : super._(
         path: path,
         uploadDescription: uploadDescription,
       );

  /// Returns a shallow copy of this [StudentIdCardUpload]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  StudentIdCardUpload copyWith({
    String? path,
    String? uploadDescription,
  }) {
    return StudentIdCardUpload(
      path: path ?? this.path,
      uploadDescription: uploadDescription ?? this.uploadDescription,
    );
  }
}
