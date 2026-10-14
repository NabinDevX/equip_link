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

abstract class EmailOtpChallenge
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  EmailOtpChallenge._({
    this.id,
    required this.challengeId,
    required this.email,
    required this.codeHash,
    required this.salt,
    required this.issuedAt,
    required this.expiresAt,
    required this.attempts,
    required this.maxAttempts,
    required this.consumed,
    this.requestIp,
    this.userAgent,
    this.preAuthNonce,
  });

  factory EmailOtpChallenge({
    int? id,
    required String challengeId,
    required String email,
    required String codeHash,
    required String salt,
    required DateTime issuedAt,
    required DateTime expiresAt,
    required int attempts,
    required int maxAttempts,
    required bool consumed,
    String? requestIp,
    String? userAgent,
    String? preAuthNonce,
  }) = _EmailOtpChallengeImpl;

  factory EmailOtpChallenge.fromJson(Map<String, dynamic> jsonSerialization) {
    return EmailOtpChallenge(
      id: jsonSerialization['id'] as int?,
      challengeId: jsonSerialization['challengeId'] as String,
      email: jsonSerialization['email'] as String,
      codeHash: jsonSerialization['codeHash'] as String,
      salt: jsonSerialization['salt'] as String,
      issuedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['issuedAt'],
      ),
      expiresAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      attempts: jsonSerialization['attempts'] as int,
      maxAttempts: jsonSerialization['maxAttempts'] as int,
      consumed: _is.BoolJsonExtension.fromJson(jsonSerialization['consumed']),
      requestIp: jsonSerialization['requestIp'] as String?,
      userAgent: jsonSerialization['userAgent'] as String?,
      preAuthNonce: jsonSerialization['preAuthNonce'] as String?,
    );
  }

  static final t = EmailOtpChallengeTable();

  static const db = EmailOtpChallengeRepository._();

  @override
  int? id;

  String challengeId;

  String email;

  String codeHash;

  String salt;

  DateTime issuedAt;

  DateTime expiresAt;

  int attempts;

  int maxAttempts;

  bool consumed;

  String? requestIp;

  String? userAgent;

  String? preAuthNonce;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [EmailOtpChallenge]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  EmailOtpChallenge copyWith({
    int? id,
    String? challengeId,
    String? email,
    String? codeHash,
    String? salt,
    DateTime? issuedAt,
    DateTime? expiresAt,
    int? attempts,
    int? maxAttempts,
    bool? consumed,
    String? requestIp,
    String? userAgent,
    String? preAuthNonce,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EmailOtpChallenge',
      if (id != null) 'id': id,
      'challengeId': challengeId,
      'email': email,
      'codeHash': codeHash,
      'salt': salt,
      'issuedAt': issuedAt.toJson(),
      'expiresAt': expiresAt.toJson(),
      'attempts': attempts,
      'maxAttempts': maxAttempts,
      'consumed': consumed,
      if (requestIp != null) 'requestIp': requestIp,
      if (userAgent != null) 'userAgent': userAgent,
      if (preAuthNonce != null) 'preAuthNonce': preAuthNonce,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EmailOtpChallenge',
      if (id != null) 'id': id,
      'challengeId': challengeId,
      'email': email,
      'codeHash': codeHash,
      'salt': salt,
      'issuedAt': issuedAt.toJson(),
      'expiresAt': expiresAt.toJson(),
      'attempts': attempts,
      'maxAttempts': maxAttempts,
      'consumed': consumed,
      if (requestIp != null) 'requestIp': requestIp,
      if (userAgent != null) 'userAgent': userAgent,
      if (preAuthNonce != null) 'preAuthNonce': preAuthNonce,
    };
  }

  static EmailOtpChallengeInclude include() {
    return EmailOtpChallengeInclude._();
  }

  static EmailOtpChallengeIncludeList includeList({
    _is.WhereExpressionBuilder<EmailOtpChallengeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EmailOtpChallengeTable>? orderBy,
    _is.OrderByListBuilder<EmailOtpChallengeTable>? orderByList,
    EmailOtpChallengeInclude? include,
  }) {
    return EmailOtpChallengeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EmailOtpChallenge.t),
      orderByList: orderByList?.call(EmailOtpChallenge.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EmailOtpChallengeImpl extends EmailOtpChallenge {
  _EmailOtpChallengeImpl({
    int? id,
    required String challengeId,
    required String email,
    required String codeHash,
    required String salt,
    required DateTime issuedAt,
    required DateTime expiresAt,
    required int attempts,
    required int maxAttempts,
    required bool consumed,
    String? requestIp,
    String? userAgent,
    String? preAuthNonce,
  }) : super._(
         id: id,
         challengeId: challengeId,
         email: email,
         codeHash: codeHash,
         salt: salt,
         issuedAt: issuedAt,
         expiresAt: expiresAt,
         attempts: attempts,
         maxAttempts: maxAttempts,
         consumed: consumed,
         requestIp: requestIp,
         userAgent: userAgent,
         preAuthNonce: preAuthNonce,
       );

  /// Returns a shallow copy of this [EmailOtpChallenge]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  EmailOtpChallenge copyWith({
    Object? id = _Undefined,
    String? challengeId,
    String? email,
    String? codeHash,
    String? salt,
    DateTime? issuedAt,
    DateTime? expiresAt,
    int? attempts,
    int? maxAttempts,
    bool? consumed,
    Object? requestIp = _Undefined,
    Object? userAgent = _Undefined,
    Object? preAuthNonce = _Undefined,
  }) {
    return EmailOtpChallenge(
      id: id is int? ? id : this.id,
      challengeId: challengeId ?? this.challengeId,
      email: email ?? this.email,
      codeHash: codeHash ?? this.codeHash,
      salt: salt ?? this.salt,
      issuedAt: issuedAt ?? this.issuedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      attempts: attempts ?? this.attempts,
      maxAttempts: maxAttempts ?? this.maxAttempts,
      consumed: consumed ?? this.consumed,
      requestIp: requestIp is String? ? requestIp : this.requestIp,
      userAgent: userAgent is String? ? userAgent : this.userAgent,
      preAuthNonce: preAuthNonce is String? ? preAuthNonce : this.preAuthNonce,
    );
  }
}

