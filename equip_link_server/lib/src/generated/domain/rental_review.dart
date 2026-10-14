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

abstract class RentalReview
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  RentalReview._({
    this.id,
    required this.rentalRequestId,
    required this.reviewerId,
    required this.revieweeId,
    required this.listingId,
    required this.rating,
    this.comment,
    required this.createdAt,
  });

  factory RentalReview({
    int? id,
    required int rentalRequestId,
    required _is.UuidValue reviewerId,
    required _is.UuidValue revieweeId,
    required int listingId,
    required int rating,
    String? comment,
    required DateTime createdAt,
  }) = _RentalReviewImpl;

  factory RentalReview.fromJson(Map<String, dynamic> jsonSerialization) {
    return RentalReview(
      id: jsonSerialization['id'] as int?,
      rentalRequestId: jsonSerialization['rentalRequestId'] as int,
      reviewerId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['reviewerId'],
      ),
      revieweeId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['revieweeId'],
      ),
      listingId: jsonSerialization['listingId'] as int,
      rating: jsonSerialization['rating'] as int,
      comment: jsonSerialization['comment'] as String?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = RentalReviewTable();

  static const db = RentalReviewRepository._();

  @override
  int? id;

  int rentalRequestId;

  _is.UuidValue reviewerId;

  _is.UuidValue revieweeId;

  int listingId;

  int rating;

  String? comment;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [RentalReview]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RentalReview copyWith({
    int? id,
    int? rentalRequestId,
    _is.UuidValue? reviewerId,
    _is.UuidValue? revieweeId,
    int? listingId,
    int? rating,
    String? comment,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RentalReview',
      if (id != null) 'id': id,
      'rentalRequestId': rentalRequestId,
      'reviewerId': reviewerId.toJson(),
      'revieweeId': revieweeId.toJson(),
      'listingId': listingId,
      'rating': rating,
      if (comment != null) 'comment': comment,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RentalReview',
      if (id != null) 'id': id,
      'rentalRequestId': rentalRequestId,
      'reviewerId': reviewerId.toJson(),
      'revieweeId': revieweeId.toJson(),
      'listingId': listingId,
      'rating': rating,
      if (comment != null) 'comment': comment,
      'createdAt': createdAt.toJson(),
    };
  }

  static RentalReviewInclude include() {
    return RentalReviewInclude._();
  }

  static RentalReviewIncludeList includeList({
    _is.WhereExpressionBuilder<RentalReviewTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RentalReviewTable>? orderBy,
    _is.OrderByListBuilder<RentalReviewTable>? orderByList,
    RentalReviewInclude? include,
  }) {
    return RentalReviewIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RentalReview.t),
      orderByList: orderByList?.call(RentalReview.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RentalReviewImpl extends RentalReview {
  _RentalReviewImpl({
    int? id,
    required int rentalRequestId,
    required _is.UuidValue reviewerId,
    required _is.UuidValue revieweeId,
    required int listingId,
    required int rating,
    String? comment,
    required DateTime createdAt,
  }) : super._(
         id: id,
         rentalRequestId: rentalRequestId,
         reviewerId: reviewerId,
         revieweeId: revieweeId,
         listingId: listingId,
         rating: rating,
         comment: comment,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [RentalReview]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RentalReview copyWith({
    Object? id = _Undefined,
    int? rentalRequestId,
    _is.UuidValue? reviewerId,
    _is.UuidValue? revieweeId,
    int? listingId,
    int? rating,
    Object? comment = _Undefined,
    DateTime? createdAt,
  }) {
    return RentalReview(
      id: id is int? ? id : this.id,
      rentalRequestId: rentalRequestId ?? this.rentalRequestId,
      reviewerId: reviewerId ?? this.reviewerId,
      revieweeId: revieweeId ?? this.revieweeId,
      listingId: listingId ?? this.listingId,
      rating: rating ?? this.rating,
      comment: comment is String? ? comment : this.comment,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class RentalReviewUpdateTable extends _is.UpdateTable<RentalReviewTable> {
  RentalReviewUpdateTable(super.table);

  _is.ColumnValue<int, int> rentalRequestId(int value) => _is.ColumnValue(
    table.rentalRequestId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> reviewerId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.reviewerId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> revieweeId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.revieweeId,
    value,
  );

  _is.ColumnValue<int, int> listingId(int value) => _is.ColumnValue(
    table.listingId,
    value,
  );

  _is.ColumnValue<int, int> rating(int value) => _is.ColumnValue(
    table.rating,
    value,
  );

  _is.ColumnValue<String, String> comment(String? value) => _is.ColumnValue(
    table.comment,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class RentalReviewTable extends _is.Table<int?> {
  RentalReviewTable({super.tableRelation}) : super(tableName: 'rental_review') {
    updateTable = RentalReviewUpdateTable(this);
    rentalRequestId = _is.ColumnInt(
      'rentalRequestId',
      this,
    );
    reviewerId = _is.ColumnUuid(
      'reviewerId',
      this,
    );
    revieweeId = _is.ColumnUuid(
      'revieweeId',
      this,
    );
    listingId = _is.ColumnInt(
      'listingId',
      this,
    );
    rating = _is.ColumnInt(
      'rating',
      this,
    );
    comment = _is.ColumnString(
      'comment',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final RentalReviewUpdateTable updateTable;

  late final _is.ColumnInt rentalRequestId;

  late final _is.ColumnUuid reviewerId;

  late final _is.ColumnUuid revieweeId;

  late final _is.ColumnInt listingId;

  late final _is.ColumnInt rating;

  late final _is.ColumnString comment;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    rentalRequestId,
    reviewerId,
    revieweeId,
    listingId,
    rating,
    comment,
    createdAt,
  ];
}

class RentalReviewInclude extends _is.IncludeObject {
  RentalReviewInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => RentalReview.t;
}

class RentalReviewIncludeList extends _is.IncludeList {
  RentalReviewIncludeList._({
    _is.WhereExpressionBuilder<RentalReviewTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RentalReview.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => RentalReview.t;
}

class RentalReviewRepository {
  const RentalReviewRepository._();

  /// Returns a list of [RentalReview]s matching the given query parameters.
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
  Future<List<RentalReview>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RentalReviewTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RentalReviewTable>? orderBy,
    _is.OrderByListBuilder<RentalReviewTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RentalReview>(
      where: where?.call(RentalReview.t),
      orderBy: orderBy?.call(RentalReview.t),
      orderByList: orderByList?.call(RentalReview.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RentalReview] matching the given query parameters.
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
  Future<RentalReview?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RentalReviewTable>? where,
    int? offset,
    _is.OrderByBuilder<RentalReviewTable>? orderBy,
    _is.OrderByListBuilder<RentalReviewTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RentalReview>(
      where: where?.call(RentalReview.t),
      orderBy: orderBy?.call(RentalReview.t),
      orderByList: orderByList?.call(RentalReview.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RentalReview] by its [id] or null if no such row exists.
  Future<RentalReview?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RentalReview>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RentalReview]s in the list and returns the inserted rows.
  ///
  /// The returned [RentalReview]s will have their `id` fields set.
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
  Future<List<RentalReview>> insert(
    _is.DatabaseSession session,
    List<RentalReview> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<RentalReview>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [RentalReview] and returns the inserted row.
  ///
  /// The returned [RentalReview] will have its `id` field set.
  Future<RentalReview> insertRow(
    _is.DatabaseSession session,
    RentalReview row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<RentalReview>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [RentalReview]s in the list and returns the resulting rows.
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
  /// The returned [RentalReview]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RentalReview>> upsert(
    _is.DatabaseSession session,
    List<RentalReview> rows, {
    required _is.ColumnSelections<RentalReviewTable> conflictColumns,
    _is.ColumnSelections<RentalReviewTable>? updateColumns,
    _is.WhereExpressionBuilder<RentalReviewTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<RentalReview>(
      rows,
      conflictColumns: conflictColumns(RentalReview.t),
      updateColumns: updateColumns?.call(RentalReview.t),
      updateWhere: updateWhere?.call(RentalReview.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [RentalReview] and returns the resulting row.
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
  /// The returned [RentalReview] will have its `id` field set.
  Future<RentalReview?> upsertRow(
    _is.DatabaseSession session,
    RentalReview row, {
    required _is.ColumnSelections<RentalReviewTable> conflictColumns,
    _is.ColumnSelections<RentalReviewTable>? updateColumns,
    _is.WhereExpressionBuilder<RentalReviewTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<RentalReview>(
      row,
      conflictColumns: conflictColumns(RentalReview.t),
      updateColumns: updateColumns?.call(RentalReview.t),
      updateWhere: updateWhere?.call(RentalReview.t),
      transaction: transaction,
    );
  }

  /// Updates all [RentalReview]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RentalReview>> update(
    _is.DatabaseSession session,
    List<RentalReview> rows, {
    _is.ColumnSelections<RentalReviewTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<RentalReview>(
      rows,
      columns: columns?.call(RentalReview.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [RentalReview]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RentalReview> updateRow(
    _is.DatabaseSession session,
    RentalReview row, {
    _is.ColumnSelections<RentalReviewTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<RentalReview>(
      row,
      columns: columns?.call(RentalReview.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RentalReview] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RentalReview?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<RentalReviewUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<RentalReview>(
      id,
      columnValues: columnValues(RentalReview.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RentalReview]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RentalReview>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RentalReviewUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<RentalReviewTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RentalReviewTable>? orderBy,
    _is.OrderByListBuilder<RentalReviewTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<RentalReview>(
      columnValues: columnValues(RentalReview.t.updateTable),
      where: where(RentalReview.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RentalReview.t),
      orderByList: orderByList?.call(RentalReview.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [RentalReview]s in the list and returns the deleted rows.
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
  Future<List<RentalReview>> delete(
    _is.DatabaseSession session,
    List<RentalReview> rows, {
    _is.OrderByBuilder<RentalReviewTable>? orderBy,
    _is.OrderByListBuilder<RentalReviewTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<RentalReview>(
      rows,
      orderBy: orderBy?.call(RentalReview.t),
      orderByList: orderByList?.call(RentalReview.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [RentalReview].
  Future<RentalReview> deleteRow(
    _is.DatabaseSession session,
    RentalReview row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RentalReview>(
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
  Future<List<RentalReview>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RentalReviewTable> where,
    _is.OrderByBuilder<RentalReviewTable>? orderBy,
    _is.OrderByListBuilder<RentalReviewTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<RentalReview>(
      where: where(RentalReview.t),
      orderBy: orderBy?.call(RentalReview.t),
      orderByList: orderByList?.call(RentalReview.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RentalReviewTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<RentalReview>(
      where: where?.call(RentalReview.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RentalReview] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RentalReviewTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RentalReview>(
      where: where(RentalReview.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
