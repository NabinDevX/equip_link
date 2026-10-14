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

abstract class RentalRequest
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RentalRequest._({
    this.id,
    required this.listingId,
    required this.renterId,
    required this.ownerId,
    required this.startDate,
    required this.endDate,
    required this.totalDays,
    required this.dailyRate,
    required this.totalAmount,
    required this.securityDeposit,
    required this.status,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RentalRequest({
    int? id,
    required int listingId,
    required _isc.UuidValue renterId,
    required _isc.UuidValue ownerId,
    required DateTime startDate,
    required DateTime endDate,
    required int totalDays,
    required double dailyRate,
    required double totalAmount,
    required double securityDeposit,
    required String status,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _RentalRequestImpl;

  factory RentalRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return RentalRequest(
      id: jsonSerialization['id'] as int?,
      listingId: jsonSerialization['listingId'] as int,
      renterId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['renterId'],
      ),
      ownerId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      startDate: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['startDate'],
      ),
      endDate: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['endDate'],
      ),
      totalDays: jsonSerialization['totalDays'] as int,
      dailyRate: (jsonSerialization['dailyRate'] as num).toDouble(),
      totalAmount: (jsonSerialization['totalAmount'] as num).toDouble(),
      securityDeposit: (jsonSerialization['securityDeposit'] as num).toDouble(),
      status: jsonSerialization['status'] as String,
      notes: jsonSerialization['notes'] as String?,
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

  int listingId;

  _isc.UuidValue renterId;

  _isc.UuidValue ownerId;

  DateTime startDate;

  DateTime endDate;

  int totalDays;

  double dailyRate;

  double totalAmount;

  double securityDeposit;

  String status;

  String? notes;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [RentalRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RentalRequest copyWith({
    int? id,
    int? listingId,
    _isc.UuidValue? renterId,
    _isc.UuidValue? ownerId,
    DateTime? startDate,
    DateTime? endDate,
    int? totalDays,
    double? dailyRate,
    double? totalAmount,
    double? securityDeposit,
    String? status,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RentalRequest',
      if (id != null) 'id': id,
      'listingId': listingId,
      'renterId': renterId.toJson(),
      'ownerId': ownerId.toJson(),
      'startDate': startDate.toJson(),
      'endDate': endDate.toJson(),
      'totalDays': totalDays,
      'dailyRate': dailyRate,
      'totalAmount': totalAmount,
      'securityDeposit': securityDeposit,
      'status': status,
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RentalRequest',
      if (id != null) 'id': id,
      'listingId': listingId,
      'renterId': renterId.toJson(),
      'ownerId': ownerId.toJson(),
      'startDate': startDate.toJson(),
      'endDate': endDate.toJson(),
      'totalDays': totalDays,
      'dailyRate': dailyRate,
      'totalAmount': totalAmount,
      'securityDeposit': securityDeposit,
      'status': status,
      if (notes != null) 'notes': notes,
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

class _RentalRequestImpl extends RentalRequest {
  _RentalRequestImpl({
    int? id,
    required int listingId,
    required _isc.UuidValue renterId,
    required _isc.UuidValue ownerId,
    required DateTime startDate,
    required DateTime endDate,
    required int totalDays,
    required double dailyRate,
    required double totalAmount,
    required double securityDeposit,
    required String status,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         listingId: listingId,
         renterId: renterId,
         ownerId: ownerId,
         startDate: startDate,
         endDate: endDate,
         totalDays: totalDays,
         dailyRate: dailyRate,
         totalAmount: totalAmount,
         securityDeposit: securityDeposit,
         status: status,
         notes: notes,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [RentalRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RentalRequest copyWith({
    Object? id = _Undefined,
    int? listingId,
    _isc.UuidValue? renterId,
    _isc.UuidValue? ownerId,
    DateTime? startDate,
    DateTime? endDate,
    int? totalDays,
    double? dailyRate,
    double? totalAmount,
    double? securityDeposit,
    String? status,
    Object? notes = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RentalRequest(
      id: id is int? ? id : this.id,
      listingId: listingId ?? this.listingId,
      renterId: renterId ?? this.renterId,
      ownerId: ownerId ?? this.ownerId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      totalDays: totalDays ?? this.totalDays,
      dailyRate: dailyRate ?? this.dailyRate,
      totalAmount: totalAmount ?? this.totalAmount,
      securityDeposit: securityDeposit ?? this.securityDeposit,
      status: status ?? this.status,
      notes: notes is String? ? notes : this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
