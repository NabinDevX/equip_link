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
import 'package:equip_link_client/src/protocol/protocol.dart' as _ix24vv44;
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class EquipmentListing
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  EquipmentListing._({
    this.id,
    required this.ownerId,
    required this.categoryId,
    required this.title,
    required this.description,
    this.hourlyRate,
    required this.dailyRate,
    required this.securityDeposit,
    required this.condition,
    required this.status,
    required this.locationCampus,
    required this.imageUrls,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EquipmentListing({
    int? id,
    required _isc.UuidValue ownerId,
    required int categoryId,
    required String title,
    required String description,
    double? hourlyRate,
    required double dailyRate,
    required double securityDeposit,
    required String condition,
    required String status,
    required String locationCampus,
    required List<String> imageUrls,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _EquipmentListingImpl;

  factory EquipmentListing.fromJson(Map<String, dynamic> jsonSerialization) {
    return EquipmentListing(
      id: jsonSerialization['id'] as int?,
      ownerId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      categoryId: jsonSerialization['categoryId'] as int,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      hourlyRate: (jsonSerialization['hourlyRate'] as num?)?.toDouble(),
      dailyRate: (jsonSerialization['dailyRate'] as num).toDouble(),
      securityDeposit: (jsonSerialization['securityDeposit'] as num).toDouble(),
      condition: jsonSerialization['condition'] as String,
      status: jsonSerialization['status'] as String,
      locationCampus: jsonSerialization['locationCampus'] as String,
      imageUrls: _ix24vv44.Protocol().deserialize<List<String>>(
        jsonSerialization['imageUrls'],
      ),
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

  _isc.UuidValue ownerId;

  int categoryId;

  String title;

  String description;

  double? hourlyRate;

  double dailyRate;

  double securityDeposit;

  String condition;

  String status;

  String locationCampus;

  List<String> imageUrls;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [EquipmentListing]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  EquipmentListing copyWith({
    int? id,
    _isc.UuidValue? ownerId,
    int? categoryId,
    String? title,
    String? description,
    double? hourlyRate,
    double? dailyRate,
    double? securityDeposit,
    String? condition,
    String? status,
    String? locationCampus,
    List<String>? imageUrls,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EquipmentListing',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'categoryId': categoryId,
      'title': title,
      'description': description,
      if (hourlyRate != null) 'hourlyRate': hourlyRate,
      'dailyRate': dailyRate,
      'securityDeposit': securityDeposit,
      'condition': condition,
      'status': status,
      'locationCampus': locationCampus,
      'imageUrls': imageUrls.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EquipmentListing',
      if (id != null) 'id': id,
      'ownerId': ownerId.toJson(),
      'categoryId': categoryId,
      'title': title,
      'description': description,
      if (hourlyRate != null) 'hourlyRate': hourlyRate,
      'dailyRate': dailyRate,
      'securityDeposit': securityDeposit,
      'condition': condition,
      'status': status,
      'locationCampus': locationCampus,
      'imageUrls': imageUrls.toJson(),
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

class _EquipmentListingImpl extends EquipmentListing {
  _EquipmentListingImpl({
    int? id,
    required _isc.UuidValue ownerId,
    required int categoryId,
    required String title,
    required String description,
    double? hourlyRate,
    required double dailyRate,
    required double securityDeposit,
    required String condition,
    required String status,
    required String locationCampus,
    required List<String> imageUrls,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         ownerId: ownerId,
         categoryId: categoryId,
         title: title,
         description: description,
         hourlyRate: hourlyRate,
         dailyRate: dailyRate,
         securityDeposit: securityDeposit,
         condition: condition,
         status: status,
         locationCampus: locationCampus,
         imageUrls: imageUrls,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [EquipmentListing]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  EquipmentListing copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? ownerId,
    int? categoryId,
    String? title,
    String? description,
    Object? hourlyRate = _Undefined,
    double? dailyRate,
    double? securityDeposit,
    String? condition,
    String? status,
    String? locationCampus,
    List<String>? imageUrls,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return EquipmentListing(
      id: id is int? ? id : this.id,
      ownerId: ownerId ?? this.ownerId,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      description: description ?? this.description,
      hourlyRate: hourlyRate is double? ? hourlyRate : this.hourlyRate,
      dailyRate: dailyRate ?? this.dailyRate,
      securityDeposit: securityDeposit ?? this.securityDeposit,
      condition: condition ?? this.condition,
      status: status ?? this.status,
      locationCampus: locationCampus ?? this.locationCampus,
      imageUrls: imageUrls ?? this.imageUrls.map((e0) => e0).toList(),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
