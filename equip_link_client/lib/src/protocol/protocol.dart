/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:equip_link_client/src/protocol/domain/equipment_category.dart'
    as _it1dwo0i;
import 'package:equip_link_client/src/protocol/domain/equipment_listing.dart'
    as _i1tbdl19;
import 'package:equip_link_client/src/protocol/domain/rental_request.dart'
    as _imusbont;
import 'package:equip_link_client/src/protocol/domain/rental_status_history.dart'
    as _ij762k4i;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'auth/email_otp_challenge.dart' as _ittyyj72;
import 'auth/otp_challenge_response.dart' as _if3qksxc;
import 'auth/student_email_challenge_response.dart' as _ip3dtseu;
import 'auth/student_email_verification_challenge.dart' as _i6sm5mkm;
import 'auth/student_id_card_upload.dart' as _iv0b1ynq;
import 'auth/student_identity.dart' as _ipmhl12h;
import 'domain/availability_result.dart' as _i0jrckiv;
import 'domain/equiplink_exception.dart' as _in36mdvu;
import 'domain/equipment_category.dart' as _i39ay6zn;
import 'domain/equipment_listing.dart' as _iz96b8i7;
import 'domain/handover_confirmation.dart' as _ivlvljr1;
import 'domain/rental_request.dart' as _ihit20mm;
import 'domain/rental_review.dart' as _ilrkrvol;
import 'domain/rental_status_history.dart' as _iw7aivv3;
import 'domain/student_profile.dart' as _iw7fsyfy;
import 'greetings/greeting.dart' as _izw8z7ou;
export 'auth/email_otp_challenge.dart';
export 'auth/otp_challenge_response.dart';
export 'auth/student_email_challenge_response.dart';
export 'auth/student_email_verification_challenge.dart';
export 'auth/student_id_card_upload.dart';
export 'auth/student_identity.dart';
export 'domain/availability_result.dart';
export 'domain/equiplink_exception.dart';
export 'domain/equipment_category.dart';
export 'domain/equipment_listing.dart';
export 'domain/handover_confirmation.dart';
export 'domain/rental_request.dart';
export 'domain/rental_review.dart';
export 'domain/rental_status_history.dart';
export 'domain/student_profile.dart';
export 'greetings/greeting.dart';
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _ittyyj72.EmailOtpChallenge) {
      return _ittyyj72.EmailOtpChallenge.fromJson(data) as T;
    }
    if (t == _if3qksxc.OtpChallengeResponse) {
      return _if3qksxc.OtpChallengeResponse.fromJson(data) as T;
    }
    if (t == _ip3dtseu.StudentEmailChallengeResponse) {
      return _ip3dtseu.StudentEmailChallengeResponse.fromJson(data) as T;
    }
    if (t == _i6sm5mkm.StudentEmailVerificationChallenge) {
      return _i6sm5mkm.StudentEmailVerificationChallenge.fromJson(data) as T;
    }
    if (t == _iv0b1ynq.StudentIdCardUpload) {
      return _iv0b1ynq.StudentIdCardUpload.fromJson(data) as T;
    }
    if (t == _ipmhl12h.StudentIdentity) {
      return _ipmhl12h.StudentIdentity.fromJson(data) as T;
    }
    if (t == _i0jrckiv.AvailabilityResult) {
      return _i0jrckiv.AvailabilityResult.fromJson(data) as T;
    }
    if (t == _in36mdvu.EquipLinkException) {
      return _in36mdvu.EquipLinkException.fromJson(data) as T;
    }
    if (t == _i39ay6zn.EquipmentCategory) {
      return _i39ay6zn.EquipmentCategory.fromJson(data) as T;
    }
    if (t == _iz96b8i7.EquipmentListing) {
      return _iz96b8i7.EquipmentListing.fromJson(data) as T;
    }
    if (t == _ivlvljr1.HandoverConfirmation) {
      return _ivlvljr1.HandoverConfirmation.fromJson(data) as T;
    }
    if (t == _ihit20mm.RentalRequest) {
      return _ihit20mm.RentalRequest.fromJson(data) as T;
    }
    if (t == _ilrkrvol.RentalReview) {
      return _ilrkrvol.RentalReview.fromJson(data) as T;
    }
    if (t == _iw7aivv3.RentalStatusHistory) {
      return _iw7aivv3.RentalStatusHistory.fromJson(data) as T;
    }
    if (t == _iw7fsyfy.StudentProfile) {
      return _iw7fsyfy.StudentProfile.fromJson(data) as T;
    }
    if (t == _izw8z7ou.Greeting) {
      return _izw8z7ou.Greeting.fromJson(data) as T;
    }
    if (t == _isc.getType<_ittyyj72.EmailOtpChallenge?>()) {
      return (data != null ? _ittyyj72.EmailOtpChallenge.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_if3qksxc.OtpChallengeResponse?>()) {
      return (data != null
              ? _if3qksxc.OtpChallengeResponse.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ip3dtseu.StudentEmailChallengeResponse?>()) {
      return (data != null
              ? _ip3dtseu.StudentEmailChallengeResponse.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i6sm5mkm.StudentEmailVerificationChallenge?>()) {
      return (data != null
              ? _i6sm5mkm.StudentEmailVerificationChallenge.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iv0b1ynq.StudentIdCardUpload?>()) {
      return (data != null
              ? _iv0b1ynq.StudentIdCardUpload.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ipmhl12h.StudentIdentity?>()) {
      return (data != null ? _ipmhl12h.StudentIdentity.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i0jrckiv.AvailabilityResult?>()) {
      return (data != null ? _i0jrckiv.AvailabilityResult.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_in36mdvu.EquipLinkException?>()) {
      return (data != null ? _in36mdvu.EquipLinkException.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i39ay6zn.EquipmentCategory?>()) {
      return (data != null ? _i39ay6zn.EquipmentCategory.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iz96b8i7.EquipmentListing?>()) {
      return (data != null ? _iz96b8i7.EquipmentListing.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ivlvljr1.HandoverConfirmation?>()) {
      return (data != null
              ? _ivlvljr1.HandoverConfirmation.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ihit20mm.RentalRequest?>()) {
      return (data != null ? _ihit20mm.RentalRequest.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ilrkrvol.RentalReview?>()) {
      return (data != null ? _ilrkrvol.RentalReview.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iw7aivv3.RentalStatusHistory?>()) {
      return (data != null
              ? _iw7aivv3.RentalStatusHistory.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iw7fsyfy.StudentProfile?>()) {
      return (data != null ? _iw7fsyfy.StudentProfile.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_it1dwo0i.EquipmentCategory>) {
      return (data as List)
              .map((e) => deserialize<_it1dwo0i.EquipmentCategory>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i1tbdl19.EquipmentListing>) {
      return (data as List)
              .map((e) => deserialize<_i1tbdl19.EquipmentListing>(e))
              .toList()
          as T;
    }
    if (t == List<_imusbont.RentalRequest>) {
      return (data as List)
              .map((e) => deserialize<_imusbont.RentalRequest>(e))
              .toList()
          as T;
    }
    if (t == List<_ij762k4i.RentalStatusHistory>) {
      return (data as List)
              .map((e) => deserialize<_ij762k4i.RentalStatusHistory>(e))
              .toList()
          as T;
    }
    try {
      return _iaic.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacc.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _ittyyj72.EmailOtpChallenge => 'EmailOtpChallenge',
      _if3qksxc.OtpChallengeResponse => 'OtpChallengeResponse',
      _ip3dtseu.StudentEmailChallengeResponse =>
        'StudentEmailChallengeResponse',
      _i6sm5mkm.StudentEmailVerificationChallenge =>
        'StudentEmailVerificationChallenge',
      _iv0b1ynq.StudentIdCardUpload => 'StudentIdCardUpload',
      _ipmhl12h.StudentIdentity => 'StudentIdentity',
      _i0jrckiv.AvailabilityResult => 'AvailabilityResult',
      _in36mdvu.EquipLinkException => 'EquipLinkException',
      _i39ay6zn.EquipmentCategory => 'EquipmentCategory',
      _iz96b8i7.EquipmentListing => 'EquipmentListing',
      _ivlvljr1.HandoverConfirmation => 'HandoverConfirmation',
      _ihit20mm.RentalRequest => 'RentalRequest',
      _ilrkrvol.RentalReview => 'RentalReview',
      _iw7aivv3.RentalStatusHistory => 'RentalStatusHistory',
      _iw7fsyfy.StudentProfile => 'StudentProfile',
      _izw8z7ou.Greeting => 'Greeting',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('equip_link.', '');
    }

    switch (data) {
      case _ittyyj72.EmailOtpChallenge():
        return 'EmailOtpChallenge';
      case _if3qksxc.OtpChallengeResponse():
        return 'OtpChallengeResponse';
      case _ip3dtseu.StudentEmailChallengeResponse():
        return 'StudentEmailChallengeResponse';
      case _i6sm5mkm.StudentEmailVerificationChallenge():
        return 'StudentEmailVerificationChallenge';
      case _iv0b1ynq.StudentIdCardUpload():
        return 'StudentIdCardUpload';
      case _ipmhl12h.StudentIdentity():
        return 'StudentIdentity';
      case _i0jrckiv.AvailabilityResult():
        return 'AvailabilityResult';
      case _in36mdvu.EquipLinkException():
        return 'EquipLinkException';
      case _i39ay6zn.EquipmentCategory():
        return 'EquipmentCategory';
      case _iz96b8i7.EquipmentListing():
        return 'EquipmentListing';
      case _ivlvljr1.HandoverConfirmation():
        return 'HandoverConfirmation';
      case _ihit20mm.RentalRequest():
        return 'RentalRequest';
      case _ilrkrvol.RentalReview():
        return 'RentalReview';
      case _iw7aivv3.RentalStatusHistory():
        return 'RentalStatusHistory';
      case _iw7fsyfy.StudentProfile():
        return 'StudentProfile';
      case _izw8z7ou.Greeting():
        return 'Greeting';
    }
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'EmailOtpChallenge') {
      return deserialize<_ittyyj72.EmailOtpChallenge>(data['data']);
    }
    if (dataClassName == 'OtpChallengeResponse') {
      return deserialize<_if3qksxc.OtpChallengeResponse>(data['data']);
    }
    if (dataClassName == 'StudentEmailChallengeResponse') {
      return deserialize<_ip3dtseu.StudentEmailChallengeResponse>(data['data']);
    }
    if (dataClassName == 'StudentEmailVerificationChallenge') {
      return deserialize<_i6sm5mkm.StudentEmailVerificationChallenge>(
        data['data'],
      );
    }
    if (dataClassName == 'StudentIdCardUpload') {
      return deserialize<_iv0b1ynq.StudentIdCardUpload>(data['data']);
    }
    if (dataClassName == 'StudentIdentity') {
      return deserialize<_ipmhl12h.StudentIdentity>(data['data']);
    }
    if (dataClassName == 'AvailabilityResult') {
      return deserialize<_i0jrckiv.AvailabilityResult>(data['data']);
    }
    if (dataClassName == 'EquipLinkException') {
      return deserialize<_in36mdvu.EquipLinkException>(data['data']);
    }
    if (dataClassName == 'EquipmentCategory') {
      return deserialize<_i39ay6zn.EquipmentCategory>(data['data']);
    }
    if (dataClassName == 'EquipmentListing') {
      return deserialize<_iz96b8i7.EquipmentListing>(data['data']);
    }
    if (dataClassName == 'HandoverConfirmation') {
      return deserialize<_ivlvljr1.HandoverConfirmation>(data['data']);
    }
    if (dataClassName == 'RentalRequest') {
      return deserialize<_ihit20mm.RentalRequest>(data['data']);
    }
    if (dataClassName == 'RentalReview') {
      return deserialize<_ilrkrvol.RentalReview>(data['data']);
    }
    if (dataClassName == 'RentalStatusHistory') {
      return deserialize<_iw7aivv3.RentalStatusHistory>(data['data']);
    }
    if (dataClassName == 'StudentProfile') {
      return deserialize<_iw7fsyfy.StudentProfile>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_izw8z7ou.Greeting>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('equip_link', this);
    _iacc.Protocol().registerHostProtocol('equip_link', this);
  }

  @override
  String getModuleName() => 'equip_link';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
