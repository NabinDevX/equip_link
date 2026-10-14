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

abstract class HandoverConfirmation
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
      confirmedByOwner: _is.BoolJsonExtension.fromJson(
        jsonSerialization['confirmedByOwner'],
      ),
      confirmedByRenter: _is.BoolJsonExtension.fromJson(
        jsonSerialization['confirmedByRenter'],
      ),
      handoverCode: jsonSerialization['handoverCode'] as String?,
      itemConditionNotes: jsonSerialization['itemConditionNotes'] as String?,
      confirmedAt: jsonSerialization['confirmedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['confirmedAt'],
            ),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = HandoverConfirmationTable();

  static const db = HandoverConfirmationRepository._();

  @override
  int? id;

  int rentalRequestId;

  String type;

  bool confirmedByOwner;

  bool confirmedByRenter;

  String? handoverCode;

  String? itemConditionNotes;

  DateTime? confirmedAt;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [HandoverConfirmation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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

  static HandoverConfirmationInclude include() {
    return HandoverConfirmationInclude._();
  }

  static HandoverConfirmationIncludeList includeList({
    _is.WhereExpressionBuilder<HandoverConfirmationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<HandoverConfirmationTable>? orderBy,
    _is.OrderByListBuilder<HandoverConfirmationTable>? orderByList,
    HandoverConfirmationInclude? include,
  }) {
    return HandoverConfirmationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(HandoverConfirmation.t),
      orderByList: orderByList?.call(HandoverConfirmation.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
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

class HandoverConfirmationUpdateTable
    extends _is.UpdateTable<HandoverConfirmationTable> {
  HandoverConfirmationUpdateTable(super.table);

  _is.ColumnValue<int, int> rentalRequestId(int value) => _is.ColumnValue(
    table.rentalRequestId,
    value,
  );

  _is.ColumnValue<String, String> type(String value) => _is.ColumnValue(
    table.type,
    value,
  );

  _is.ColumnValue<bool, bool> confirmedByOwner(bool value) => _is.ColumnValue(
    table.confirmedByOwner,
    value,
  );

  _is.ColumnValue<bool, bool> confirmedByRenter(bool value) => _is.ColumnValue(
    table.confirmedByRenter,
    value,
  );

  _is.ColumnValue<String, String> handoverCode(String? value) =>
      _is.ColumnValue(
        table.handoverCode,
        value,
      );

  _is.ColumnValue<String, String> itemConditionNotes(String? value) =>
      _is.ColumnValue(
        table.itemConditionNotes,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> confirmedAt(DateTime? value) =>
      _is.ColumnValue(
        table.confirmedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class HandoverConfirmationTable extends _is.Table<int?> {
  HandoverConfirmationTable({super.tableRelation})
    : super(tableName: 'handover_confirmation') {
    updateTable = HandoverConfirmationUpdateTable(this);
    rentalRequestId = _is.ColumnInt(
      'rentalRequestId',
      this,
    );
    type = _is.ColumnString(
      'type',
      this,
    );
    confirmedByOwner = _is.ColumnBool(
      'confirmedByOwner',
      this,
    );
    confirmedByRenter = _is.ColumnBool(
      'confirmedByRenter',
      this,
    );
    handoverCode = _is.ColumnString(
      'handoverCode',
      this,
    );
    itemConditionNotes = _is.ColumnString(
      'itemConditionNotes',
      this,
    );
    confirmedAt = _is.ColumnDateTime(
      'confirmedAt',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final HandoverConfirmationUpdateTable updateTable;

  late final _is.ColumnInt rentalRequestId;

  late final _is.ColumnString type;

  late final _is.ColumnBool confirmedByOwner;

  late final _is.ColumnBool confirmedByRenter;

  late final _is.ColumnString handoverCode;

  late final _is.ColumnString itemConditionNotes;

  late final _is.ColumnDateTime confirmedAt;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    rentalRequestId,
    type,
    confirmedByOwner,
    confirmedByRenter,
    handoverCode,
    itemConditionNotes,
    confirmedAt,
    createdAt,
  ];
}

class HandoverConfirmationInclude extends _is.IncludeObject {
  HandoverConfirmationInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => HandoverConfirmation.t;
}

class HandoverConfirmationIncludeList extends _is.IncludeList {
  HandoverConfirmationIncludeList._({
    _is.WhereExpressionBuilder<HandoverConfirmationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(HandoverConfirmation.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => HandoverConfirmation.t;
}

class HandoverConfirmationRepository {
  const HandoverConfirmationRepository._();

  /// Returns a list of [HandoverConfirmation]s matching the given query parameters.
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
  Future<List<HandoverConfirmation>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<HandoverConfirmationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<HandoverConfirmationTable>? orderBy,
    _is.OrderByListBuilder<HandoverConfirmationTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<HandoverConfirmation>(
      where: where?.call(HandoverConfirmation.t),
      orderBy: orderBy?.call(HandoverConfirmation.t),
      orderByList: orderByList?.call(HandoverConfirmation.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [HandoverConfirmation] matching the given query parameters.
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
  Future<HandoverConfirmation?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<HandoverConfirmationTable>? where,
    int? offset,
    _is.OrderByBuilder<HandoverConfirmationTable>? orderBy,
    _is.OrderByListBuilder<HandoverConfirmationTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<HandoverConfirmation>(
      where: where?.call(HandoverConfirmation.t),
      orderBy: orderBy?.call(HandoverConfirmation.t),
      orderByList: orderByList?.call(HandoverConfirmation.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [HandoverConfirmation] by its [id] or null if no such row exists.
  Future<HandoverConfirmation?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<HandoverConfirmation>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [HandoverConfirmation]s in the list and returns the inserted rows.
  ///
  /// The returned [HandoverConfirmation]s will have their `id` fields set.
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
  Future<List<HandoverConfirmation>> insert(
    _is.DatabaseSession session,
    List<HandoverConfirmation> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<HandoverConfirmation>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [HandoverConfirmation] and returns the inserted row.
  ///
  /// The returned [HandoverConfirmation] will have its `id` field set.
  Future<HandoverConfirmation> insertRow(
    _is.DatabaseSession session,
    HandoverConfirmation row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<HandoverConfirmation>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [HandoverConfirmation]s in the list and returns the resulting rows.
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
  /// The returned [HandoverConfirmation]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<HandoverConfirmation>> upsert(
    _is.DatabaseSession session,
    List<HandoverConfirmation> rows, {
    required _is.ColumnSelections<HandoverConfirmationTable> conflictColumns,
    _is.ColumnSelections<HandoverConfirmationTable>? updateColumns,
    _is.WhereExpressionBuilder<HandoverConfirmationTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<HandoverConfirmation>(
      rows,
      conflictColumns: conflictColumns(HandoverConfirmation.t),
      updateColumns: updateColumns?.call(HandoverConfirmation.t),
      updateWhere: updateWhere?.call(HandoverConfirmation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [HandoverConfirmation] and returns the resulting row.
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
  /// The returned [HandoverConfirmation] will have its `id` field set.
  Future<HandoverConfirmation?> upsertRow(
    _is.DatabaseSession session,
    HandoverConfirmation row, {
    required _is.ColumnSelections<HandoverConfirmationTable> conflictColumns,
    _is.ColumnSelections<HandoverConfirmationTable>? updateColumns,
    _is.WhereExpressionBuilder<HandoverConfirmationTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<HandoverConfirmation>(
      row,
      conflictColumns: conflictColumns(HandoverConfirmation.t),
      updateColumns: updateColumns?.call(HandoverConfirmation.t),
      updateWhere: updateWhere?.call(HandoverConfirmation.t),
      transaction: transaction,
    );
  }

  /// Updates all [HandoverConfirmation]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<HandoverConfirmation>> update(
    _is.DatabaseSession session,
    List<HandoverConfirmation> rows, {
    _is.ColumnSelections<HandoverConfirmationTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<HandoverConfirmation>(
      rows,
      columns: columns?.call(HandoverConfirmation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [HandoverConfirmation]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<HandoverConfirmation> updateRow(
    _is.DatabaseSession session,
    HandoverConfirmation row, {
    _is.ColumnSelections<HandoverConfirmationTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<HandoverConfirmation>(
      row,
      columns: columns?.call(HandoverConfirmation.t),
      transaction: transaction,
    );
  }

  /// Updates a single [HandoverConfirmation] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<HandoverConfirmation?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<HandoverConfirmationUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<HandoverConfirmation>(
      id,
      columnValues: columnValues(HandoverConfirmation.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [HandoverConfirmation]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<HandoverConfirmation>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<HandoverConfirmationUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<HandoverConfirmationTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<HandoverConfirmationTable>? orderBy,
    _is.OrderByListBuilder<HandoverConfirmationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<HandoverConfirmation>(
      columnValues: columnValues(HandoverConfirmation.t.updateTable),
      where: where(HandoverConfirmation.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(HandoverConfirmation.t),
      orderByList: orderByList?.call(HandoverConfirmation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [HandoverConfirmation]s in the list and returns the deleted rows.
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
  Future<List<HandoverConfirmation>> delete(
    _is.DatabaseSession session,
    List<HandoverConfirmation> rows, {
    _is.OrderByBuilder<HandoverConfirmationTable>? orderBy,
    _is.OrderByListBuilder<HandoverConfirmationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<HandoverConfirmation>(
      rows,
      orderBy: orderBy?.call(HandoverConfirmation.t),
      orderByList: orderByList?.call(HandoverConfirmation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [HandoverConfirmation].
  Future<HandoverConfirmation> deleteRow(
    _is.DatabaseSession session,
    HandoverConfirmation row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<HandoverConfirmation>(
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
  Future<List<HandoverConfirmation>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<HandoverConfirmationTable> where,
    _is.OrderByBuilder<HandoverConfirmationTable>? orderBy,
    _is.OrderByListBuilder<HandoverConfirmationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<HandoverConfirmation>(
      where: where(HandoverConfirmation.t),
      orderBy: orderBy?.call(HandoverConfirmation.t),
      orderByList: orderByList?.call(HandoverConfirmation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<HandoverConfirmationTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<HandoverConfirmation>(
      where: where?.call(HandoverConfirmation.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [HandoverConfirmation] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<HandoverConfirmationTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<HandoverConfirmation>(
      where: where(HandoverConfirmation.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
