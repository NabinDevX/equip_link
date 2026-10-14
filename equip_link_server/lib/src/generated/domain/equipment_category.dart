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

abstract class EquipmentCategory
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
      isActive: _is.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
    );
  }

  static final t = EquipmentCategoryTable();

  static const db = EquipmentCategoryRepository._();

  @override
  int? id;

  String name;

  String slug;

  String? description;

  String? iconName;

  bool isActive;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [EquipmentCategory]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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

  static EquipmentCategoryInclude include() {
    return EquipmentCategoryInclude._();
  }

  static EquipmentCategoryIncludeList includeList({
    _is.WhereExpressionBuilder<EquipmentCategoryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EquipmentCategoryTable>? orderBy,
    _is.OrderByListBuilder<EquipmentCategoryTable>? orderByList,
    EquipmentCategoryInclude? include,
  }) {
    return EquipmentCategoryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EquipmentCategory.t),
      orderByList: orderByList?.call(EquipmentCategory.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
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

class EquipmentCategoryUpdateTable
    extends _is.UpdateTable<EquipmentCategoryTable> {
  EquipmentCategoryUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> slug(String value) => _is.ColumnValue(
    table.slug,
    value,
  );

  _is.ColumnValue<String, String> description(String? value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<String, String> iconName(String? value) => _is.ColumnValue(
    table.iconName,
    value,
  );

  _is.ColumnValue<bool, bool> isActive(bool value) => _is.ColumnValue(
    table.isActive,
    value,
  );
}

class EquipmentCategoryTable extends _is.Table<int?> {
  EquipmentCategoryTable({super.tableRelation})
    : super(tableName: 'equipment_category') {
    updateTable = EquipmentCategoryUpdateTable(this);
    name = _is.ColumnString(
      'name',
      this,
    );
    slug = _is.ColumnString(
      'slug',
      this,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    iconName = _is.ColumnString(
      'iconName',
      this,
    );
    isActive = _is.ColumnBool(
      'isActive',
      this,
    );
  }

  late final EquipmentCategoryUpdateTable updateTable;

  late final _is.ColumnString name;

  late final _is.ColumnString slug;

  late final _is.ColumnString description;

  late final _is.ColumnString iconName;

  late final _is.ColumnBool isActive;

  @override
  List<_is.Column> get columns => [
    id,
    name,
    slug,
    description,
    iconName,
    isActive,
  ];
}

class EquipmentCategoryInclude extends _is.IncludeObject {
  EquipmentCategoryInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => EquipmentCategory.t;
}

class EquipmentCategoryIncludeList extends _is.IncludeList {
  EquipmentCategoryIncludeList._({
    _is.WhereExpressionBuilder<EquipmentCategoryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(EquipmentCategory.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => EquipmentCategory.t;
}

class EquipmentCategoryRepository {
  const EquipmentCategoryRepository._();

  /// Returns a list of [EquipmentCategory]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<EquipmentCategory>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EquipmentCategoryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EquipmentCategoryTable>? orderBy,
    _is.OrderByListBuilder<EquipmentCategoryTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<EquipmentCategory>(
      where: where?.call(EquipmentCategory.t),
      orderBy: orderBy?.call(EquipmentCategory.t),
      orderByList: orderByList?.call(EquipmentCategory.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [EquipmentCategory] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<EquipmentCategory?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EquipmentCategoryTable>? where,
    int? offset,
    _is.OrderByBuilder<EquipmentCategoryTable>? orderBy,
    _is.OrderByListBuilder<EquipmentCategoryTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<EquipmentCategory>(
      where: where?.call(EquipmentCategory.t),
      orderBy: orderBy?.call(EquipmentCategory.t),
      orderByList: orderByList?.call(EquipmentCategory.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [EquipmentCategory] by its [id] or null if no such row exists.
  Future<EquipmentCategory?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<EquipmentCategory>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [EquipmentCategory]s in the list and returns the inserted rows.
  ///
  /// The returned [EquipmentCategory]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EquipmentCategory>> insert(
    _is.DatabaseSession session,
    List<EquipmentCategory> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<EquipmentCategory>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [EquipmentCategory] and returns the inserted row.
  ///
  /// The returned [EquipmentCategory] will have its `id` field set.
  Future<EquipmentCategory> insertRow(
    _is.DatabaseSession session,
    EquipmentCategory row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<EquipmentCategory>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [EquipmentCategory]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [EquipmentCategory]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EquipmentCategory>> upsert(
    _is.DatabaseSession session,
    List<EquipmentCategory> rows, {
    required _is.ColumnSelections<EquipmentCategoryTable> conflictColumns,
    _is.ColumnSelections<EquipmentCategoryTable>? updateColumns,
    _is.WhereExpressionBuilder<EquipmentCategoryTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<EquipmentCategory>(
      rows,
      conflictColumns: conflictColumns(EquipmentCategory.t),
      updateColumns: updateColumns?.call(EquipmentCategory.t),
      updateWhere: updateWhere?.call(EquipmentCategory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [EquipmentCategory] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [EquipmentCategory] will have its `id` field set.
  Future<EquipmentCategory?> upsertRow(
    _is.DatabaseSession session,
    EquipmentCategory row, {
    required _is.ColumnSelections<EquipmentCategoryTable> conflictColumns,
    _is.ColumnSelections<EquipmentCategoryTable>? updateColumns,
    _is.WhereExpressionBuilder<EquipmentCategoryTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<EquipmentCategory>(
      row,
      conflictColumns: conflictColumns(EquipmentCategory.t),
      updateColumns: updateColumns?.call(EquipmentCategory.t),
      updateWhere: updateWhere?.call(EquipmentCategory.t),
      transaction: transaction,
    );
  }

  /// Updates all [EquipmentCategory]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EquipmentCategory>> update(
    _is.DatabaseSession session,
    List<EquipmentCategory> rows, {
    _is.ColumnSelections<EquipmentCategoryTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<EquipmentCategory>(
      rows,
      columns: columns?.call(EquipmentCategory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [EquipmentCategory]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<EquipmentCategory> updateRow(
    _is.DatabaseSession session,
    EquipmentCategory row, {
    _is.ColumnSelections<EquipmentCategoryTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<EquipmentCategory>(
      row,
      columns: columns?.call(EquipmentCategory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EquipmentCategory] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<EquipmentCategory?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<EquipmentCategoryUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<EquipmentCategory>(
      id,
      columnValues: columnValues(EquipmentCategory.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [EquipmentCategory]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EquipmentCategory>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<EquipmentCategoryUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<EquipmentCategoryTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EquipmentCategoryTable>? orderBy,
    _is.OrderByListBuilder<EquipmentCategoryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<EquipmentCategory>(
      columnValues: columnValues(EquipmentCategory.t.updateTable),
      where: where(EquipmentCategory.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EquipmentCategory.t),
      orderByList: orderByList?.call(EquipmentCategory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [EquipmentCategory]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EquipmentCategory>> delete(
    _is.DatabaseSession session,
    List<EquipmentCategory> rows, {
    _is.OrderByBuilder<EquipmentCategoryTable>? orderBy,
    _is.OrderByListBuilder<EquipmentCategoryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<EquipmentCategory>(
      rows,
      orderBy: orderBy?.call(EquipmentCategory.t),
      orderByList: orderByList?.call(EquipmentCategory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [EquipmentCategory].
  Future<EquipmentCategory> deleteRow(
    _is.DatabaseSession session,
    EquipmentCategory row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<EquipmentCategory>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EquipmentCategory>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EquipmentCategoryTable> where,
    _is.OrderByBuilder<EquipmentCategoryTable>? orderBy,
    _is.OrderByListBuilder<EquipmentCategoryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<EquipmentCategory>(
      where: where(EquipmentCategory.t),
      orderBy: orderBy?.call(EquipmentCategory.t),
      orderByList: orderByList?.call(EquipmentCategory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EquipmentCategoryTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<EquipmentCategory>(
      where: where?.call(EquipmentCategory.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [EquipmentCategory] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EquipmentCategoryTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<EquipmentCategory>(
      where: where(EquipmentCategory.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
