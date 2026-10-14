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

abstract class RentalReview
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RentalReview._({
    this.id,
    required this.rentalRequestId,
    required this.reviewerId,
    required this.revieweeId,
    required this.listingId,
    required this.rating,
    this.comment,
    required this.createdAt,
  });

  factory RentalReview({
    int? id,
    required int rentalRequestId,
    required _isc.UuidValue reviewerId,
    required _isc.UuidValue revieweeId,
    required int listingId,
    required int rating,
    String? comment,
    required DateTime createdAt,
  }) = _RentalReviewImpl;

  factory RentalReview.fromJson(Map<String, dynamic> jsonSerialization) {
    return RentalReview(
      id: jsonSerialization['id'] as int?,
      rentalRequestId: jsonSerialization['rentalRequestId'] as int,
      reviewerId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['reviewerId'],
      ),
      revieweeId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['revieweeId'],
      ),
      listingId: jsonSerialization['listingId'] as int,
      rating: jsonSerialization['rating'] as int,
      comment: jsonSerialization['comment'] as String?,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int rentalRequestId;

  _isc.UuidValue reviewerId;

  _isc.UuidValue revieweeId;

  int listingId;

  int rating;

  String? comment;

  DateTime createdAt;

  /// Returns a shallow copy of this [RentalReview]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RentalReview copyWith({
    int? id,
    int? rentalRequestId,
    _isc.UuidValue? reviewerId,
    _isc.UuidValue? revieweeId,
    int? listingId,
    int? rating,
    String? comment,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RentalReview',
      if (id != null) 'id': id,
      'rentalRequestId': rentalRequestId,
      'reviewerId': reviewerId.toJson(),
      'revieweeId': revieweeId.toJson(),
      'listingId': listingId,
      'rating': rating,
      if (comment != null) 'comment': comment,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RentalReview',
      if (id != null) 'id': id,
      'rentalRequestId': rentalRequestId,
      'reviewerId': reviewerId.toJson(),
      'revieweeId': revieweeId.toJson(),
      'listingId': listingId,
      'rating': rating,
      if (comment != null) 'comment': comment,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RentalReviewImpl extends RentalReview {
  _RentalReviewImpl({
    int? id,
    required int rentalRequestId,
    required _isc.UuidValue reviewerId,
    required _isc.UuidValue revieweeId,
    required int listingId,
    required int rating,
    String? comment,
    required DateTime createdAt,
  }) : super._(
         id: id,
         rentalRequestId: rentalRequestId,
         reviewerId: reviewerId,
         revieweeId: revieweeId,
         listingId: listingId,
         rating: rating,
         comment: comment,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [RentalReview]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RentalReview copyWith({
    Object? id = _Undefined,
    int? rentalRequestId,
    _isc.UuidValue? reviewerId,
    _isc.UuidValue? revieweeId,
    int? listingId,
    int? rating,
    Object? comment = _Undefined,
    DateTime? createdAt,
  }) {
    return RentalReview(
      id: id is int? ? id : this.id,
      rentalRequestId: rentalRequestId ?? this.rentalRequestId,
      reviewerId: reviewerId ?? this.reviewerId,
      revieweeId: revieweeId ?? this.revieweeId,
      listingId: listingId ?? this.listingId,
      rating: rating ?? this.rating,
      comment: comment is String? ? comment : this.comment,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
