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
import 'package:equip_link_server/src/generated/protocol.dart' as _iklid3y9;
import 'package:serverpod/serverpod.dart' as _is;

abstract class EquipmentListing
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
    required _is.UuidValue ownerId,
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
      ownerId: _is.UuidValueJsonExtension.fromJson(
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
      imageUrls: _iklid3y9.Protocol().deserialize<List<String>>(
        jsonSerialization['imageUrls'],
      ),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = EquipmentListingTable();

  static const db = EquipmentListingRepository._();

  @override
  int? id;

  _is.UuidValue ownerId;

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

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [EquipmentListing]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  EquipmentListing copyWith({
    int? id,
    _is.UuidValue? ownerId,
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

  static EquipmentListingInclude include() {
    return EquipmentListingInclude._();
  }

  static EquipmentListingIncludeList includeList({
    _is.WhereExpressionBuilder<EquipmentListingTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EquipmentListingTable>? orderBy,
    _is.OrderByListBuilder<EquipmentListingTable>? orderByList,
    EquipmentListingInclude? include,
  }) {
    return EquipmentListingIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EquipmentListing.t),
      orderByList: orderByList?.call(EquipmentListing.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EquipmentListingImpl extends EquipmentListing {
  _EquipmentListingImpl({
    int? id,
    required _is.UuidValue ownerId,
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
  @_is.useResult
  @override
  EquipmentListing copyWith({
    Object? id = _Undefined,
    _is.UuidValue? ownerId,
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

class EquipmentListingUpdateTable
    extends _is.UpdateTable<EquipmentListingTable> {
  EquipmentListingUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> ownerId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.ownerId,
        value,
      );

  _is.ColumnValue<int, int> categoryId(int value) => _is.ColumnValue(
    table.categoryId,
    value,
  );

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> description(String value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<double, double> hourlyRate(double? value) => _is.ColumnValue(
    table.hourlyRate,
    value,
  );

  _is.ColumnValue<double, double> dailyRate(double value) => _is.ColumnValue(
    table.dailyRate,
    value,
  );

  _is.ColumnValue<double, double> securityDeposit(double value) =>
      _is.ColumnValue(
        table.securityDeposit,
        value,
      );

  _is.ColumnValue<String, String> condition(String value) => _is.ColumnValue(
    table.condition,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> locationCampus(String value) =>
      _is.ColumnValue(
        table.locationCampus,
        value,
      );

  _is.ColumnValue<List<String>, List<String>> imageUrls(List<String> value) =>
      _is.ColumnValue(
        table.imageUrls,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class EquipmentListingTable extends _is.Table<int?> {
  EquipmentListingTable({super.tableRelation})
    : super(tableName: 'equipment_listing') {
    updateTable = EquipmentListingUpdateTable(this);
    ownerId = _is.ColumnUuid(
      'ownerId',
      this,
    );
    categoryId = _is.ColumnInt(
      'categoryId',
      this,
    );
    title = _is.ColumnString(
      'title',
      this,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    hourlyRate = _is.ColumnDouble(
      'hourlyRate',
      this,
    );
    dailyRate = _is.ColumnDouble(
      'dailyRate',
      this,
    );
    securityDeposit = _is.ColumnDouble(
      'securityDeposit',
      this,
    );
    condition = _is.ColumnString(
      'condition',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    locationCampus = _is.ColumnString(
      'locationCampus',
      this,
    );
    imageUrls = _is.ColumnSerializable<List<String>>(
      'imageUrls',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final EquipmentListingUpdateTable updateTable;

  late final _is.ColumnUuid ownerId;

  late final _is.ColumnInt categoryId;

  late final _is.ColumnString title;

  late final _is.ColumnString description;

  late final _is.ColumnDouble hourlyRate;

  late final _is.ColumnDouble dailyRate;

  late final _is.ColumnDouble securityDeposit;

  late final _is.ColumnString condition;

  late final _is.ColumnString status;

  late final _is.ColumnString locationCampus;

  late final _is.ColumnSerializable<List<String>> imageUrls;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    ownerId,
    categoryId,
    title,
    description,
    hourlyRate,
    dailyRate,
    securityDeposit,
    condition,
    status,
    locationCampus,
    imageUrls,
    createdAt,
    updatedAt,
  ];
}

class EquipmentListingInclude extends _is.IncludeObject {
  EquipmentListingInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => EquipmentListing.t;
}

class EquipmentListingIncludeList extends _is.IncludeList {
  EquipmentListingIncludeList._({
    _is.WhereExpressionBuilder<EquipmentListingTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(EquipmentListing.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => EquipmentListing.t;
}

class EquipmentListingRepository {
  const EquipmentListingRepository._();

  /// Returns a list of [EquipmentListing]s matching the given query parameters.
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
  Future<List<EquipmentListing>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EquipmentListingTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EquipmentListingTable>? orderBy,
    _is.OrderByListBuilder<EquipmentListingTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<EquipmentListing>(
      where: where?.call(EquipmentListing.t),
      orderBy: orderBy?.call(EquipmentListing.t),
      orderByList: orderByList?.call(EquipmentListing.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [EquipmentListing] matching the given query parameters.
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
  Future<EquipmentListing?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EquipmentListingTable>? where,
    int? offset,
    _is.OrderByBuilder<EquipmentListingTable>? orderBy,
    _is.OrderByListBuilder<EquipmentListingTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<EquipmentListing>(
      where: where?.call(EquipmentListing.t),
      orderBy: orderBy?.call(EquipmentListing.t),
      orderByList: orderByList?.call(EquipmentListing.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [EquipmentListing] by its [id] or null if no such row exists.
  Future<EquipmentListing?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<EquipmentListing>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [EquipmentListing]s in the list and returns the inserted rows.
  ///
  /// The returned [EquipmentListing]s will have their `id` fields set.
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
  Future<List<EquipmentListing>> insert(
    _is.DatabaseSession session,
    List<EquipmentListing> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<EquipmentListing>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [EquipmentListing] and returns the inserted row.
  ///
  /// The returned [EquipmentListing] will have its `id` field set.
  Future<EquipmentListing> insertRow(
    _is.DatabaseSession session,
    EquipmentListing row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<EquipmentListing>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [EquipmentListing]s in the list and returns the resulting rows.
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
  /// The returned [EquipmentListing]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EquipmentListing>> upsert(
    _is.DatabaseSession session,
    List<EquipmentListing> rows, {
    required _is.ColumnSelections<EquipmentListingTable> conflictColumns,
    _is.ColumnSelections<EquipmentListingTable>? updateColumns,
    _is.WhereExpressionBuilder<EquipmentListingTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<EquipmentListing>(
      rows,
      conflictColumns: conflictColumns(EquipmentListing.t),
      updateColumns: updateColumns?.call(EquipmentListing.t),
      updateWhere: updateWhere?.call(EquipmentListing.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [EquipmentListing] and returns the resulting row.
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
  /// The returned [EquipmentListing] will have its `id` field set.
  Future<EquipmentListing?> upsertRow(
    _is.DatabaseSession session,
    EquipmentListing row, {
    required _is.ColumnSelections<EquipmentListingTable> conflictColumns,
    _is.ColumnSelections<EquipmentListingTable>? updateColumns,
    _is.WhereExpressionBuilder<EquipmentListingTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<EquipmentListing>(
      row,
      conflictColumns: conflictColumns(EquipmentListing.t),
      updateColumns: updateColumns?.call(EquipmentListing.t),
      updateWhere: updateWhere?.call(EquipmentListing.t),
      transaction: transaction,
    );
  }

  /// Updates all [EquipmentListing]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EquipmentListing>> update(
    _is.DatabaseSession session,
    List<EquipmentListing> rows, {
    _is.ColumnSelections<EquipmentListingTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<EquipmentListing>(
      rows,
      columns: columns?.call(EquipmentListing.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [EquipmentListing]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<EquipmentListing> updateRow(
    _is.DatabaseSession session,
    EquipmentListing row, {
    _is.ColumnSelections<EquipmentListingTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<EquipmentListing>(
      row,
      columns: columns?.call(EquipmentListing.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EquipmentListing] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<EquipmentListing?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<EquipmentListingUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<EquipmentListing>(
      id,
      columnValues: columnValues(EquipmentListing.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [EquipmentListing]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EquipmentListing>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<EquipmentListingUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<EquipmentListingTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EquipmentListingTable>? orderBy,
    _is.OrderByListBuilder<EquipmentListingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<EquipmentListing>(
      columnValues: columnValues(EquipmentListing.t.updateTable),
      where: where(EquipmentListing.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EquipmentListing.t),
      orderByList: orderByList?.call(EquipmentListing.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [EquipmentListing]s in the list and returns the deleted rows.
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
  Future<List<EquipmentListing>> delete(
    _is.DatabaseSession session,
    List<EquipmentListing> rows, {
    _is.OrderByBuilder<EquipmentListingTable>? orderBy,
    _is.OrderByListBuilder<EquipmentListingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<EquipmentListing>(
      rows,
      orderBy: orderBy?.call(EquipmentListing.t),
      orderByList: orderByList?.call(EquipmentListing.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [EquipmentListing].
  Future<EquipmentListing> deleteRow(
    _is.DatabaseSession session,
    EquipmentListing row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<EquipmentListing>(
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
  Future<List<EquipmentListing>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EquipmentListingTable> where,
    _is.OrderByBuilder<EquipmentListingTable>? orderBy,
    _is.OrderByListBuilder<EquipmentListingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<EquipmentListing>(
      where: where(EquipmentListing.t),
      orderBy: orderBy?.call(EquipmentListing.t),
      orderByList: orderByList?.call(EquipmentListing.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EquipmentListingTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<EquipmentListing>(
      where: where?.call(EquipmentListing.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [EquipmentListing] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EquipmentListingTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<EquipmentListing>(
      where: where(EquipmentListing.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
