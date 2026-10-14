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

abstract class HandoverConfirmation
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  HandoverConfirmation._({
    this.id,
    required this.rentalRequestId,
    required this.type,
    required this.confirmedByOwner,
    required this.confirmedByRenter,
    this.handoverCode,
    this.itemConditionNotes,
    this.confirmedAt,
    required this.createdAt,
  });

  factory HandoverConfirmation({
    int? id,
    required int rentalRequestId,
    required String type,
    required bool confirmedByOwner,
    required bool confirmedByRenter,
    String? handoverCode,
    String? itemConditionNotes,
    DateTime? confirmedAt,
    required DateTime createdAt,
  }) = _HandoverConfirmationImpl;

  factory HandoverConfirmation.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return HandoverConfirmation(
      id: jsonSerialization['id'] as int?,
      rentalRequestId: jsonSerialization['rentalRequestId'] as int,
      type: jsonSerialization['type'] as String,
      confirmedByOwner: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['confirmedByOwner'],
      ),
      confirmedByRenter: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['confirmedByRenter'],
      ),
      handoverCode: jsonSerialization['handoverCode'] as String?,
      itemConditionNotes: jsonSerialization['itemConditionNotes'] as String?,
      confirmedAt: jsonSerialization['confirmedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['confirmedAt'],
            ),
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

  String type;

  bool confirmedByOwner;

  bool confirmedByRenter;

  String? handoverCode;

  String? itemConditionNotes;

  DateTime? confirmedAt;

  DateTime createdAt;

  /// Returns a shallow copy of this [HandoverConfirmation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  HandoverConfirmation copyWith({
    int? id,
    int? rentalRequestId,
    String? type,
    bool? confirmedByOwner,
    bool? confirmedByRenter,
    String? handoverCode,
    String? itemConditionNotes,
    DateTime? confirmedAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'HandoverConfirmation',
      if (id != null) 'id': id,
      'rentalRequestId': rentalRequestId,
      'type': type,
      'confirmedByOwner': confirmedByOwner,
      'confirmedByRenter': confirmedByRenter,
      if (handoverCode != null) 'handoverCode': handoverCode,
      if (itemConditionNotes != null) 'itemConditionNotes': itemConditionNotes,
      if (confirmedAt != null) 'confirmedAt': confirmedAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'HandoverConfirmation',
      if (id != null) 'id': id,
      'rentalRequestId': rentalRequestId,
      'type': type,
      'confirmedByOwner': confirmedByOwner,
      'confirmedByRenter': confirmedByRenter,
      if (handoverCode != null) 'handoverCode': handoverCode,
      if (itemConditionNotes != null) 'itemConditionNotes': itemConditionNotes,
      if (confirmedAt != null) 'confirmedAt': confirmedAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _HandoverConfirmationImpl extends HandoverConfirmation {
  _HandoverConfirmationImpl({
    int? id,
    required int rentalRequestId,
    required String type,
    required bool confirmedByOwner,
    required bool confirmedByRenter,
    String? handoverCode,
    String? itemConditionNotes,
    DateTime? confirmedAt,
    required DateTime createdAt,
  }) : super._(
         id: id,
         rentalRequestId: rentalRequestId,
         type: type,
         confirmedByOwner: confirmedByOwner,
         confirmedByRenter: confirmedByRenter,
         handoverCode: handoverCode,
         itemConditionNotes: itemConditionNotes,
         confirmedAt: confirmedAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [HandoverConfirmation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  HandoverConfirmation copyWith({
    Object? id = _Undefined,
    int? rentalRequestId,
    String? type,
    bool? confirmedByOwner,
    bool? confirmedByRenter,
    Object? handoverCode = _Undefined,
    Object? itemConditionNotes = _Undefined,
    Object? confirmedAt = _Undefined,
    DateTime? createdAt,
  }) {
    return HandoverConfirmation(
      id: id is int? ? id : this.id,
      rentalRequestId: rentalRequestId ?? this.rentalRequestId,
      type: type ?? this.type,
      confirmedByOwner: confirmedByOwner ?? this.confirmedByOwner,
      confirmedByRenter: confirmedByRenter ?? this.confirmedByRenter,
      handoverCode: handoverCode is String? ? handoverCode : this.handoverCode,
      itemConditionNotes: itemConditionNotes is String?
          ? itemConditionNotes
          : this.itemConditionNotes,
      confirmedAt: confirmedAt is DateTime? ? confirmedAt : this.confirmedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
