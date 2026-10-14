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
import 'dart:async' as _ida;
import 'package:equip_link_client/src/protocol/auth/otp_challenge_response.dart'
    as _ixnj4waa;
import 'package:equip_link_client/src/protocol/auth/student_email_challenge_response.dart'
    as _iwf8egt8;
import 'package:equip_link_client/src/protocol/auth/student_id_card_upload.dart'
    as _isq5x8su;
import 'package:equip_link_client/src/protocol/auth/student_identity.dart'
    as _ilg6v65x;
import 'package:equip_link_client/src/protocol/domain/availability_result.dart'
    as _irymgh8e;
import 'package:equip_link_client/src/protocol/domain/equipment_category.dart'
    as _it1dwo0i;
import 'package:equip_link_client/src/protocol/domain/equipment_listing.dart'
    as _i1tbdl19;
import 'package:equip_link_client/src/protocol/domain/rental_request.dart'
    as _imusbont;
import 'package:equip_link_client/src/protocol/domain/rental_review.dart'
    as _i0k0oz6l;
import 'package:equip_link_client/src/protocol/domain/rental_status_history.dart'
    as _ij762k4i;
import 'package:equip_link_client/src/protocol/domain/student_profile.dart'
    as _ihrtg1j5;
import 'package:equip_link_client/src/protocol/greetings/greeting.dart'
    as _i0treg1i;
