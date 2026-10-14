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

abstract class EquipmentCategory
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  EquipmentCategory._({
    this.id,
    required this.name,
    required this.slug,
    this.description,
    this.iconName,
    required this.isActive,
  });

  factory EquipmentCategory({
    int? id,
    required String name,
    required String slug,
    String? description,
    String? iconName,
    required bool isActive,
  }) = _EquipmentCategoryImpl;

  factory EquipmentCategory.fromJson(Map<String, dynamic> jsonSerialization) {
    return EquipmentCategory(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      slug: jsonSerialization['slug'] as String,
      description: jsonSerialization['description'] as String?,
      iconName: jsonSerialization['iconName'] as String?,
      isActive: _isc.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String slug;

  String? description;

  String? iconName;

  bool isActive;

  /// Returns a shallow copy of this [EquipmentCategory]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  EquipmentCategory copyWith({
    int? id,
    String? name,
    String? slug,
    String? description,
    String? iconName,
    bool? isActive,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EquipmentCategory',
      if (id != null) 'id': id,
      'name': name,
      'slug': slug,
      if (description != null) 'description': description,
      if (iconName != null) 'iconName': iconName,
      'isActive': isActive,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EquipmentCategory',
      if (id != null) 'id': id,
      'name': name,
      'slug': slug,
      if (description != null) 'description': description,
      if (iconName != null) 'iconName': iconName,
      'isActive': isActive,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EquipmentCategoryImpl extends EquipmentCategory {
  _EquipmentCategoryImpl({
    int? id,
    required String name,
    required String slug,
    String? description,
    String? iconName,
    required bool isActive,
  }) : super._(
         id: id,
         name: name,
         slug: slug,
         description: description,
         iconName: iconName,
         isActive: isActive,
       );

  /// Returns a shallow copy of this [EquipmentCategory]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  EquipmentCategory copyWith({
    Object? id = _Undefined,
    String? name,
    String? slug,
    Object? description = _Undefined,
    Object? iconName = _Undefined,
    bool? isActive,
  }) {
    return EquipmentCategory(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      description: description is String? ? description : this.description,
      iconName: iconName is String? ? iconName : this.iconName,
      isActive: isActive ?? this.isActive,
    );
  }
}
