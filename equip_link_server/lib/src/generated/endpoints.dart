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
import 'package:equip_link_server/src/generated/domain/equipment_listing.dart'
    as _isdyr86w;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import '../auth/email_idp_endpoint.dart' as _iuc1hd5t;
import '../auth/google_idp_endpoint.dart' as _i71axiz0;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../auth/otp_auth_endpoint.dart' as _i1ohi0jl;
import '../auth/student_email_auth_endpoint.dart' as _i3bq0f5w;
import '../endpoints/equipment_endpoint.dart' as _i0p8ajg3;
import '../endpoints/profile_endpoint.dart' as _i2cx2pww;
import '../endpoints/rental_endpoint.dart' as _i4usf3rt;
import '../greetings/greeting_endpoint.dart' as _il624ik7;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'emailIdp': _iuc1hd5t.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'googleIdp': _i71axiz0.GoogleIdpEndpoint()
        ..initialize(
          server,
          'googleIdp',
          null,
        ),
      'jwtRefresh': _inwq3ztq.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'otpAuth': _i1ohi0jl.OtpAuthEndpoint()
        ..initialize(
          server,
          'otpAuth',
          null,
        ),
      'studentEmailAuth': _i3bq0f5w.StudentEmailAuthEndpoint()
        ..initialize(
          server,
          'studentEmailAuth',
          null,
        ),
      'equipment': _i0p8ajg3.EquipmentEndpoint()
        ..initialize(
          server,
          'equipment',
          null,
        ),
      'profile': _i2cx2pww.ProfileEndpoint()
        ..initialize(
          server,
          'profile',
          null,
        ),
      'rental': _i4usf3rt.RentalEndpoint()
        ..initialize(
          server,
          'rental',
          null,
        ),
      'greeting': _il624ik7.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
    };
    connectors['emailIdp'] = _is.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint).login(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'startRegistration': _is.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _is.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _is.ParameterDescription(
              name: 'accountRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _is.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _is.ParameterDescription(
              name: 'registrationToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _is.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _is.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _is.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _is.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _is.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newPassword': _is.ParameterDescription(
              name: 'newPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['googleIdp'] = _is.EndpointConnector(
      name: 'googleIdp',
      endpoint: endpoints['googleIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'idToken': _is.ParameterDescription(
              name: 'idToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'accessToken': _is.ParameterDescription(
              name: 'accessToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['googleIdp'] as _i71axiz0.GoogleIdpEndpoint).login(
                    session,
                    idToken: params['idToken'],
                    accessToken: params['accessToken'],
                  ),
        ),
        'loginWithCode': _is.MethodConnector(
          name: 'loginWithCode',
          params: {
            'code': _is.ParameterDescription(
              name: 'code',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'codeVerifier': _is.ParameterDescription(
              name: 'codeVerifier',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'redirectUri': _is.ParameterDescription(
              name: 'redirectUri',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['googleIdp'] as _i71axiz0.GoogleIdpEndpoint)
                  .loginWithCode(
                    session,
                    code: params['code'],
                    codeVerifier: params['codeVerifier'],
                    redirectUri: params['redirectUri'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['googleIdp'] as _i71axiz0.GoogleIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _inwq3ztq.JwtRefreshEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['otpAuth'] = _is.EndpointConnector(
      name: 'otpAuth',
      endpoint: endpoints['otpAuth']!,
      methodConnectors: {
        'requestLoginCode': _is.MethodConnector(
          name: 'requestLoginCode',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'preAuthNonce': _is.ParameterDescription(
              name: 'preAuthNonce',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['otpAuth'] as _i1ohi0jl.OtpAuthEndpoint)
                  .requestLoginCode(
                    session,
                    email: params['email'],
                    preAuthNonce: params['preAuthNonce'],
                  ),
        ),
        'verifyLoginCode': _is.MethodConnector(
          name: 'verifyLoginCode',
          params: {
            'challengeId': _is.ParameterDescription(
              name: 'challengeId',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'code': _is.ParameterDescription(
              name: 'code',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'preAuthNonce': _is.ParameterDescription(
              name: 'preAuthNonce',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['otpAuth'] as _i1ohi0jl.OtpAuthEndpoint)
                  .verifyLoginCode(
                    session,
                    challengeId: params['challengeId'],
                    code: params['code'],
                    preAuthNonce: params['preAuthNonce'],
                  ),
        ),
      },
    );
    connectors['studentEmailAuth'] = _is.EndpointConnector(
      name: 'studentEmailAuth',
      endpoint: endpoints['studentEmailAuth']!,
      methodConnectors: {
        'getStudentEligibilityStatus': _is.MethodConnector(
          name: 'getStudentEligibilityStatus',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['studentEmailAuth']
                          as _i3bq0f5w.StudentEmailAuthEndpoint)
                      .getStudentEligibilityStatus(session),
        ),
        'prepareStudentIdCardUpload': _is.MethodConnector(
          name: 'prepareStudentIdCardUpload',
          params: {
            'university': _is.ParameterDescription(
              name: 'university',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'expiresAt': _is.ParameterDescription(
              name: 'expiresAt',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'fileName': _is.ParameterDescription(
              name: 'fileName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'fileSizeBytes': _is.ParameterDescription(
              name: 'fileSizeBytes',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['studentEmailAuth']
                          as _i3bq0f5w.StudentEmailAuthEndpoint)
                      .prepareStudentIdCardUpload(
                        session,
                        university: params['university'],
                        expiresAt: params['expiresAt'],
                        fileName: params['fileName'],
                        fileSizeBytes: params['fileSizeBytes'],
                      ),
        ),
        'verifyStudentIdCardUpload': _is.MethodConnector(
          name: 'verifyStudentIdCardUpload',
          params: {
            'path': _is.ParameterDescription(
              name: 'path',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['studentEmailAuth']
                          as _i3bq0f5w.StudentEmailAuthEndpoint)
                      .verifyStudentIdCardUpload(
                        session,
                        path: params['path'],
                      ),
        ),
        'requestStudentEmailVerification': _is.MethodConnector(
          name: 'requestStudentEmailVerification',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['studentEmailAuth']
                          as _i3bq0f5w.StudentEmailAuthEndpoint)
                      .requestStudentEmailVerification(
                        session,
                        email: params['email'],
                      ),
        ),
        'verifyStudentEmail': _is.MethodConnector(
          name: 'verifyStudentEmail',
          params: {
            'challengeId': _is.ParameterDescription(
              name: 'challengeId',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'code': _is.ParameterDescription(
              name: 'code',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['studentEmailAuth']
                          as _i3bq0f5w.StudentEmailAuthEndpoint)
                      .verifyStudentEmail(
                        session,
                        challengeId: params['challengeId'],
                        code: params['code'],
                      ),
        ),
      },
    );
    connectors['equipment'] = _is.EndpointConnector(
      name: 'equipment',
      endpoint: endpoints['equipment']!,
      methodConnectors: {
        'getCategories': _is.MethodConnector(
          name: 'getCategories',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['equipment'] as _i0p8ajg3.EquipmentEndpoint)
                  .getCategories(session),
        ),
        'checkAvailability': _is.MethodConnector(
          name: 'checkAvailability',
          params: {
            'listingId': _is.ParameterDescription(
              name: 'listingId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'startDate': _is.ParameterDescription(
              name: 'startDate',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'endDate': _is.ParameterDescription(
              name: 'endDate',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['equipment'] as _i0p8ajg3.EquipmentEndpoint)
                  .checkAvailability(
                    session,
                    listingId: params['listingId'],
                    startDate: params['startDate'],
                    endDate: params['endDate'],
                  ),
        ),
        'createListing': _is.MethodConnector(
          name: 'createListing',
          params: {
            'categoryId': _is.ParameterDescription(
              name: 'categoryId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'title': _is.ParameterDescription(
              name: 'title',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'description': _is.ParameterDescription(
              name: 'description',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'dailyRate': _is.ParameterDescription(
              name: 'dailyRate',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'securityDeposit': _is.ParameterDescription(
              name: 'securityDeposit',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'condition': _is.ParameterDescription(
              name: 'condition',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'locationCampus': _is.ParameterDescription(
              name: 'locationCampus',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'hourlyRate': _is.ParameterDescription(
              name: 'hourlyRate',
              type: _is.getType<double?>(),
              nullable: true,
            ),
            'imageUrls': _is.ParameterDescription(
              name: 'imageUrls',
              type: _is.getType<List<String>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['equipment'] as _i0p8ajg3.EquipmentEndpoint)
                  .createListing(
                    session,
                    categoryId: params['categoryId'],
                    title: params['title'],
                    description: params['description'],
                    dailyRate: params['dailyRate'],
                    securityDeposit: params['securityDeposit'],
                    condition: params['condition'],
                    locationCampus: params['locationCampus'],
                    hourlyRate: params['hourlyRate'],
                    imageUrls: params['imageUrls'],
                  ),
        ),
        'updateListing': _is.MethodConnector(
          name: 'updateListing',
          params: {
            'listing': _is.ParameterDescription(
              name: 'listing',
              type: _is.getType<_isdyr86w.EquipmentListing>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['equipment'] as _i0p8ajg3.EquipmentEndpoint)
                  .updateListing(
                    session,
                    params['listing'],
                  ),
        ),
        'deleteListing': _is.MethodConnector(
          name: 'deleteListing',
          params: {
            'listingId': _is.ParameterDescription(
              name: 'listingId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['equipment'] as _i0p8ajg3.EquipmentEndpoint)
                  .deleteListing(
                    session,
                    params['listingId'],
                  ),
        ),
        'getListing': _is.MethodConnector(
          name: 'getListing',
          params: {
            'listingId': _is.ParameterDescription(
              name: 'listingId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['equipment'] as _i0p8ajg3.EquipmentEndpoint)
                  .getListing(
                    session,
                    params['listingId'],
                  ),
        ),
        'searchListings': _is.MethodConnector(
          name: 'searchListings',
          params: {
            'categoryId': _is.ParameterDescription(
              name: 'categoryId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['equipment'] as _i0p8ajg3.EquipmentEndpoint)
                  .searchListings(
                    session,
                    categoryId: params['categoryId'],
                    query: params['query'],
                    status: params['status'],
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'getMyListings': _is.MethodConnector(
          name: 'getMyListings',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['equipment'] as _i0p8ajg3.EquipmentEndpoint)
                  .getMyListings(session),
        ),
      },
    );
    connectors['profile'] = _is.EndpointConnector(
      name: 'profile',
      endpoint: endpoints['profile']!,
      methodConnectors: {
        'getMyProfile': _is.MethodConnector(
          name: 'getMyProfile',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i2cx2pww.ProfileEndpoint)
                  .getMyProfile(session),
        ),
        'getProfile': _is.MethodConnector(
          name: 'getProfile',
          params: {
            'authUserId': _is.ParameterDescription(
              name: 'authUserId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i2cx2pww.ProfileEndpoint)
                  .getProfile(
                    session,
                    params['authUserId'],
                  ),
        ),
        'updateProfile': _is.MethodConnector(
          name: 'updateProfile',
          params: {
            'fullName': _is.ParameterDescription(
              name: 'fullName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'university': _is.ParameterDescription(
              name: 'university',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'phoneNumber': _is.ParameterDescription(
              name: 'phoneNumber',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'bio': _is.ParameterDescription(
              name: 'bio',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'studentIdNumber': _is.ParameterDescription(
              name: 'studentIdNumber',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'avatarUrl': _is.ParameterDescription(
              name: 'avatarUrl',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i2cx2pww.ProfileEndpoint)
                  .updateProfile(
                    session,
                    fullName: params['fullName'],
                    university: params['university'],
                    phoneNumber: params['phoneNumber'],
                    bio: params['bio'],
                    studentIdNumber: params['studentIdNumber'],
                    avatarUrl: params['avatarUrl'],
                  ),
        ),
      },
    );
    connectors['rental'] = _is.EndpointConnector(
      name: 'rental',
      endpoint: endpoints['rental']!,
      methodConnectors: {
        'createRentalRequest': _is.MethodConnector(
          name: 'createRentalRequest',
          params: {
            'listingId': _is.ParameterDescription(
              name: 'listingId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'startDate': _is.ParameterDescription(
              name: 'startDate',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'endDate': _is.ParameterDescription(
              name: 'endDate',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'notes': _is.ParameterDescription(
              name: 'notes',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['rental'] as _i4usf3rt.RentalEndpoint)
                  .createRentalRequest(
                    session,
                    listingId: params['listingId'],
                    startDate: params['startDate'],
                    endDate: params['endDate'],
                    notes: params['notes'],
                  ),
        ),
        'approveRentalRequest': _is.MethodConnector(
          name: 'approveRentalRequest',
          params: {
            'requestId': _is.ParameterDescription(
              name: 'requestId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['rental'] as _i4usf3rt.RentalEndpoint)
                  .approveRentalRequest(
                    session,
                    params['requestId'],
                  ),
        ),
        'rejectRentalRequest': _is.MethodConnector(
          name: 'rejectRentalRequest',
          params: {
            'requestId': _is.ParameterDescription(
              name: 'requestId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['rental'] as _i4usf3rt.RentalEndpoint)
                  .rejectRentalRequest(
                    session,
                    params['requestId'],
                    reason: params['reason'],
                  ),
        ),
        'cancelRentalRequest': _is.MethodConnector(
          name: 'cancelRentalRequest',
          params: {
            'requestId': _is.ParameterDescription(
              name: 'requestId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['rental'] as _i4usf3rt.RentalEndpoint)
                  .cancelRentalRequest(
                    session,
                    params['requestId'],
                    reason: params['reason'],
                  ),
        ),
        'confirmHandover': _is.MethodConnector(
          name: 'confirmHandover',
          params: {
            'requestId': _is.ParameterDescription(
              name: 'requestId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'conditionNotes': _is.ParameterDescription(
              name: 'conditionNotes',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['rental'] as _i4usf3rt.RentalEndpoint)
                  .confirmHandover(
                    session,
                    requestId: params['requestId'],
                    conditionNotes: params['conditionNotes'],
                  ),
        ),
        'confirmReturn': _is.MethodConnector(
          name: 'confirmReturn',
          params: {
            'requestId': _is.ParameterDescription(
              name: 'requestId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'returnNotes': _is.ParameterDescription(
              name: 'returnNotes',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['rental'] as _i4usf3rt.RentalEndpoint)
                  .confirmReturn(
                    session,
                    requestId: params['requestId'],
                    returnNotes: params['returnNotes'],
                  ),
        ),
        'createReview': _is.MethodConnector(
          name: 'createReview',
          params: {
            'requestId': _is.ParameterDescription(
              name: 'requestId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'rating': _is.ParameterDescription(
              name: 'rating',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'comment': _is.ParameterDescription(
              name: 'comment',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['rental'] as _i4usf3rt.RentalEndpoint)
                  .createReview(
                    session,
                    requestId: params['requestId'],
                    rating: params['rating'],
                    comment: params['comment'],
                  ),
        ),
        'getMyRentalsAsRenter': _is.MethodConnector(
          name: 'getMyRentalsAsRenter',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['rental'] as _i4usf3rt.RentalEndpoint)
                  .getMyRentalsAsRenter(session),
        ),
        'getMyRentalsAsOwner': _is.MethodConnector(
          name: 'getMyRentalsAsOwner',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['rental'] as _i4usf3rt.RentalEndpoint)
                  .getMyRentalsAsOwner(session),
        ),
        'getRentalHistory': _is.MethodConnector(
          name: 'getRentalHistory',
          params: {
            'requestId': _is.ParameterDescription(
              name: 'requestId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['rental'] as _i4usf3rt.RentalEndpoint)
                  .getRentalHistory(
                    session,
                    params['requestId'],
                  ),
        ),
      },
    );
    connectors['greeting'] = _is.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _is.MethodConnector(
          name: 'hello',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['greeting'] as _il624ik7.GreetingEndpoint).hello(
                    session,
                    params['name'],
                  ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }
}
