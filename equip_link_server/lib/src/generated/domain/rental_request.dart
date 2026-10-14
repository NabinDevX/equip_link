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

abstract class RentalRequest
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
    required _is.UuidValue renterId,
    required _is.UuidValue ownerId,
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
      renterId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['renterId'],
      ),
      ownerId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      startDate: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['startDate'],
      ),
      endDate: _is.DateTimeJsonExtension.fromJson(jsonSerialization['endDate']),
      totalDays: jsonSerialization['totalDays'] as int,
      dailyRate: (jsonSerialization['dailyRate'] as num).toDouble(),
      totalAmount: (jsonSerialization['totalAmount'] as num).toDouble(),
      securityDeposit: (jsonSerialization['securityDeposit'] as num).toDouble(),
      status: jsonSerialization['status'] as String,
      notes: jsonSerialization['notes'] as String?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = RentalRequestTable();

  static const db = RentalRequestRepository._();

  @override
  int? id;

  int listingId;

  _is.UuidValue renterId;

  _is.UuidValue ownerId;

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

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [RentalRequest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RentalRequest copyWith({
    int? id,
    int? listingId,
    _is.UuidValue? renterId,
    _is.UuidValue? ownerId,
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

  static RentalRequestInclude include() {
    return RentalRequestInclude._();
  }

  static RentalRequestIncludeList includeList({
    _is.WhereExpressionBuilder<RentalRequestTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RentalRequestTable>? orderBy,
    _is.OrderByListBuilder<RentalRequestTable>? orderByList,
    RentalRequestInclude? include,
  }) {
    return RentalRequestIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RentalRequest.t),
      orderByList: orderByList?.call(RentalRequest.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RentalRequestImpl extends RentalRequest {
  _RentalRequestImpl({
    int? id,
    required int listingId,
    required _is.UuidValue renterId,
    required _is.UuidValue ownerId,
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
  @_is.useResult
  @override
  RentalRequest copyWith({
    Object? id = _Undefined,
    int? listingId,
    _is.UuidValue? renterId,
    _is.UuidValue? ownerId,
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

class RentalRequestUpdateTable extends _is.UpdateTable<RentalRequestTable> {
  RentalRequestUpdateTable(super.table);

  _is.ColumnValue<int, int> listingId(int value) => _is.ColumnValue(
    table.listingId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> renterId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.renterId,
        value,
      );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> ownerId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.ownerId,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> startDate(DateTime value) =>
      _is.ColumnValue(
        table.startDate,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> endDate(DateTime value) =>
      _is.ColumnValue(
        table.endDate,
        value,
      );

  _is.ColumnValue<int, int> totalDays(int value) => _is.ColumnValue(
    table.totalDays,
    value,
  );

  _is.ColumnValue<double, double> dailyRate(double value) => _is.ColumnValue(
    table.dailyRate,
    value,
  );

  _is.ColumnValue<double, double> totalAmount(double value) => _is.ColumnValue(
    table.totalAmount,
    value,
  );

  _is.ColumnValue<double, double> securityDeposit(double value) =>
      _is.ColumnValue(
        table.securityDeposit,
        value,
      );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> notes(String? value) => _is.ColumnValue(
    table.notes,
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

class RentalRequestTable extends _is.Table<int?> {
  RentalRequestTable({super.tableRelation})
    : super(tableName: 'rental_request') {
    updateTable = RentalRequestUpdateTable(this);
    listingId = _is.ColumnInt(
      'listingId',
      this,
    );
    renterId = _is.ColumnUuid(
      'renterId',
      this,
    );
    ownerId = _is.ColumnUuid(
      'ownerId',
      this,
    );
    startDate = _is.ColumnDateTime(
      'startDate',
      this,
    );
    endDate = _is.ColumnDateTime(
      'endDate',
      this,
    );
    totalDays = _is.ColumnInt(
      'totalDays',
      this,
    );
    dailyRate = _is.ColumnDouble(
      'dailyRate',
      this,
    );
    totalAmount = _is.ColumnDouble(
      'totalAmount',
      this,
    );
    securityDeposit = _is.ColumnDouble(
      'securityDeposit',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    notes = _is.ColumnString(
      'notes',
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

  late final RentalRequestUpdateTable updateTable;

  late final _is.ColumnInt listingId;

  late final _is.ColumnUuid renterId;

  late final _is.ColumnUuid ownerId;

  late final _is.ColumnDateTime startDate;

  late final _is.ColumnDateTime endDate;

  late final _is.ColumnInt totalDays;

  late final _is.ColumnDouble dailyRate;

  late final _is.ColumnDouble totalAmount;

  late final _is.ColumnDouble securityDeposit;

  late final _is.ColumnString status;

  late final _is.ColumnString notes;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    listingId,
    renterId,
    ownerId,
    startDate,
    endDate,
    totalDays,
    dailyRate,
    totalAmount,
    securityDeposit,
    status,
    notes,
    createdAt,
    updatedAt,
  ];
}

class RentalRequestInclude extends _is.IncludeObject {
  RentalRequestInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => RentalRequest.t;
}

class RentalRequestIncludeList extends _is.IncludeList {
  RentalRequestIncludeList._({
    _is.WhereExpressionBuilder<RentalRequestTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RentalRequest.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => RentalRequest.t;
}

class RentalRequestRepository {
  const RentalRequestRepository._();

  /// Returns a list of [RentalRequest]s matching the given query parameters.
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
  Future<List<RentalRequest>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RentalRequestTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RentalRequestTable>? orderBy,
    _is.OrderByListBuilder<RentalRequestTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RentalRequest>(
      where: where?.call(RentalRequest.t),
      orderBy: orderBy?.call(RentalRequest.t),
      orderByList: orderByList?.call(RentalRequest.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RentalRequest] matching the given query parameters.
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
  Future<RentalRequest?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RentalRequestTable>? where,
    int? offset,
    _is.OrderByBuilder<RentalRequestTable>? orderBy,
    _is.OrderByListBuilder<RentalRequestTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RentalRequest>(
      where: where?.call(RentalRequest.t),
      orderBy: orderBy?.call(RentalRequest.t),
      orderByList: orderByList?.call(RentalRequest.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RentalRequest] by its [id] or null if no such row exists.
  Future<RentalRequest?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RentalRequest>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RentalRequest]s in the list and returns the inserted rows.
  ///
  /// The returned [RentalRequest]s will have their `id` fields set.
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
  Future<List<RentalRequest>> insert(
    _is.DatabaseSession session,
    List<RentalRequest> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<RentalRequest>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [RentalRequest] and returns the inserted row.
  ///
  /// The returned [RentalRequest] will have its `id` field set.
  Future<RentalRequest> insertRow(
    _is.DatabaseSession session,
    RentalRequest row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<RentalRequest>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [RentalRequest]s in the list and returns the resulting rows.
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
  /// The returned [RentalRequest]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RentalRequest>> upsert(
    _is.DatabaseSession session,
    List<RentalRequest> rows, {
    required _is.ColumnSelections<RentalRequestTable> conflictColumns,
    _is.ColumnSelections<RentalRequestTable>? updateColumns,
    _is.WhereExpressionBuilder<RentalRequestTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<RentalRequest>(
      rows,
      conflictColumns: conflictColumns(RentalRequest.t),
      updateColumns: updateColumns?.call(RentalRequest.t),
      updateWhere: updateWhere?.call(RentalRequest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [RentalRequest] and returns the resulting row.
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
  /// The returned [RentalRequest] will have its `id` field set.
  Future<RentalRequest?> upsertRow(
    _is.DatabaseSession session,
    RentalRequest row, {
    required _is.ColumnSelections<RentalRequestTable> conflictColumns,
    _is.ColumnSelections<RentalRequestTable>? updateColumns,
    _is.WhereExpressionBuilder<RentalRequestTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<RentalRequest>(
      row,
      conflictColumns: conflictColumns(RentalRequest.t),
      updateColumns: updateColumns?.call(RentalRequest.t),
      updateWhere: updateWhere?.call(RentalRequest.t),
      transaction: transaction,
    );
  }

  /// Updates all [RentalRequest]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RentalRequest>> update(
    _is.DatabaseSession session,
    List<RentalRequest> rows, {
    _is.ColumnSelections<RentalRequestTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<RentalRequest>(
      rows,
      columns: columns?.call(RentalRequest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [RentalRequest]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RentalRequest> updateRow(
    _is.DatabaseSession session,
    RentalRequest row, {
    _is.ColumnSelections<RentalRequestTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<RentalRequest>(
      row,
      columns: columns?.call(RentalRequest.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RentalRequest] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RentalRequest?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<RentalRequestUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<RentalRequest>(
      id,
      columnValues: columnValues(RentalRequest.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RentalRequest]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RentalRequest>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RentalRequestUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<RentalRequestTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RentalRequestTable>? orderBy,
    _is.OrderByListBuilder<RentalRequestTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<RentalRequest>(
      columnValues: columnValues(RentalRequest.t.updateTable),
      where: where(RentalRequest.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RentalRequest.t),
      orderByList: orderByList?.call(RentalRequest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [RentalRequest]s in the list and returns the deleted rows.
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
  Future<List<RentalRequest>> delete(
    _is.DatabaseSession session,
    List<RentalRequest> rows, {
    _is.OrderByBuilder<RentalRequestTable>? orderBy,
    _is.OrderByListBuilder<RentalRequestTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<RentalRequest>(
      rows,
      orderBy: orderBy?.call(RentalRequest.t),
      orderByList: orderByList?.call(RentalRequest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [RentalRequest].
  Future<RentalRequest> deleteRow(
    _is.DatabaseSession session,
    RentalRequest row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RentalRequest>(
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
  Future<List<RentalRequest>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RentalRequestTable> where,
    _is.OrderByBuilder<RentalRequestTable>? orderBy,
    _is.OrderByListBuilder<RentalRequestTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<RentalRequest>(
      where: where(RentalRequest.t),
      orderBy: orderBy?.call(RentalRequest.t),
      orderByList: orderByList?.call(RentalRequest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RentalRequestTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<RentalRequest>(
      where: where?.call(RentalRequest.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RentalRequest] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RentalRequestTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RentalRequest>(
      where: where(RentalRequest.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
