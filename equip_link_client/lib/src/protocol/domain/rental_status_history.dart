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

abstract class RentalStatusHistory
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RentalStatusHistory._({
    this.id,
    required this.rentalRequestId,
    required this.status,
    required this.changedBy,
    this.notes,
    required this.timestamp,
  });

  factory RentalStatusHistory({
    int? id,
    required int rentalRequestId,
    required String status,
    required _isc.UuidValue changedBy,
    String? notes,
    required DateTime timestamp,
  }) = _RentalStatusHistoryImpl;

  factory RentalStatusHistory.fromJson(Map<String, dynamic> jsonSerialization) {
    return RentalStatusHistory(
      id: jsonSerialization['id'] as int?,
      rentalRequestId: jsonSerialization['rentalRequestId'] as int,
      status: jsonSerialization['status'] as String,
      changedBy: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['changedBy'],
      ),
      notes: jsonSerialization['notes'] as String?,
      timestamp: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int rentalRequestId;

  String status;

  _isc.UuidValue changedBy;

  String? notes;

  DateTime timestamp;

  /// Returns a shallow copy of this [RentalStatusHistory]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RentalStatusHistory copyWith({
    int? id,
    int? rentalRequestId,
    String? status,
    _isc.UuidValue? changedBy,
    String? notes,
    DateTime? timestamp,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RentalStatusHistory',
      if (id != null) 'id': id,
      'rentalRequestId': rentalRequestId,
      'status': status,
      'changedBy': changedBy.toJson(),
      if (notes != null) 'notes': notes,
      'timestamp': timestamp.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RentalStatusHistory',
      if (id != null) 'id': id,
      'rentalRequestId': rentalRequestId,
      'status': status,
      'changedBy': changedBy.toJson(),
      if (notes != null) 'notes': notes,
      'timestamp': timestamp.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RentalStatusHistoryImpl extends RentalStatusHistory {
  _RentalStatusHistoryImpl({
    int? id,
    required int rentalRequestId,
    required String status,
    required _isc.UuidValue changedBy,
    String? notes,
    required DateTime timestamp,
  }) : super._(
         id: id,
         rentalRequestId: rentalRequestId,
         status: status,
         changedBy: changedBy,
         notes: notes,
         timestamp: timestamp,
       );

  /// Returns a shallow copy of this [RentalStatusHistory]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RentalStatusHistory copyWith({
    Object? id = _Undefined,
    int? rentalRequestId,
    String? status,
    _isc.UuidValue? changedBy,
    Object? notes = _Undefined,
    DateTime? timestamp,
  }) {
    return RentalStatusHistory(
      id: id is int? ? id : this.id,
      rentalRequestId: rentalRequestId ?? this.rentalRequestId,
      status: status ?? this.status,
      changedBy: changedBy ?? this.changedBy,
      notes: notes is String? ? notes : this.notes,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
