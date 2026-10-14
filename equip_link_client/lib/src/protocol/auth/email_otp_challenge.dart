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

abstract class EmailOtpChallenge
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  EmailOtpChallenge._({
    this.id,
    required this.challengeId,
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
    this.preAuthNonce,
  });

  factory EmailOtpChallenge({
    int? id,
    required String challengeId,
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
    String? preAuthNonce,
  }) = _EmailOtpChallengeImpl;

  factory EmailOtpChallenge.fromJson(Map<String, dynamic> jsonSerialization) {
    return EmailOtpChallenge(
      id: jsonSerialization['id'] as int?,
      challengeId: jsonSerialization['challengeId'] as String,
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
      preAuthNonce: jsonSerialization['preAuthNonce'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String challengeId;

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

  String? preAuthNonce;

  /// Returns a shallow copy of this [EmailOtpChallenge]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  EmailOtpChallenge copyWith({
    int? id,
    String? challengeId,
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
    String? preAuthNonce,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EmailOtpChallenge',
      if (id != null) 'id': id,
      'challengeId': challengeId,
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
      if (preAuthNonce != null) 'preAuthNonce': preAuthNonce,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EmailOtpChallenge',
      if (id != null) 'id': id,
      'challengeId': challengeId,
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
      if (preAuthNonce != null) 'preAuthNonce': preAuthNonce,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EmailOtpChallengeImpl extends EmailOtpChallenge {
  _EmailOtpChallengeImpl({
    int? id,
    required String challengeId,
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
    String? preAuthNonce,
  }) : super._(
         id: id,
         challengeId: challengeId,
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
         preAuthNonce: preAuthNonce,
       );

  /// Returns a shallow copy of this [EmailOtpChallenge]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  EmailOtpChallenge copyWith({
    Object? id = _Undefined,
    String? challengeId,
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
    Object? preAuthNonce = _Undefined,
  }) {
    return EmailOtpChallenge(
      id: id is int? ? id : this.id,
      challengeId: challengeId ?? this.challengeId,
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
      preAuthNonce: preAuthNonce is String? ? preAuthNonce : this.preAuthNonce,
    );
  }
}
