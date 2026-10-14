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

abstract class StudentIdentity
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  StudentIdentity._({
    this.id,
    required this.authUserId,
    this.googleProviderIdentity,
    this.studentEmail,
    this.university,
    this.studentIdCardPath,
    this.studentIdExpiresAt,
    bool? studentIdCardVerified,
    required this.emailVerified,
    this.verifiedAt,
    this.lastRevalidatedAt,
    this.revalidationDueAt,
    required this.eligibilityStatus,
    required this.createdAt,
    required this.updatedAt,
  }) : studentIdCardVerified = studentIdCardVerified ?? false;

  factory StudentIdentity({
    int? id,
    required _is.UuidValue authUserId,
    String? googleProviderIdentity,
    String? studentEmail,
    String? university,
    String? studentIdCardPath,
    DateTime? studentIdExpiresAt,
    bool? studentIdCardVerified,
    required bool emailVerified,
    DateTime? verifiedAt,
    DateTime? lastRevalidatedAt,
    DateTime? revalidationDueAt,
    required String eligibilityStatus,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _StudentIdentityImpl;

  factory StudentIdentity.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudentIdentity(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      googleProviderIdentity:
          jsonSerialization['googleProviderIdentity'] as String?,
      studentEmail: jsonSerialization['studentEmail'] as String?,
      university: jsonSerialization['university'] as String?,
      studentIdCardPath: jsonSerialization['studentIdCardPath'] as String?,
      studentIdExpiresAt: jsonSerialization['studentIdExpiresAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['studentIdExpiresAt'],
            ),
      studentIdCardVerified: jsonSerialization['studentIdCardVerified'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['studentIdCardVerified'],
            ),
      emailVerified: _is.BoolJsonExtension.fromJson(
        jsonSerialization['emailVerified'],
      ),
      verifiedAt: jsonSerialization['verifiedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['verifiedAt']),
      lastRevalidatedAt: jsonSerialization['lastRevalidatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastRevalidatedAt'],
            ),
      revalidationDueAt: jsonSerialization['revalidationDueAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['revalidationDueAt'],
            ),
      eligibilityStatus: jsonSerialization['eligibilityStatus'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = StudentIdentityTable();

  static const db = StudentIdentityRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  String? googleProviderIdentity;

  String? studentEmail;

  String? university;

  String? studentIdCardPath;

  DateTime? studentIdExpiresAt;

  bool studentIdCardVerified;

  bool emailVerified;

  DateTime? verifiedAt;

  DateTime? lastRevalidatedAt;

  DateTime? revalidationDueAt;

  String eligibilityStatus;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [StudentIdentity]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  StudentIdentity copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? googleProviderIdentity,
    String? studentEmail,
    String? university,
    String? studentIdCardPath,
    DateTime? studentIdExpiresAt,
    bool? studentIdCardVerified,
    bool? emailVerified,
    DateTime? verifiedAt,
    DateTime? lastRevalidatedAt,
    DateTime? revalidationDueAt,
    String? eligibilityStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudentIdentity',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (googleProviderIdentity != null)
        'googleProviderIdentity': googleProviderIdentity,
      if (studentEmail != null) 'studentEmail': studentEmail,
      if (university != null) 'university': university,
      if (studentIdCardPath != null) 'studentIdCardPath': studentIdCardPath,
      if (studentIdExpiresAt != null)
        'studentIdExpiresAt': studentIdExpiresAt?.toJson(),
      'studentIdCardVerified': studentIdCardVerified,
      'emailVerified': emailVerified,
      if (verifiedAt != null) 'verifiedAt': verifiedAt?.toJson(),
      if (lastRevalidatedAt != null)
        'lastRevalidatedAt': lastRevalidatedAt?.toJson(),
      if (revalidationDueAt != null)
        'revalidationDueAt': revalidationDueAt?.toJson(),
      'eligibilityStatus': eligibilityStatus,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StudentIdentity',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (googleProviderIdentity != null)
        'googleProviderIdentity': googleProviderIdentity,
      if (studentEmail != null) 'studentEmail': studentEmail,
      if (university != null) 'university': university,
      if (studentIdExpiresAt != null)
        'studentIdExpiresAt': studentIdExpiresAt?.toJson(),
      'studentIdCardVerified': studentIdCardVerified,
      'emailVerified': emailVerified,
      if (verifiedAt != null) 'verifiedAt': verifiedAt?.toJson(),
      if (lastRevalidatedAt != null)
        'lastRevalidatedAt': lastRevalidatedAt?.toJson(),
      if (revalidationDueAt != null)
        'revalidationDueAt': revalidationDueAt?.toJson(),
      'eligibilityStatus': eligibilityStatus,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static StudentIdentityInclude include() {
    return StudentIdentityInclude._();
  }

  static StudentIdentityIncludeList includeList({
    _is.WhereExpressionBuilder<StudentIdentityTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StudentIdentityTable>? orderBy,
    _is.OrderByListBuilder<StudentIdentityTable>? orderByList,
    StudentIdentityInclude? include,
  }) {
    return StudentIdentityIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StudentIdentity.t),
      orderByList: orderByList?.call(StudentIdentity.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StudentIdentityImpl extends StudentIdentity {
  _StudentIdentityImpl({
    int? id,
    required _is.UuidValue authUserId,
    String? googleProviderIdentity,
    String? studentEmail,
    String? university,
    String? studentIdCardPath,
    DateTime? studentIdExpiresAt,
    bool? studentIdCardVerified,
    required bool emailVerified,
    DateTime? verifiedAt,
    DateTime? lastRevalidatedAt,
    DateTime? revalidationDueAt,
    required String eligibilityStatus,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         googleProviderIdentity: googleProviderIdentity,
         studentEmail: studentEmail,
         university: university,
         studentIdCardPath: studentIdCardPath,
         studentIdExpiresAt: studentIdExpiresAt,
         studentIdCardVerified: studentIdCardVerified,
         emailVerified: emailVerified,
         verifiedAt: verifiedAt,
         lastRevalidatedAt: lastRevalidatedAt,
         revalidationDueAt: revalidationDueAt,
         eligibilityStatus: eligibilityStatus,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [StudentIdentity]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  StudentIdentity copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    Object? googleProviderIdentity = _Undefined,
    Object? studentEmail = _Undefined,
    Object? university = _Undefined,
    Object? studentIdCardPath = _Undefined,
    Object? studentIdExpiresAt = _Undefined,
    bool? studentIdCardVerified,
    bool? emailVerified,
    Object? verifiedAt = _Undefined,
    Object? lastRevalidatedAt = _Undefined,
    Object? revalidationDueAt = _Undefined,
    String? eligibilityStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StudentIdentity(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      googleProviderIdentity: googleProviderIdentity is String?
          ? googleProviderIdentity
          : this.googleProviderIdentity,
      studentEmail: studentEmail is String? ? studentEmail : this.studentEmail,
      university: university is String? ? university : this.university,
      studentIdCardPath: studentIdCardPath is String?
          ? studentIdCardPath
          : this.studentIdCardPath,
      studentIdExpiresAt: studentIdExpiresAt is DateTime?
          ? studentIdExpiresAt
          : this.studentIdExpiresAt,
      studentIdCardVerified:
          studentIdCardVerified ?? this.studentIdCardVerified,
      emailVerified: emailVerified ?? this.emailVerified,
      verifiedAt: verifiedAt is DateTime? ? verifiedAt : this.verifiedAt,
      lastRevalidatedAt: lastRevalidatedAt is DateTime?
          ? lastRevalidatedAt
          : this.lastRevalidatedAt,
      revalidationDueAt: revalidationDueAt is DateTime?
          ? revalidationDueAt
          : this.revalidationDueAt,
      eligibilityStatus: eligibilityStatus ?? this.eligibilityStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class StudentIdentityUpdateTable extends _is.UpdateTable<StudentIdentityTable> {
  StudentIdentityUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> googleProviderIdentity(String? value) =>
      _is.ColumnValue(
        table.googleProviderIdentity,
        value,
      );

  _is.ColumnValue<String, String> studentEmail(String? value) =>
      _is.ColumnValue(
        table.studentEmail,
        value,
      );

  _is.ColumnValue<String, String> university(String? value) => _is.ColumnValue(
    table.university,
    value,
  );

  _is.ColumnValue<String, String> studentIdCardPath(String? value) =>
      _is.ColumnValue(
        table.studentIdCardPath,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> studentIdExpiresAt(DateTime? value) =>
      _is.ColumnValue(
        table.studentIdExpiresAt,
        value,
      );

  _is.ColumnValue<bool, bool> studentIdCardVerified(bool value) =>
      _is.ColumnValue(
        table.studentIdCardVerified,
        value,
      );

  _is.ColumnValue<bool, bool> emailVerified(bool value) => _is.ColumnValue(
    table.emailVerified,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> verifiedAt(DateTime? value) =>
      _is.ColumnValue(
        table.verifiedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> lastRevalidatedAt(DateTime? value) =>
      _is.ColumnValue(
        table.lastRevalidatedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> revalidationDueAt(DateTime? value) =>
      _is.ColumnValue(
        table.revalidationDueAt,
        value,
      );

  _is.ColumnValue<String, String> eligibilityStatus(String value) =>
      _is.ColumnValue(
        table.eligibilityStatus,
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

class StudentIdentityTable extends _is.Table<int?> {
  StudentIdentityTable({super.tableRelation})
    : super(tableName: 'student_identity') {
    updateTable = StudentIdentityUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    googleProviderIdentity = _is.ColumnString(
      'googleProviderIdentity',
      this,
    );
    studentEmail = _is.ColumnString(
      'studentEmail',
      this,
    );
    university = _is.ColumnString(
      'university',
      this,
    );
    studentIdCardPath = _is.ColumnString(
      'studentIdCardPath',
      this,
    );
    studentIdExpiresAt = _is.ColumnDateTime(
      'studentIdExpiresAt',
      this,
    );
    studentIdCardVerified = _is.ColumnBool(
      'studentIdCardVerified',
      this,
      hasDefault: true,
    );
    emailVerified = _is.ColumnBool(
      'emailVerified',
      this,
    );
    verifiedAt = _is.ColumnDateTime(
      'verifiedAt',
      this,
    );
    lastRevalidatedAt = _is.ColumnDateTime(
      'lastRevalidatedAt',
      this,
    );
    revalidationDueAt = _is.ColumnDateTime(
      'revalidationDueAt',
      this,
    );
    eligibilityStatus = _is.ColumnString(
      'eligibilityStatus',
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

  late final StudentIdentityUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString googleProviderIdentity;

  late final _is.ColumnString studentEmail;

  late final _is.ColumnString university;

  late final _is.ColumnString studentIdCardPath;

  late final _is.ColumnDateTime studentIdExpiresAt;

  late final _is.ColumnBool studentIdCardVerified;

  late final _is.ColumnBool emailVerified;

  late final _is.ColumnDateTime verifiedAt;

  late final _is.ColumnDateTime lastRevalidatedAt;

  late final _is.ColumnDateTime revalidationDueAt;

  late final _is.ColumnString eligibilityStatus;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    googleProviderIdentity,
    studentEmail,
    university,
    studentIdCardPath,
    studentIdExpiresAt,
    studentIdCardVerified,
    emailVerified,
    verifiedAt,
    lastRevalidatedAt,
    revalidationDueAt,
    eligibilityStatus,
    createdAt,
    updatedAt,
  ];
}

class StudentIdentityInclude extends _is.IncludeObject {
  StudentIdentityInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => StudentIdentity.t;
}

class StudentIdentityIncludeList extends _is.IncludeList {
  StudentIdentityIncludeList._({
    _is.WhereExpressionBuilder<StudentIdentityTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StudentIdentity.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => StudentIdentity.t;
}

class StudentIdentityRepository {
  const StudentIdentityRepository._();

  /// Returns a list of [StudentIdentity]s matching the given query parameters.
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
  Future<List<StudentIdentity>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StudentIdentityTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StudentIdentityTable>? orderBy,
    _is.OrderByListBuilder<StudentIdentityTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<StudentIdentity>(
      where: where?.call(StudentIdentity.t),
      orderBy: orderBy?.call(StudentIdentity.t),
      orderByList: orderByList?.call(StudentIdentity.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [StudentIdentity] matching the given query parameters.
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
  Future<StudentIdentity?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StudentIdentityTable>? where,
    int? offset,
    _is.OrderByBuilder<StudentIdentityTable>? orderBy,
    _is.OrderByListBuilder<StudentIdentityTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<StudentIdentity>(
      where: where?.call(StudentIdentity.t),
      orderBy: orderBy?.call(StudentIdentity.t),
      orderByList: orderByList?.call(StudentIdentity.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [StudentIdentity] by its [id] or null if no such row exists.
  Future<StudentIdentity?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<StudentIdentity>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [StudentIdentity]s in the list and returns the inserted rows.
  ///
  /// The returned [StudentIdentity]s will have their `id` fields set.
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
  Future<List<StudentIdentity>> insert(
    _is.DatabaseSession session,
    List<StudentIdentity> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<StudentIdentity>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [StudentIdentity] and returns the inserted row.
  ///
  /// The returned [StudentIdentity] will have its `id` field set.
  Future<StudentIdentity> insertRow(
    _is.DatabaseSession session,
    StudentIdentity row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<StudentIdentity>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [StudentIdentity]s in the list and returns the resulting rows.
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
  /// The returned [StudentIdentity]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StudentIdentity>> upsert(
    _is.DatabaseSession session,
    List<StudentIdentity> rows, {
    required _is.ColumnSelections<StudentIdentityTable> conflictColumns,
    _is.ColumnSelections<StudentIdentityTable>? updateColumns,
    _is.WhereExpressionBuilder<StudentIdentityTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<StudentIdentity>(
      rows,
      conflictColumns: conflictColumns(StudentIdentity.t),
      updateColumns: updateColumns?.call(StudentIdentity.t),
      updateWhere: updateWhere?.call(StudentIdentity.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [StudentIdentity] and returns the resulting row.
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
  /// The returned [StudentIdentity] will have its `id` field set.
  Future<StudentIdentity?> upsertRow(
    _is.DatabaseSession session,
    StudentIdentity row, {
    required _is.ColumnSelections<StudentIdentityTable> conflictColumns,
    _is.ColumnSelections<StudentIdentityTable>? updateColumns,
    _is.WhereExpressionBuilder<StudentIdentityTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<StudentIdentity>(
      row,
      conflictColumns: conflictColumns(StudentIdentity.t),
      updateColumns: updateColumns?.call(StudentIdentity.t),
      updateWhere: updateWhere?.call(StudentIdentity.t),
      transaction: transaction,
    );
  }

  /// Updates all [StudentIdentity]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StudentIdentity>> update(
    _is.DatabaseSession session,
    List<StudentIdentity> rows, {
    _is.ColumnSelections<StudentIdentityTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<StudentIdentity>(
      rows,
      columns: columns?.call(StudentIdentity.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [StudentIdentity]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StudentIdentity> updateRow(
    _is.DatabaseSession session,
    StudentIdentity row, {
    _is.ColumnSelections<StudentIdentityTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<StudentIdentity>(
      row,
      columns: columns?.call(StudentIdentity.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StudentIdentity] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StudentIdentity?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<StudentIdentityUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<StudentIdentity>(
      id,
      columnValues: columnValues(StudentIdentity.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StudentIdentity]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StudentIdentity>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<StudentIdentityUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<StudentIdentityTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StudentIdentityTable>? orderBy,
    _is.OrderByListBuilder<StudentIdentityTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<StudentIdentity>(
      columnValues: columnValues(StudentIdentity.t.updateTable),
      where: where(StudentIdentity.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StudentIdentity.t),
      orderByList: orderByList?.call(StudentIdentity.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [StudentIdentity]s in the list and returns the deleted rows.
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
  Future<List<StudentIdentity>> delete(
    _is.DatabaseSession session,
    List<StudentIdentity> rows, {
    _is.OrderByBuilder<StudentIdentityTable>? orderBy,
    _is.OrderByListBuilder<StudentIdentityTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<StudentIdentity>(
      rows,
      orderBy: orderBy?.call(StudentIdentity.t),
      orderByList: orderByList?.call(StudentIdentity.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [StudentIdentity].
  Future<StudentIdentity> deleteRow(
    _is.DatabaseSession session,
    StudentIdentity row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StudentIdentity>(
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
  Future<List<StudentIdentity>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StudentIdentityTable> where,
    _is.OrderByBuilder<StudentIdentityTable>? orderBy,
    _is.OrderByListBuilder<StudentIdentityTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<StudentIdentity>(
      where: where(StudentIdentity.t),
      orderBy: orderBy?.call(StudentIdentity.t),
      orderByList: orderByList?.call(StudentIdentity.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StudentIdentityTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<StudentIdentity>(
      where: where?.call(StudentIdentity.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [StudentIdentity] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StudentIdentityTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<StudentIdentity>(
      where: where(StudentIdentity.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
