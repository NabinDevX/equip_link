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

abstract class OtpChallengeResponse
    implements _is.SerializableModel, _is.ProtocolSerialization {
  OtpChallengeResponse._({
    required this.challengeId,
    required this.expiresInSeconds,
    required this.message,
  });

  factory OtpChallengeResponse({
    required String challengeId,
    required int expiresInSeconds,
    required String message,
  }) = _OtpChallengeResponseImpl;

  factory OtpChallengeResponse.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return OtpChallengeResponse(
      challengeId: jsonSerialization['challengeId'] as String,
      expiresInSeconds: jsonSerialization['expiresInSeconds'] as int,
      message: jsonSerialization['message'] as String,
    );
  }

  String challengeId;

  int expiresInSeconds;

  String message;

  /// Returns a shallow copy of this [OtpChallengeResponse]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  OtpChallengeResponse copyWith({
    String? challengeId,
    int? expiresInSeconds,
    String? message,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OtpChallengeResponse',
      'challengeId': challengeId,
      'expiresInSeconds': expiresInSeconds,
      'message': message,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OtpChallengeResponse',
      'challengeId': challengeId,
      'expiresInSeconds': expiresInSeconds,
      'message': message,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _OtpChallengeResponseImpl extends OtpChallengeResponse {
  _OtpChallengeResponseImpl({
    required String challengeId,
    required int expiresInSeconds,
    required String message,
  }) : super._(
         challengeId: challengeId,
         expiresInSeconds: expiresInSeconds,
         message: message,
       );

  /// Returns a shallow copy of this [OtpChallengeResponse]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  OtpChallengeResponse copyWith({
    String? challengeId,
    int? expiresInSeconds,
    String? message,
  }) {
    return OtpChallengeResponse(
      challengeId: challengeId ?? this.challengeId,
      expiresInSeconds: expiresInSeconds ?? this.expiresInSeconds,
      message: message ?? this.message,
    );
  }
}
