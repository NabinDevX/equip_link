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

abstract class StudentProfile
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  StudentProfile._({
    this.id,
    required this.authUserId,
    required this.fullName,
    required this.email,
    required this.university,
    this.studentIdNumber,
    this.phoneNumber,
    this.avatarUrl,
    required this.isVerified,
    this.bio,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StudentProfile({
    int? id,
    required _isc.UuidValue authUserId,
    required String fullName,
    required String email,
    required String university,
    String? studentIdNumber,
    String? phoneNumber,
    String? avatarUrl,
    required bool isVerified,
    String? bio,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _StudentProfileImpl;

  factory StudentProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudentProfile(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      fullName: jsonSerialization['fullName'] as String,
      email: jsonSerialization['email'] as String,
      university: jsonSerialization['university'] as String,
      studentIdNumber: jsonSerialization['studentIdNumber'] as String?,
      phoneNumber: jsonSerialization['phoneNumber'] as String?,
      avatarUrl: jsonSerialization['avatarUrl'] as String?,
      isVerified: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['isVerified'],
      ),
      bio: jsonSerialization['bio'] as String?,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
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

  _isc.UuidValue authUserId;

  String fullName;

  String email;

  String university;

  String? studentIdNumber;

  String? phoneNumber;

  String? avatarUrl;

  bool isVerified;

  String? bio;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [StudentProfile]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  StudentProfile copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? fullName,
    String? email,
    String? university,
    String? studentIdNumber,
    String? phoneNumber,
    String? avatarUrl,
    bool? isVerified,
    String? bio,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudentProfile',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'fullName': fullName,
      'email': email,
      'university': university,
      if (studentIdNumber != null) 'studentIdNumber': studentIdNumber,
      if (phoneNumber != null) 'phoneNumber': phoneNumber,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
      'isVerified': isVerified,
      if (bio != null) 'bio': bio,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StudentProfile',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'fullName': fullName,
      'email': email,
      'university': university,
      if (studentIdNumber != null) 'studentIdNumber': studentIdNumber,
      if (phoneNumber != null) 'phoneNumber': phoneNumber,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
      'isVerified': isVerified,
      if (bio != null) 'bio': bio,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StudentProfileImpl extends StudentProfile {
  _StudentProfileImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required String fullName,
    required String email,
    required String university,
    String? studentIdNumber,
    String? phoneNumber,
    String? avatarUrl,
    required bool isVerified,
    String? bio,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         fullName: fullName,
         email: email,
         university: university,
         studentIdNumber: studentIdNumber,
         phoneNumber: phoneNumber,
         avatarUrl: avatarUrl,
         isVerified: isVerified,
         bio: bio,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [StudentProfile]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  StudentProfile copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? fullName,
    String? email,
    String? university,
    Object? studentIdNumber = _Undefined,
    Object? phoneNumber = _Undefined,
    Object? avatarUrl = _Undefined,
    bool? isVerified,
    Object? bio = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StudentProfile(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      university: university ?? this.university,
      studentIdNumber: studentIdNumber is String?
          ? studentIdNumber
          : this.studentIdNumber,
      phoneNumber: phoneNumber is String? ? phoneNumber : this.phoneNumber,
      avatarUrl: avatarUrl is String? ? avatarUrl : this.avatarUrl,
      isVerified: isVerified ?? this.isVerified,
      bio: bio is String? ? bio : this.bio,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
