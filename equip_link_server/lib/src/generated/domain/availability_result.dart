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

abstract class AvailabilityResult
    implements _is.SerializableModel, _is.ProtocolSerialization {
  AvailabilityResult._({
    required this.listingId,
    required this.isAvailable,
    required this.conflictingRentalsCount,
    required this.message,
  });

  factory AvailabilityResult({
    required int listingId,
    required bool isAvailable,
    required int conflictingRentalsCount,
    required String message,
  }) = _AvailabilityResultImpl;

  factory AvailabilityResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return AvailabilityResult(
      listingId: jsonSerialization['listingId'] as int,
      isAvailable: _is.BoolJsonExtension.fromJson(
        jsonSerialization['isAvailable'],
      ),
      conflictingRentalsCount:
          jsonSerialization['conflictingRentalsCount'] as int,
      message: jsonSerialization['message'] as String,
    );
  }

  int listingId;

  bool isAvailable;

  int conflictingRentalsCount;

  String message;

  /// Returns a shallow copy of this [AvailabilityResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AvailabilityResult copyWith({
    int? listingId,
    bool? isAvailable,
    int? conflictingRentalsCount,
    String? message,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AvailabilityResult',
      'listingId': listingId,
      'isAvailable': isAvailable,
      'conflictingRentalsCount': conflictingRentalsCount,
      'message': message,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AvailabilityResult',
      'listingId': listingId,
      'isAvailable': isAvailable,
      'conflictingRentalsCount': conflictingRentalsCount,
      'message': message,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _AvailabilityResultImpl extends AvailabilityResult {
  _AvailabilityResultImpl({
    required int listingId,
    required bool isAvailable,
    required int conflictingRentalsCount,
    required String message,
  }) : super._(
         listingId: listingId,
         isAvailable: isAvailable,
         conflictingRentalsCount: conflictingRentalsCount,
         message: message,
       );

  /// Returns a shallow copy of this [AvailabilityResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AvailabilityResult copyWith({
    int? listingId,
    bool? isAvailable,
    int? conflictingRentalsCount,
    String? message,
  }) {
    return AvailabilityResult(
      listingId: listingId ?? this.listingId,
      isAvailable: isAvailable ?? this.isAvailable,
      conflictingRentalsCount:
          conflictingRentalsCount ?? this.conflictingRentalsCount,
      message: message ?? this.message,
    );
  }
}
