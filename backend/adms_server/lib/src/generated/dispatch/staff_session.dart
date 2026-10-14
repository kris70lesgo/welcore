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

abstract class StaffSession
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  StaffSession._({
    this.id,
    required this.accountId,
    required this.tokenHash,
    required this.expiresAt,
  });

  factory StaffSession({
    int? id,
    required int accountId,
    required String tokenHash,
    required DateTime expiresAt,
  }) = _StaffSessionImpl;

  factory StaffSession.fromJson(Map<String, dynamic> jsonSerialization) {
    return StaffSession(
      id: jsonSerialization['id'] as int?,
      accountId: jsonSerialization['accountId'] as int,
      tokenHash: jsonSerialization['tokenHash'] as String,
      expiresAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
    );
  }

  static final t = StaffSessionTable();

  static const db = StaffSessionRepository._();

  @override
  int? id;

  int accountId;

  String tokenHash;

  DateTime expiresAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [StaffSession]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  StaffSession copyWith({
    int? id,
    int? accountId,
    String? tokenHash,
    DateTime? expiresAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StaffSession',
      if (id != null) 'id': id,
      'accountId': accountId,
      'tokenHash': tokenHash,
      'expiresAt': expiresAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static StaffSessionInclude include() {
    return StaffSessionInclude._();
  }

  static StaffSessionIncludeList includeList({
    _is.WhereExpressionBuilder<StaffSessionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StaffSessionTable>? orderBy,
    _is.OrderByListBuilder<StaffSessionTable>? orderByList,
    StaffSessionInclude? include,
  }) {
    return StaffSessionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StaffSession.t),
      orderByList: orderByList?.call(StaffSession.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StaffSessionImpl extends StaffSession {
  _StaffSessionImpl({
    int? id,
    required int accountId,
    required String tokenHash,
    required DateTime expiresAt,
  }) : super._(
         id: id,
         accountId: accountId,
         tokenHash: tokenHash,
         expiresAt: expiresAt,
       );

  /// Returns a shallow copy of this [StaffSession]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  StaffSession copyWith({
    Object? id = _Undefined,
    int? accountId,
    String? tokenHash,
    DateTime? expiresAt,
  }) {
    return StaffSession(
      id: id is int? ? id : this.id,
      accountId: accountId ?? this.accountId,
      tokenHash: tokenHash ?? this.tokenHash,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }
}

class StaffSessionUpdateTable extends _is.UpdateTable<StaffSessionTable> {
  StaffSessionUpdateTable(super.table);

  _is.ColumnValue<int, int> accountId(int value) =>
      _is.ColumnValue(table.accountId, value);

  _is.ColumnValue<String, String> tokenHash(String value) =>
      _is.ColumnValue(table.tokenHash, value);

  _is.ColumnValue<DateTime, DateTime> expiresAt(DateTime value) =>
      _is.ColumnValue(table.expiresAt, value);
}

class StaffSessionTable extends _is.Table<int?> {
  StaffSessionTable({super.tableRelation}) : super(tableName: 'staff_session') {
    updateTable = StaffSessionUpdateTable(this);
    accountId = _is.ColumnInt('accountId', this);
    tokenHash = _is.ColumnString('tokenHash', this);
    expiresAt = _is.ColumnDateTime('expiresAt', this);
  }

  late final StaffSessionUpdateTable updateTable;

  late final _is.ColumnInt accountId;

  late final _is.ColumnString tokenHash;

  late final _is.ColumnDateTime expiresAt;

  @override
  List<_is.Column> get columns => [id, accountId, tokenHash, expiresAt];
}

class StaffSessionInclude extends _is.IncludeObject {
  StaffSessionInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => StaffSession.t;
}

class StaffSessionIncludeList extends _is.IncludeList {
  StaffSessionIncludeList._({
    _is.WhereExpressionBuilder<StaffSessionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StaffSession.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => StaffSession.t;
}

class StaffSessionRepository {
  const StaffSessionRepository._();

  /// Returns a list of [StaffSession]s matching the given query parameters.
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
  Future<List<StaffSession>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StaffSessionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StaffSessionTable>? orderBy,
    _is.OrderByListBuilder<StaffSessionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<StaffSession>(
      where: where?.call(StaffSession.t),
      orderBy: orderBy?.call(StaffSession.t),
      orderByList: orderByList?.call(StaffSession.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [StaffSession] matching the given query parameters.
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
  Future<StaffSession?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StaffSessionTable>? where,
    int? offset,
    _is.OrderByBuilder<StaffSessionTable>? orderBy,
    _is.OrderByListBuilder<StaffSessionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<StaffSession>(
      where: where?.call(StaffSession.t),
      orderBy: orderBy?.call(StaffSession.t),
      orderByList: orderByList?.call(StaffSession.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [StaffSession] by its [id] or null if no such row exists.
  Future<StaffSession?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<StaffSession>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [StaffSession]s in the list and returns the inserted rows.
  ///
  /// The returned [StaffSession]s will have their `id` fields set.
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
  Future<List<StaffSession>> insert(
    _is.DatabaseSession session,
    List<StaffSession> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<StaffSession>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [StaffSession] and returns the inserted row.
  ///
  /// The returned [StaffSession] will have its `id` field set.
  Future<StaffSession> insertRow(
    _is.DatabaseSession session,
    StaffSession row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<StaffSession>(row, transaction: transaction);
  }

  /// Upserts all [StaffSession]s in the list and returns the resulting rows.
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
  /// The returned [StaffSession]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StaffSession>> upsert(
    _is.DatabaseSession session,
    List<StaffSession> rows, {
    required _is.ColumnSelections<StaffSessionTable> conflictColumns,
    _is.ColumnSelections<StaffSessionTable>? updateColumns,
    _is.WhereExpressionBuilder<StaffSessionTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<StaffSession>(
      rows,
      conflictColumns: conflictColumns(StaffSession.t),
      updateColumns: updateColumns?.call(StaffSession.t),
      updateWhere: updateWhere?.call(StaffSession.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [StaffSession] and returns the resulting row.
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
  /// The returned [StaffSession] will have its `id` field set.
  Future<StaffSession?> upsertRow(
    _is.DatabaseSession session,
    StaffSession row, {
    required _is.ColumnSelections<StaffSessionTable> conflictColumns,
    _is.ColumnSelections<StaffSessionTable>? updateColumns,
    _is.WhereExpressionBuilder<StaffSessionTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<StaffSession>(
      row,
      conflictColumns: conflictColumns(StaffSession.t),
      updateColumns: updateColumns?.call(StaffSession.t),
      updateWhere: updateWhere?.call(StaffSession.t),
      transaction: transaction,
    );
  }

  /// Updates all [StaffSession]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StaffSession>> update(
    _is.DatabaseSession session,
    List<StaffSession> rows, {
    _is.ColumnSelections<StaffSessionTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<StaffSession>(
      rows,
      columns: columns?.call(StaffSession.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [StaffSession]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StaffSession> updateRow(
    _is.DatabaseSession session,
    StaffSession row, {
    _is.ColumnSelections<StaffSessionTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<StaffSession>(
      row,
      columns: columns?.call(StaffSession.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StaffSession] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StaffSession?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<StaffSessionUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<StaffSession>(
      id,
      columnValues: columnValues(StaffSession.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StaffSession]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StaffSession>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<StaffSessionUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<StaffSessionTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StaffSessionTable>? orderBy,
    _is.OrderByListBuilder<StaffSessionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<StaffSession>(
      columnValues: columnValues(StaffSession.t.updateTable),
      where: where(StaffSession.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StaffSession.t),
      orderByList: orderByList?.call(StaffSession.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [StaffSession]s in the list and returns the deleted rows.
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
  Future<List<StaffSession>> delete(
    _is.DatabaseSession session,
    List<StaffSession> rows, {
    _is.OrderByBuilder<StaffSessionTable>? orderBy,
    _is.OrderByListBuilder<StaffSessionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<StaffSession>(
      rows,
      orderBy: orderBy?.call(StaffSession.t),
      orderByList: orderByList?.call(StaffSession.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [StaffSession].
  Future<StaffSession> deleteRow(
    _is.DatabaseSession session,
    StaffSession row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StaffSession>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StaffSession>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StaffSessionTable> where,
    _is.OrderByBuilder<StaffSessionTable>? orderBy,
    _is.OrderByListBuilder<StaffSessionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<StaffSession>(
      where: where(StaffSession.t),
      orderBy: orderBy?.call(StaffSession.t),
      orderByList: orderByList?.call(StaffSession.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StaffSessionTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<StaffSession>(
      where: where?.call(StaffSession.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [StaffSession] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StaffSessionTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<StaffSession>(
      where: where(StaffSession.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