class EmailOtpChallengeUpdateTable
    extends _is.UpdateTable<EmailOtpChallengeTable> {
  EmailOtpChallengeUpdateTable(super.table);

  _is.ColumnValue<String, String> challengeId(String value) => _is.ColumnValue(
    table.challengeId,
    value,
  );

  _is.ColumnValue<String, String> email(String value) => _is.ColumnValue(
    table.email,
    value,
  );

  _is.ColumnValue<String, String> codeHash(String value) => _is.ColumnValue(
    table.codeHash,
    value,
  );

  _is.ColumnValue<String, String> salt(String value) => _is.ColumnValue(
    table.salt,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> issuedAt(DateTime value) =>
      _is.ColumnValue(
        table.issuedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> expiresAt(DateTime value) =>
      _is.ColumnValue(
        table.expiresAt,
        value,
      );

  _is.ColumnValue<int, int> attempts(int value) => _is.ColumnValue(
    table.attempts,
    value,
  );

  _is.ColumnValue<int, int> maxAttempts(int value) => _is.ColumnValue(
    table.maxAttempts,
    value,
  );

  _is.ColumnValue<bool, bool> consumed(bool value) => _is.ColumnValue(
    table.consumed,
    value,
  );

  _is.ColumnValue<String, String> requestIp(String? value) => _is.ColumnValue(
    table.requestIp,
    value,
  );

  _is.ColumnValue<String, String> userAgent(String? value) => _is.ColumnValue(
    table.userAgent,
    value,
  );

  _is.ColumnValue<String, String> preAuthNonce(String? value) =>
      _is.ColumnValue(
        table.preAuthNonce,
        value,
      );
}

class EmailOtpChallengeTable extends _is.Table<int?> {
  EmailOtpChallengeTable({super.tableRelation})
    : super(tableName: 'email_otp_challenge') {
    updateTable = EmailOtpChallengeUpdateTable(this);
    challengeId = _is.ColumnString(
      'challengeId',
      this,
    );
    email = _is.ColumnString(
      'email',
      this,
    );
    codeHash = _is.ColumnString(
      'codeHash',
      this,
    );
    salt = _is.ColumnString(
      'salt',
      this,
    );
    issuedAt = _is.ColumnDateTime(
      'issuedAt',
      this,
    );
    expiresAt = _is.ColumnDateTime(
      'expiresAt',
      this,
    );
    attempts = _is.ColumnInt(
      'attempts',
      this,
    );
    maxAttempts = _is.ColumnInt(
      'maxAttempts',
      this,
    );
    consumed = _is.ColumnBool(
      'consumed',
      this,
    );
    requestIp = _is.ColumnString(
      'requestIp',
      this,
    );
    userAgent = _is.ColumnString(
      'userAgent',
      this,
    );
    preAuthNonce = _is.ColumnString(
      'preAuthNonce',
      this,
    );
  }

  late final EmailOtpChallengeUpdateTable updateTable;

  late final _is.ColumnString challengeId;

  late final _is.ColumnString email;

  late final _is.ColumnString codeHash;

  late final _is.ColumnString salt;

  late final _is.ColumnDateTime issuedAt;

  late final _is.ColumnDateTime expiresAt;

  late final _is.ColumnInt attempts;

  late final _is.ColumnInt maxAttempts;

  late final _is.ColumnBool consumed;

  late final _is.ColumnString requestIp;

  late final _is.ColumnString userAgent;

  late final _is.ColumnString preAuthNonce;

  @override
  List<_is.Column> get columns => [
    id,
    challengeId,
    email,
    codeHash,
    salt,
    issuedAt,
    expiresAt,
    attempts,
    maxAttempts,
    consumed,
    requestIp,
    userAgent,
    preAuthNonce,
  ];
}

class EmailOtpChallengeInclude extends _is.IncludeObject {
  EmailOtpChallengeInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => EmailOtpChallenge.t;
}

class EmailOtpChallengeIncludeList extends _is.IncludeList {
  EmailOtpChallengeIncludeList._({
    _is.WhereExpressionBuilder<EmailOtpChallengeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(EmailOtpChallenge.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => EmailOtpChallenge.t;
}

class EmailOtpChallengeRepository {
  const EmailOtpChallengeRepository._();

  /// Returns a list of [EmailOtpChallenge]s matching the given query parameters.
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
  Future<List<EmailOtpChallenge>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EmailOtpChallengeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EmailOtpChallengeTable>? orderBy,
    _is.OrderByListBuilder<EmailOtpChallengeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<EmailOtpChallenge>(
      where: where?.call(EmailOtpChallenge.t),
      orderBy: orderBy?.call(EmailOtpChallenge.t),
      orderByList: orderByList?.call(EmailOtpChallenge.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [EmailOtpChallenge] matching the given query parameters.
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
  Future<EmailOtpChallenge?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EmailOtpChallengeTable>? where,
    int? offset,
    _is.OrderByBuilder<EmailOtpChallengeTable>? orderBy,
    _is.OrderByListBuilder<EmailOtpChallengeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<EmailOtpChallenge>(
      where: where?.call(EmailOtpChallenge.t),
      orderBy: orderBy?.call(EmailOtpChallenge.t),
      orderByList: orderByList?.call(EmailOtpChallenge.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [EmailOtpChallenge] by its [id] or null if no such row exists.
  Future<EmailOtpChallenge?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<EmailOtpChallenge>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [EmailOtpChallenge]s in the list and returns the inserted rows.
  ///
  /// The returned [EmailOtpChallenge]s will have their `id` fields set.
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
  Future<List<EmailOtpChallenge>> insert(
    _is.DatabaseSession session,
    List<EmailOtpChallenge> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<EmailOtpChallenge>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [EmailOtpChallenge] and returns the inserted row.
  ///
  /// The returned [EmailOtpChallenge] will have its `id` field set.
  Future<EmailOtpChallenge> insertRow(
    _is.DatabaseSession session,
    EmailOtpChallenge row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<EmailOtpChallenge>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [EmailOtpChallenge]s in the list and returns the resulting rows.
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
  /// The returned [EmailOtpChallenge]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EmailOtpChallenge>> upsert(
    _is.DatabaseSession session,
    List<EmailOtpChallenge> rows, {
    required _is.ColumnSelections<EmailOtpChallengeTable> conflictColumns,
    _is.ColumnSelections<EmailOtpChallengeTable>? updateColumns,
    _is.WhereExpressionBuilder<EmailOtpChallengeTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<EmailOtpChallenge>(
      rows,
      conflictColumns: conflictColumns(EmailOtpChallenge.t),
      updateColumns: updateColumns?.call(EmailOtpChallenge.t),
      updateWhere: updateWhere?.call(EmailOtpChallenge.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [EmailOtpChallenge] and returns the resulting row.
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
  /// The returned [EmailOtpChallenge] will have its `id` field set.
  Future<EmailOtpChallenge?> upsertRow(
    _is.DatabaseSession session,
    EmailOtpChallenge row, {
    required _is.ColumnSelections<EmailOtpChallengeTable> conflictColumns,
    _is.ColumnSelections<EmailOtpChallengeTable>? updateColumns,
    _is.WhereExpressionBuilder<EmailOtpChallengeTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<EmailOtpChallenge>(
      row,
      conflictColumns: conflictColumns(EmailOtpChallenge.t),
      updateColumns: updateColumns?.call(EmailOtpChallenge.t),
      updateWhere: updateWhere?.call(EmailOtpChallenge.t),
      transaction: transaction,
    );
  }

  /// Updates all [EmailOtpChallenge]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EmailOtpChallenge>> update(
    _is.DatabaseSession session,
    List<EmailOtpChallenge> rows, {
    _is.ColumnSelections<EmailOtpChallengeTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<EmailOtpChallenge>(
      rows,
      columns: columns?.call(EmailOtpChallenge.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [EmailOtpChallenge]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<EmailOtpChallenge> updateRow(
    _is.DatabaseSession session,
    EmailOtpChallenge row, {
    _is.ColumnSelections<EmailOtpChallengeTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<EmailOtpChallenge>(
      row,
      columns: columns?.call(EmailOtpChallenge.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EmailOtpChallenge] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<EmailOtpChallenge?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<EmailOtpChallengeUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<EmailOtpChallenge>(
      id,
      columnValues: columnValues(EmailOtpChallenge.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [EmailOtpChallenge]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EmailOtpChallenge>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<EmailOtpChallengeUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<EmailOtpChallengeTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EmailOtpChallengeTable>? orderBy,
    _is.OrderByListBuilder<EmailOtpChallengeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<EmailOtpChallenge>(
      columnValues: columnValues(EmailOtpChallenge.t.updateTable),
      where: where(EmailOtpChallenge.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EmailOtpChallenge.t),
      orderByList: orderByList?.call(EmailOtpChallenge.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [EmailOtpChallenge]s in the list and returns the deleted rows.
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
  Future<List<EmailOtpChallenge>> delete(
    _is.DatabaseSession session,
    List<EmailOtpChallenge> rows, {
    _is.OrderByBuilder<EmailOtpChallengeTable>? orderBy,
    _is.OrderByListBuilder<EmailOtpChallengeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<EmailOtpChallenge>(
      rows,
      orderBy: orderBy?.call(EmailOtpChallenge.t),
      orderByList: orderByList?.call(EmailOtpChallenge.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [EmailOtpChallenge].
  Future<EmailOtpChallenge> deleteRow(
    _is.DatabaseSession session,
    EmailOtpChallenge row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<EmailOtpChallenge>(
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
  Future<List<EmailOtpChallenge>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EmailOtpChallengeTable> where,
    _is.OrderByBuilder<EmailOtpChallengeTable>? orderBy,
    _is.OrderByListBuilder<EmailOtpChallengeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<EmailOtpChallenge>(
      where: where(EmailOtpChallenge.t),
      orderBy: orderBy?.call(EmailOtpChallenge.t),
      orderByList: orderByList?.call(EmailOtpChallenge.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EmailOtpChallengeTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<EmailOtpChallenge>(
      where: where?.call(EmailOtpChallenge.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [EmailOtpChallenge] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EmailOtpChallengeTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<EmailOtpChallenge>(
      where: where(EmailOtpChallenge.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