import 'package:http/http.dart' as _i85jenna;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'protocol.dart' as _il2as5qe;

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _iaic.EndpointEmailIdpBase {
  EndpointEmailIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _ida.Future<_isc.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _ida.Future<String> verifyRegistrationCode({
    required _isc.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _ida.Future<_iacc.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _ida.Future<_isc.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _ida.Future<String> verifyPasswordResetCode({
    required _isc.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// EquipLink's Serverpod Google identity-provider endpoint.
/// {@category Endpoint}
class EndpointGoogleIdp extends _iaic.EndpointGoogleIdpBase {
  EndpointGoogleIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'googleIdp';

  /// Validates a Google ID token and either logs in the associated user or
  /// creates a new user account if the Google account ID is not yet known.
  ///
  /// If a new user is created an associated [UserProfile] is also created.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String idToken,
    required String? accessToken,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'googleIdp',
    'login',
    {
      'idToken': idToken,
      'accessToken': accessToken,
    },
  );

  /// Validates a Google authorization code from the web OAuth2 PKCE flow and
  /// either logs in the associated user or creates a new account.
  ///
  /// This is the web counterpart of [login], which accepts an ID token directly
  /// (used on native platforms via the `google_sign_in` package).
  ///
  /// If a new user is created an associated [UserProfile] is also created.
  @override
  _ida.Future<_iacc.AuthSuccess> loginWithCode({
    required String code,
    required String codeVerifier,
    required String redirectUri,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'googleIdp',
    'loginWithCode',
    {
      'code': code,
      'codeVerifier': codeVerifier,
      'redirectUri': redirectUri,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'googleIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _iacc.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// If [refreshToken] is omitted, cookie-mode web clients fall back to the
  /// configured HttpOnly refresh cookie. When neither source is present this
  /// throws [RefreshTokenNotFoundException], the same public "no usable refresh
  /// credential" exception used for unknown refresh tokens.
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _ida.Future<_iacc.AuthSuccess> refreshAccessToken({String? refreshToken}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'jwtRefresh',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// Endpoint providing secure passwordless Email OTP authentication for EquipLink.
///
/// Features:
/// - Cryptographic challenge-bound single-use verification codes.
/// - Request context and IP tracking with risk detection.
/// - Expiration, single-use, and attempt count enforcement.
/// - Reuses official Serverpod token manager and AuthSuccess token issuance.
/// {@category Endpoint}
class EndpointOtpAuth extends _isc.EndpointRef {
  EndpointOtpAuth(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'otpAuth';

  /// Request a single-use login code sent to the specified email.
  _ida.Future<_ixnj4waa.OtpChallengeResponse> requestLoginCode({
    required String email,
    String? preAuthNonce,
  }) => caller.callServerEndpoint<_ixnj4waa.OtpChallengeResponse>(
    'otpAuth',
    'requestLoginCode',
    {
      'email': email,
      'preAuthNonce': preAuthNonce,
    },
  );

  /// Verifies a login code, binds the requesting context, and issues an official Serverpod session token.
  _ida.Future<_iacc.AuthSuccess> verifyLoginCode({
    required String challengeId,
    required String code,
    String? preAuthNonce,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'otpAuth',
    'verifyLoginCode',
    {
      'challengeId': challengeId,
      'code': code,
      'preAuthNonce': preAuthNonce,
    },
  );
}

/// {@category Endpoint}
class EndpointStudentEmailAuth extends _isc.EndpointRef {
  EndpointStudentEmailAuth(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'studentEmailAuth';

  _ida.Future<_ilg6v65x.StudentIdentity> getStudentEligibilityStatus() =>
      caller.callServerEndpoint<_ilg6v65x.StudentIdentity>(
        'studentEmailAuth',
        'getStudentEligibilityStatus',
        {},
      );

  /// Creates a private, user-scoped upload authorization for a student ID card.
  _ida.Future<_isq5x8su.StudentIdCardUpload> prepareStudentIdCardUpload({
    required String university,
    required DateTime expiresAt,
    required String fileName,
    required int fileSizeBytes,
  }) => caller.callServerEndpoint<_isq5x8su.StudentIdCardUpload>(
    'studentEmailAuth',
    'prepareStudentIdCardUpload',
    {
      'university': university,
      'expiresAt': expiresAt,
      'fileName': fileName,
      'fileSizeBytes': fileSizeBytes,
    },
  );

  /// Confirms that the authenticated student's private ID-card upload completed.
  _ida.Future<bool> verifyStudentIdCardUpload({required String path}) =>
      caller.callServerEndpoint<bool>(
        'studentEmailAuth',
        'verifyStudentIdCardUpload',
        {'path': path},
      );

  _ida.Future<_iwf8egt8.StudentEmailChallengeResponse>
  requestStudentEmailVerification({required String email}) =>
      caller.callServerEndpoint<_iwf8egt8.StudentEmailChallengeResponse>(
        'studentEmailAuth',
        'requestStudentEmailVerification',
        {'email': email},
      );

  _ida.Future<_ilg6v65x.StudentIdentity> verifyStudentEmail({
    required String challengeId,
    required String code,
  }) => caller.callServerEndpoint<_ilg6v65x.StudentIdentity>(
    'studentEmailAuth',
    'verifyStudentEmail',
    {
      'challengeId': challengeId,
      'code': code,
    },
  );
}

/// Endpoint for equipment categories, discovery, listings, and availability checks.
/// {@category Endpoint}
class EndpointEquipment extends _isc.EndpointRef {
  EndpointEquipment(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'equipment';

  /// Fetches equipment categories, seeding defaults if the table is empty.
  _ida.Future<List<_it1dwo0i.EquipmentCategory>> getCategories() =>
      caller.callServerEndpoint<List<_it1dwo0i.EquipmentCategory>>(
        'equipment',
        'getCategories',
        {},
      );

  /// Checks whether an equipment item is available for rental between [startDate] and [endDate].
  _ida.Future<_irymgh8e.AvailabilityResult> checkAvailability({
    required int listingId,
    required DateTime startDate,
    required DateTime endDate,
  }) => caller.callServerEndpoint<_irymgh8e.AvailabilityResult>(
    'equipment',
    'checkAvailability',
    {
      'listingId': listingId,
      'startDate': startDate,
      'endDate': endDate,
    },
  );

  /// Creates a new equipment listing. Requires authenticated user.
  _ida.Future<_i1tbdl19.EquipmentListing> createListing({
    required int categoryId,
    required String title,
    required String description,
    required double dailyRate,
    required double securityDeposit,
    required String condition,
    required String locationCampus,
    double? hourlyRate,
    required List<String> imageUrls,
  }) => caller.callServerEndpoint<_i1tbdl19.EquipmentListing>(
    'equipment',
    'createListing',
    {
      'categoryId': categoryId,
      'title': title,
      'description': description,
      'dailyRate': dailyRate,
      'securityDeposit': securityDeposit,
      'condition': condition,
      'locationCampus': locationCampus,
      'hourlyRate': hourlyRate,
      'imageUrls': imageUrls,
    },
  );

  /// Updates an existing equipment listing. Requires listing ownership.
  _ida.Future<_i1tbdl19.EquipmentListing> updateListing(
    _i1tbdl19.EquipmentListing listing,
  ) => caller.callServerEndpoint<_i1tbdl19.EquipmentListing>(
    'equipment',
    'updateListing',
    {'listing': listing},
  );

  /// Deletes a listing if owned by the user and not currently active in a rental.
  _ida.Future<bool> deleteListing(int listingId) =>
      caller.callServerEndpoint<bool>(
        'equipment',
        'deleteListing',
        {'listingId': listingId},
      );

  /// Fetches an individual listing by ID.
  _ida.Future<_i1tbdl19.EquipmentListing?> getListing(int listingId) =>
      caller.callServerEndpoint<_i1tbdl19.EquipmentListing?>(
        'equipment',
        'getListing',
        {'listingId': listingId},
      );

  /// Searches and filters equipment listings.
  _ida.Future<List<_i1tbdl19.EquipmentListing>> searchListings({
    int? categoryId,
    String? query,
    String? status,
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_i1tbdl19.EquipmentListing>>(
    'equipment',
    'searchListings',
    {
      'categoryId': categoryId,
      'query': query,
      'status': status,
      'limit': limit,
      'offset': offset,
    },
  );

  /// Retrieves listings owned by the authenticated student.
  _ida.Future<List<_i1tbdl19.EquipmentListing>> getMyListings() =>
      caller.callServerEndpoint<List<_i1tbdl19.EquipmentListing>>(
        'equipment',
        'getMyListings',
        {},
      );
}

/// Endpoint for student profile management in EquipLink.
/// {@category Endpoint}
class EndpointProfile extends _isc.EndpointRef {
  EndpointProfile(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'profile';

  /// Retrieves the student profile of the currently signed-in user.
  _ida.Future<_ihrtg1j5.StudentProfile> getMyProfile() =>
      caller.callServerEndpoint<_ihrtg1j5.StudentProfile>(
        'profile',
        'getMyProfile',
        {},
      );

  /// Retrieves the signed-in user's profile by its associated auth user id.
  ///
  /// Private profile fields are not exposed as a public lookup. A dedicated
  /// public-profile DTO should be introduced before exposing other students'
  /// profiles.
  _ida.Future<_ihrtg1j5.StudentProfile?> getProfile(
    _isc.UuidValue authUserId,
  ) => caller.callServerEndpoint<_ihrtg1j5.StudentProfile?>(
    'profile',
    'getProfile',
    {'authUserId': authUserId},
  );

  /// Updates the profile information of the currently authenticated student.
  _ida.Future<_ihrtg1j5.StudentProfile> updateProfile({
    required String fullName,
    required String university,
    String? phoneNumber,
    String? bio,
    String? studentIdNumber,
    String? avatarUrl,
  }) => caller.callServerEndpoint<_ihrtg1j5.StudentProfile>(
    'profile',
    'updateProfile',
    {
      'fullName': fullName,
      'university': university,
      'phoneNumber': phoneNumber,
      'bio': bio,
      'studentIdNumber': studentIdNumber,
      'avatarUrl': avatarUrl,
    },
  );
}

/// Endpoint managing rental lifecycles, transactions, handover, return, and reviews.
/// {@category Endpoint}
class EndpointRental extends _isc.EndpointRef {
  EndpointRental(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'rental';

  /// Creates a new rental request for an equipment listing.
  ///
  /// Enforces:
  /// 1. Self-renting prevention (owner cannot rent their own item).
  /// 2. Date range validation (end date > start date, start date >= today).
  /// 3. Overlap check against existing approved / in_progress rentals.
  /// 4. Price & security deposit calculation from official listing.
  _ida.Future<_imusbont.RentalRequest> createRentalRequest({
    required int listingId,
    required DateTime startDate,
    required DateTime endDate,
    String? notes,
  }) => caller.callServerEndpoint<_imusbont.RentalRequest>(
    'rental',
    'createRentalRequest',
    {
      'listingId': listingId,
      'startDate': startDate,
      'endDate': endDate,
      'notes': notes,
    },
  );

  /// Approves a pending rental request. Only the equipment owner may approve.
  _ida.Future<_imusbont.RentalRequest> approveRentalRequest(int requestId) =>
      caller.callServerEndpoint<_imusbont.RentalRequest>(
        'rental',
        'approveRentalRequest',
        {'requestId': requestId},
      );

  /// Rejects a pending rental request. Only the equipment owner may reject.
  _ida.Future<_imusbont.RentalRequest> rejectRentalRequest(
    int requestId, {
    String? reason,
  }) => caller.callServerEndpoint<_imusbont.RentalRequest>(
    'rental',
    'rejectRentalRequest',
    {
      'requestId': requestId,
      'reason': reason,
    },
  );

  /// Cancels a rental request before handover. Renter or owner may cancel.
  _ida.Future<_imusbont.RentalRequest> cancelRentalRequest(
    int requestId, {
    String? reason,
  }) => caller.callServerEndpoint<_imusbont.RentalRequest>(
    'rental',
    'cancelRentalRequest',
    {
      'requestId': requestId,
      'reason': reason,
    },
  );

  /// Confirms equipment handover, transitioning rental to 'in_progress'.
  _ida.Future<_imusbont.RentalRequest> confirmHandover({
    required int requestId,
    String? conditionNotes,
  }) => caller.callServerEndpoint<_imusbont.RentalRequest>(
    'rental',
    'confirmHandover',
    {
      'requestId': requestId,
      'conditionNotes': conditionNotes,
    },
  );

  /// Confirms equipment return, marking rental 'completed'.
  _ida.Future<_imusbont.RentalRequest> confirmReturn({
    required int requestId,
    String? returnNotes,
  }) => caller.callServerEndpoint<_imusbont.RentalRequest>(
    'rental',
    'confirmReturn',
    {
      'requestId': requestId,
      'returnNotes': returnNotes,
    },
  );

  /// Submits a review and rating (1 to 5) for a completed rental.
  _ida.Future<_i0k0oz6l.RentalReview> createReview({
    required int requestId,
    required int rating,
    String? comment,
  }) => caller.callServerEndpoint<_i0k0oz6l.RentalReview>(
    'rental',
    'createReview',
    {
      'requestId': requestId,
      'rating': rating,
      'comment': comment,
    },
  );

  /// Lists rentals requested by the authenticated student.
  _ida.Future<List<_imusbont.RentalRequest>> getMyRentalsAsRenter() =>
      caller.callServerEndpoint<List<_imusbont.RentalRequest>>(
        'rental',
        'getMyRentalsAsRenter',
        {},
      );

  /// Lists rentals received by the owner for their listings.
  _ida.Future<List<_imusbont.RentalRequest>> getMyRentalsAsOwner() =>
      caller.callServerEndpoint<List<_imusbont.RentalRequest>>(
        'rental',
        'getMyRentalsAsOwner',
        {},
      );

  /// Fetches the status history log of a rental request.
  _ida.Future<List<_ij762k4i.RentalStatusHistory>> getRentalHistory(
    int requestId,
  ) => caller.callServerEndpoint<List<_ij762k4i.RentalStatusHistory>>(
    'rental',
    'getRentalHistory',
    {'requestId': requestId},
  );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _isc.EndpointRef {
  EndpointGreeting(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _ida.Future<_i0treg1i.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i0treg1i.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _iaic.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
  }

  late final _iaic.Caller serverpod_auth_idp;

  late final _iacc.Caller serverpod_auth_core;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    emailIdp = EndpointEmailIdp(this);
    googleIdp = EndpointGoogleIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    otpAuth = EndpointOtpAuth(this);
    studentEmailAuth = EndpointStudentEmailAuth(this);
    equipment = EndpointEquipment(this);
    profile = EndpointProfile(this);
    rental = EndpointRental(this);
    greeting = EndpointGreeting(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointGoogleIdp googleIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointOtpAuth otpAuth;

  late final EndpointStudentEmailAuth studentEmailAuth;

  late final EndpointEquipment equipment;

  late final EndpointProfile profile;

  late final EndpointRental rental;

  late final EndpointGreeting greeting;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'googleIdp': googleIdp,
    'jwtRefresh': jwtRefresh,
    'otpAuth': otpAuth,
    'studentEmailAuth': studentEmailAuth,
    'equipment': equipment,
    'profile': profile,
    'rental': rental,
    'greeting': greeting,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
