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

abstract class StudentEmailVerificationChallenge
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  StudentEmailVerificationChallenge._({
    this.id,
    required this.challengeId,
    required this.authUserId,
    required this.email,
    required this.codeHash,
    required this.salt,
    required this.issuedAt,
    required this.expiresAt,
    required this.attempts,
    required this.maxAttempts,
    required this.consumed,
    this.requestIp,
    this.userAgent,
  });

  factory StudentEmailVerificationChallenge({
    int? id,
    required String challengeId,
    required _isc.UuidValue authUserId,
    required String email,
    required String codeHash,
    required String salt,
    required DateTime issuedAt,
    required DateTime expiresAt,
    required int attempts,
    required int maxAttempts,
    required bool consumed,
    String? requestIp,
    String? userAgent,
  }) = _StudentEmailVerificationChallengeImpl;

  factory StudentEmailVerificationChallenge.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return StudentEmailVerificationChallenge(
      id: jsonSerialization['id'] as int?,
      challengeId: jsonSerialization['challengeId'] as String,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      email: jsonSerialization['email'] as String,
      codeHash: jsonSerialization['codeHash'] as String,
      salt: jsonSerialization['salt'] as String,
      issuedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['issuedAt'],
      ),
      expiresAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      attempts: jsonSerialization['attempts'] as int,
      maxAttempts: jsonSerialization['maxAttempts'] as int,
      consumed: _isc.BoolJsonExtension.fromJson(jsonSerialization['consumed']),
      requestIp: jsonSerialization['requestIp'] as String?,
      userAgent: jsonSerialization['userAgent'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String challengeId;

  _isc.UuidValue authUserId;

  String email;

  String codeHash;

  String salt;

  DateTime issuedAt;

  DateTime expiresAt;

  int attempts;

  int maxAttempts;

  bool consumed;

  String? requestIp;

  String? userAgent;

  /// Returns a shallow copy of this [StudentEmailVerificationChallenge]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  StudentEmailVerificationChallenge copyWith({
    int? id,
    String? challengeId,
    _isc.UuidValue? authUserId,
    String? email,
    String? codeHash,
    String? salt,
    DateTime? issuedAt,
    DateTime? expiresAt,
    int? attempts,
    int? maxAttempts,
    bool? consumed,
    String? requestIp,
    String? userAgent,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudentEmailVerificationChallenge',
      if (id != null) 'id': id,
      'challengeId': challengeId,
      'authUserId': authUserId.toJson(),
      'email': email,
      'codeHash': codeHash,
      'salt': salt,
      'issuedAt': issuedAt.toJson(),
      'expiresAt': expiresAt.toJson(),
      'attempts': attempts,
      'maxAttempts': maxAttempts,
      'consumed': consumed,
      if (requestIp != null) 'requestIp': requestIp,
      if (userAgent != null) 'userAgent': userAgent,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StudentEmailVerificationChallenge',
      if (id != null) 'id': id,
      'challengeId': challengeId,
      'authUserId': authUserId.toJson(),
      'email': email,
      'codeHash': codeHash,
      'salt': salt,
      'issuedAt': issuedAt.toJson(),
      'expiresAt': expiresAt.toJson(),
      'attempts': attempts,
      'maxAttempts': maxAttempts,
      'consumed': consumed,
      if (requestIp != null) 'requestIp': requestIp,
      if (userAgent != null) 'userAgent': userAgent,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StudentEmailVerificationChallengeImpl
    extends StudentEmailVerificationChallenge {
  _StudentEmailVerificationChallengeImpl({
    int? id,
    required String challengeId,
    required _isc.UuidValue authUserId,
    required String email,
    required String codeHash,
    required String salt,
    required DateTime issuedAt,
    required DateTime expiresAt,
    required int attempts,
    required int maxAttempts,
    required bool consumed,
    String? requestIp,
    String? userAgent,
  }) : super._(
         id: id,
         challengeId: challengeId,
         authUserId: authUserId,
         email: email,
         codeHash: codeHash,
         salt: salt,
         issuedAt: issuedAt,
         expiresAt: expiresAt,
         attempts: attempts,
         maxAttempts: maxAttempts,
         consumed: consumed,
         requestIp: requestIp,
         userAgent: userAgent,
       );

  /// Returns a shallow copy of this [StudentEmailVerificationChallenge]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  StudentEmailVerificationChallenge copyWith({
    Object? id = _Undefined,
    String? challengeId,
    _isc.UuidValue? authUserId,
    String? email,
    String? codeHash,
    String? salt,
    DateTime? issuedAt,
    DateTime? expiresAt,
    int? attempts,
    int? maxAttempts,
    bool? consumed,
    Object? requestIp = _Undefined,
    Object? userAgent = _Undefined,
  }) {
    return StudentEmailVerificationChallenge(
      id: id is int? ? id : this.id,
      challengeId: challengeId ?? this.challengeId,
      authUserId: authUserId ?? this.authUserId,
      email: email ?? this.email,
      codeHash: codeHash ?? this.codeHash,
      salt: salt ?? this.salt,
      issuedAt: issuedAt ?? this.issuedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      attempts: attempts ?? this.attempts,
      maxAttempts: maxAttempts ?? this.maxAttempts,
      consumed: consumed ?? this.consumed,
      requestIp: requestIp is String? ? requestIp : this.requestIp,
      userAgent: userAgent is String? ? userAgent : this.userAgent,
    );
  }
}
