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

abstract class StudentIdentity
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  StudentIdentity._({
    this.id,
    required this.authUserId,
    this.googleProviderIdentity,
    this.studentEmail,
    this.university,
    this.studentIdExpiresAt,
    bool? studentIdCardVerified,
    required this.emailVerified,
    this.verifiedAt,
    this.lastRevalidatedAt,
    this.revalidationDueAt,
    required this.eligibilityStatus,
    required this.createdAt,
    required this.updatedAt,
  }) : studentIdCardVerified = studentIdCardVerified ?? false;

  factory StudentIdentity({
    int? id,
    required _isc.UuidValue authUserId,
    String? googleProviderIdentity,
    String? studentEmail,
    String? university,
    DateTime? studentIdExpiresAt,
    bool? studentIdCardVerified,
    required bool emailVerified,
    DateTime? verifiedAt,
    DateTime? lastRevalidatedAt,
    DateTime? revalidationDueAt,
    required String eligibilityStatus,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _StudentIdentityImpl;

  factory StudentIdentity.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudentIdentity(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      googleProviderIdentity:
          jsonSerialization['googleProviderIdentity'] as String?,
      studentEmail: jsonSerialization['studentEmail'] as String?,
      university: jsonSerialization['university'] as String?,
      studentIdExpiresAt: jsonSerialization['studentIdExpiresAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['studentIdExpiresAt'],
            ),
      studentIdCardVerified: jsonSerialization['studentIdCardVerified'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(
              jsonSerialization['studentIdCardVerified'],
            ),
      emailVerified: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['emailVerified'],
      ),
      verifiedAt: jsonSerialization['verifiedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['verifiedAt'],
            ),
      lastRevalidatedAt: jsonSerialization['lastRevalidatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastRevalidatedAt'],
            ),
      revalidationDueAt: jsonSerialization['revalidationDueAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['revalidationDueAt'],
            ),
      eligibilityStatus: jsonSerialization['eligibilityStatus'] as String,
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

  String? googleProviderIdentity;

  String? studentEmail;

  String? university;

  DateTime? studentIdExpiresAt;

  bool studentIdCardVerified;

  bool emailVerified;

  DateTime? verifiedAt;

  DateTime? lastRevalidatedAt;

  DateTime? revalidationDueAt;

  String eligibilityStatus;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [StudentIdentity]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  StudentIdentity copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? googleProviderIdentity,
    String? studentEmail,
    String? university,
    DateTime? studentIdExpiresAt,
    bool? studentIdCardVerified,
    bool? emailVerified,
    DateTime? verifiedAt,
    DateTime? lastRevalidatedAt,
    DateTime? revalidationDueAt,
    String? eligibilityStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudentIdentity',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (googleProviderIdentity != null)
        'googleProviderIdentity': googleProviderIdentity,
      if (studentEmail != null) 'studentEmail': studentEmail,
      if (university != null) 'university': university,
      if (studentIdExpiresAt != null)
        'studentIdExpiresAt': studentIdExpiresAt?.toJson(),
      'studentIdCardVerified': studentIdCardVerified,
      'emailVerified': emailVerified,
      if (verifiedAt != null) 'verifiedAt': verifiedAt?.toJson(),
      if (lastRevalidatedAt != null)
        'lastRevalidatedAt': lastRevalidatedAt?.toJson(),
      if (revalidationDueAt != null)
        'revalidationDueAt': revalidationDueAt?.toJson(),
      'eligibilityStatus': eligibilityStatus,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StudentIdentity',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (googleProviderIdentity != null)
        'googleProviderIdentity': googleProviderIdentity,
      if (studentEmail != null) 'studentEmail': studentEmail,
      if (university != null) 'university': university,
      if (studentIdExpiresAt != null)
        'studentIdExpiresAt': studentIdExpiresAt?.toJson(),
      'studentIdCardVerified': studentIdCardVerified,
      'emailVerified': emailVerified,
      if (verifiedAt != null) 'verifiedAt': verifiedAt?.toJson(),
      if (lastRevalidatedAt != null)
        'lastRevalidatedAt': lastRevalidatedAt?.toJson(),
      if (revalidationDueAt != null)
        'revalidationDueAt': revalidationDueAt?.toJson(),
      'eligibilityStatus': eligibilityStatus,
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

class _StudentIdentityImpl extends StudentIdentity {
  _StudentIdentityImpl({
    int? id,
    required _isc.UuidValue authUserId,
    String? googleProviderIdentity,
    String? studentEmail,
    String? university,
    DateTime? studentIdExpiresAt,
    bool? studentIdCardVerified,
    required bool emailVerified,
    DateTime? verifiedAt,
    DateTime? lastRevalidatedAt,
    DateTime? revalidationDueAt,
    required String eligibilityStatus,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         googleProviderIdentity: googleProviderIdentity,
         studentEmail: studentEmail,
         university: university,
         studentIdExpiresAt: studentIdExpiresAt,
         studentIdCardVerified: studentIdCardVerified,
         emailVerified: emailVerified,
         verifiedAt: verifiedAt,
         lastRevalidatedAt: lastRevalidatedAt,
         revalidationDueAt: revalidationDueAt,
         eligibilityStatus: eligibilityStatus,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [StudentIdentity]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  StudentIdentity copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    Object? googleProviderIdentity = _Undefined,
    Object? studentEmail = _Undefined,
    Object? university = _Undefined,
    Object? studentIdExpiresAt = _Undefined,
    bool? studentIdCardVerified,
    bool? emailVerified,
    Object? verifiedAt = _Undefined,
    Object? lastRevalidatedAt = _Undefined,
    Object? revalidationDueAt = _Undefined,
    String? eligibilityStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StudentIdentity(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      googleProviderIdentity: googleProviderIdentity is String?
          ? googleProviderIdentity
          : this.googleProviderIdentity,
      studentEmail: studentEmail is String? ? studentEmail : this.studentEmail,
      university: university is String? ? university : this.university,
      studentIdExpiresAt: studentIdExpiresAt is DateTime?
          ? studentIdExpiresAt
          : this.studentIdExpiresAt,
      studentIdCardVerified:
          studentIdCardVerified ?? this.studentIdCardVerified,
      emailVerified: emailVerified ?? this.emailVerified,
      verifiedAt: verifiedAt is DateTime? ? verifiedAt : this.verifiedAt,
      lastRevalidatedAt: lastRevalidatedAt is DateTime?
          ? lastRevalidatedAt
          : this.lastRevalidatedAt,
      revalidationDueAt: revalidationDueAt is DateTime?
          ? revalidationDueAt
          : this.revalidationDueAt,
      eligibilityStatus: eligibilityStatus ?? this.eligibilityStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
