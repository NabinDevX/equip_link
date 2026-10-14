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

abstract class RentalStatusHistory
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
    required _is.UuidValue changedBy,
    String? notes,
    required DateTime timestamp,
  }) = _RentalStatusHistoryImpl;

  factory RentalStatusHistory.fromJson(Map<String, dynamic> jsonSerialization) {
    return RentalStatusHistory(
      id: jsonSerialization['id'] as int?,
      rentalRequestId: jsonSerialization['rentalRequestId'] as int,
      status: jsonSerialization['status'] as String,
      changedBy: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['changedBy'],
      ),
      notes: jsonSerialization['notes'] as String?,
      timestamp: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
    );
  }

  static final t = RentalStatusHistoryTable();

  static const db = RentalStatusHistoryRepository._();

  @override
  int? id;

  int rentalRequestId;

  String status;

  _is.UuidValue changedBy;

  String? notes;

  DateTime timestamp;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [RentalStatusHistory]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RentalStatusHistory copyWith({
    int? id,
    int? rentalRequestId,
    String? status,
    _is.UuidValue? changedBy,
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

  static RentalStatusHistoryInclude include() {
    return RentalStatusHistoryInclude._();
  }

  static RentalStatusHistoryIncludeList includeList({
    _is.WhereExpressionBuilder<RentalStatusHistoryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RentalStatusHistoryTable>? orderBy,
    _is.OrderByListBuilder<RentalStatusHistoryTable>? orderByList,
    RentalStatusHistoryInclude? include,
  }) {
    return RentalStatusHistoryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RentalStatusHistory.t),
      orderByList: orderByList?.call(RentalStatusHistory.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RentalStatusHistoryImpl extends RentalStatusHistory {
  _RentalStatusHistoryImpl({
    int? id,
    required int rentalRequestId,
    required String status,
    required _is.UuidValue changedBy,
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
  @_is.useResult
  @override
  RentalStatusHistory copyWith({
    Object? id = _Undefined,
    int? rentalRequestId,
    String? status,
    _is.UuidValue? changedBy,
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

class RentalStatusHistoryUpdateTable
    extends _is.UpdateTable<RentalStatusHistoryTable> {
  RentalStatusHistoryUpdateTable(super.table);

  _is.ColumnValue<int, int> rentalRequestId(int value) => _is.ColumnValue(
    table.rentalRequestId,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> changedBy(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.changedBy,
    value,
  );

  _is.ColumnValue<String, String> notes(String? value) => _is.ColumnValue(
    table.notes,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> timestamp(DateTime value) =>
      _is.ColumnValue(
        table.timestamp,
        value,
      );
}

class RentalStatusHistoryTable extends _is.Table<int?> {
  RentalStatusHistoryTable({super.tableRelation})
    : super(tableName: 'rental_status_history') {
    updateTable = RentalStatusHistoryUpdateTable(this);
    rentalRequestId = _is.ColumnInt(
      'rentalRequestId',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    changedBy = _is.ColumnUuid(
      'changedBy',
      this,
    );
    notes = _is.ColumnString(
      'notes',
      this,
    );
    timestamp = _is.ColumnDateTime(
      'timestamp',
      this,
    );
  }

  late final RentalStatusHistoryUpdateTable updateTable;

  late final _is.ColumnInt rentalRequestId;

  late final _is.ColumnString status;

  late final _is.ColumnUuid changedBy;

  late final _is.ColumnString notes;

  late final _is.ColumnDateTime timestamp;

  @override
  List<_is.Column> get columns => [
    id,
    rentalRequestId,
    status,
    changedBy,
    notes,
    timestamp,
  ];
}

class RentalStatusHistoryInclude extends _is.IncludeObject {
  RentalStatusHistoryInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => RentalStatusHistory.t;
}

class RentalStatusHistoryIncludeList extends _is.IncludeList {
  RentalStatusHistoryIncludeList._({
    _is.WhereExpressionBuilder<RentalStatusHistoryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RentalStatusHistory.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => RentalStatusHistory.t;
}

class RentalStatusHistoryRepository {
  const RentalStatusHistoryRepository._();

  /// Returns a list of [RentalStatusHistory]s matching the given query parameters.
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
  Future<List<RentalStatusHistory>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RentalStatusHistoryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RentalStatusHistoryTable>? orderBy,
    _is.OrderByListBuilder<RentalStatusHistoryTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RentalStatusHistory>(
      where: where?.call(RentalStatusHistory.t),
      orderBy: orderBy?.call(RentalStatusHistory.t),
      orderByList: orderByList?.call(RentalStatusHistory.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RentalStatusHistory] matching the given query parameters.
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
  Future<RentalStatusHistory?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RentalStatusHistoryTable>? where,
    int? offset,
    _is.OrderByBuilder<RentalStatusHistoryTable>? orderBy,
    _is.OrderByListBuilder<RentalStatusHistoryTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RentalStatusHistory>(
      where: where?.call(RentalStatusHistory.t),
      orderBy: orderBy?.call(RentalStatusHistory.t),
      orderByList: orderByList?.call(RentalStatusHistory.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RentalStatusHistory] by its [id] or null if no such row exists.
  Future<RentalStatusHistory?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RentalStatusHistory>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RentalStatusHistory]s in the list and returns the inserted rows.
  ///
  /// The returned [RentalStatusHistory]s will have their `id` fields set.
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
  Future<List<RentalStatusHistory>> insert(
    _is.DatabaseSession session,
    List<RentalStatusHistory> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<RentalStatusHistory>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [RentalStatusHistory] and returns the inserted row.
  ///
  /// The returned [RentalStatusHistory] will have its `id` field set.
  Future<RentalStatusHistory> insertRow(
    _is.DatabaseSession session,
    RentalStatusHistory row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<RentalStatusHistory>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [RentalStatusHistory]s in the list and returns the resulting rows.
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
  /// The returned [RentalStatusHistory]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RentalStatusHistory>> upsert(
    _is.DatabaseSession session,
    List<RentalStatusHistory> rows, {
    required _is.ColumnSelections<RentalStatusHistoryTable> conflictColumns,
    _is.ColumnSelections<RentalStatusHistoryTable>? updateColumns,
    _is.WhereExpressionBuilder<RentalStatusHistoryTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<RentalStatusHistory>(
      rows,
      conflictColumns: conflictColumns(RentalStatusHistory.t),
      updateColumns: updateColumns?.call(RentalStatusHistory.t),
      updateWhere: updateWhere?.call(RentalStatusHistory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [RentalStatusHistory] and returns the resulting row.
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
  /// The returned [RentalStatusHistory] will have its `id` field set.
  Future<RentalStatusHistory?> upsertRow(
    _is.DatabaseSession session,
    RentalStatusHistory row, {
    required _is.ColumnSelections<RentalStatusHistoryTable> conflictColumns,
    _is.ColumnSelections<RentalStatusHistoryTable>? updateColumns,
    _is.WhereExpressionBuilder<RentalStatusHistoryTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<RentalStatusHistory>(
      row,
      conflictColumns: conflictColumns(RentalStatusHistory.t),
      updateColumns: updateColumns?.call(RentalStatusHistory.t),
      updateWhere: updateWhere?.call(RentalStatusHistory.t),
      transaction: transaction,
    );
  }

  /// Updates all [RentalStatusHistory]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RentalStatusHistory>> update(
    _is.DatabaseSession session,
    List<RentalStatusHistory> rows, {
    _is.ColumnSelections<RentalStatusHistoryTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<RentalStatusHistory>(
      rows,
      columns: columns?.call(RentalStatusHistory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [RentalStatusHistory]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RentalStatusHistory> updateRow(
    _is.DatabaseSession session,
    RentalStatusHistory row, {
    _is.ColumnSelections<RentalStatusHistoryTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<RentalStatusHistory>(
      row,
      columns: columns?.call(RentalStatusHistory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RentalStatusHistory] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RentalStatusHistory?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<RentalStatusHistoryUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<RentalStatusHistory>(
      id,
      columnValues: columnValues(RentalStatusHistory.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RentalStatusHistory]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RentalStatusHistory>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RentalStatusHistoryUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<RentalStatusHistoryTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RentalStatusHistoryTable>? orderBy,
    _is.OrderByListBuilder<RentalStatusHistoryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<RentalStatusHistory>(
      columnValues: columnValues(RentalStatusHistory.t.updateTable),
      where: where(RentalStatusHistory.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RentalStatusHistory.t),
      orderByList: orderByList?.call(RentalStatusHistory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [RentalStatusHistory]s in the list and returns the deleted rows.
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
  Future<List<RentalStatusHistory>> delete(
    _is.DatabaseSession session,
    List<RentalStatusHistory> rows, {
    _is.OrderByBuilder<RentalStatusHistoryTable>? orderBy,
    _is.OrderByListBuilder<RentalStatusHistoryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<RentalStatusHistory>(
      rows,
      orderBy: orderBy?.call(RentalStatusHistory.t),
      orderByList: orderByList?.call(RentalStatusHistory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [RentalStatusHistory].
  Future<RentalStatusHistory> deleteRow(
    _is.DatabaseSession session,
    RentalStatusHistory row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RentalStatusHistory>(
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
  Future<List<RentalStatusHistory>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RentalStatusHistoryTable> where,
    _is.OrderByBuilder<RentalStatusHistoryTable>? orderBy,
    _is.OrderByListBuilder<RentalStatusHistoryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<RentalStatusHistory>(
      where: where(RentalStatusHistory.t),
      orderBy: orderBy?.call(RentalStatusHistory.t),
      orderByList: orderByList?.call(RentalStatusHistory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RentalStatusHistoryTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<RentalStatusHistory>(
      where: where?.call(RentalStatusHistory.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RentalStatusHistory] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RentalStatusHistoryTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RentalStatusHistory>(
      where: where(RentalStatusHistory.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
