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

abstract class DispatchSession
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  DispatchSession._({
    this.id,
    String? name,
    bool? isDemo,
    bool? autoDispatch,
    int? responseTargetMinutes,
    required this.tokenHash,
    required this.revision,
    required this.expiresAt,
  }) : name = name ?? 'Manila operations',
       isDemo = isDemo ?? true,
       autoDispatch = autoDispatch ?? false,
       responseTargetMinutes = responseTargetMinutes ?? 10;

  factory DispatchSession({
    int? id,
    String? name,
    bool? isDemo,
    bool? autoDispatch,
    int? responseTargetMinutes,
    required String tokenHash,
    required int revision,
    required DateTime expiresAt,
  }) = _DispatchSessionImpl;

  factory DispatchSession.fromJson(Map<String, dynamic> jsonSerialization) {
    return DispatchSession(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String?,
      isDemo: jsonSerialization['isDemo'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isDemo']),
      autoDispatch: jsonSerialization['autoDispatch'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['autoDispatch']),
      responseTargetMinutes: jsonSerialization['responseTargetMinutes'] as int?,
      tokenHash: jsonSerialization['tokenHash'] as String,
      revision: jsonSerialization['revision'] as int,
      expiresAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
    );
  }

  static final t = DispatchSessionTable();

  static const db = DispatchSessionRepository._();

  @override
  int? id;

  String name;

  bool isDemo;

  bool autoDispatch;

  int responseTargetMinutes;

  String tokenHash;

  int revision;

  DateTime expiresAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [DispatchSession]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DispatchSession copyWith({
    int? id,
    String? name,
    bool? isDemo,
    bool? autoDispatch,
    int? responseTargetMinutes,
    String? tokenHash,
    int? revision,
    DateTime? expiresAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DispatchSession',
      if (id != null) 'id': id,
      'name': name,
      'isDemo': isDemo,
      'autoDispatch': autoDispatch,
      'responseTargetMinutes': responseTargetMinutes,
      'tokenHash': tokenHash,
      'revision': revision,
      'expiresAt': expiresAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static DispatchSessionInclude include() {
    return DispatchSessionInclude._();
  }

  static DispatchSessionIncludeList includeList({
    _is.WhereExpressionBuilder<DispatchSessionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DispatchSessionTable>? orderBy,
    _is.OrderByListBuilder<DispatchSessionTable>? orderByList,
    DispatchSessionInclude? include,
  }) {
    return DispatchSessionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DispatchSession.t),
      orderByList: orderByList?.call(DispatchSession.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DispatchSessionImpl extends DispatchSession {
  _DispatchSessionImpl({
    int? id,
    String? name,
    bool? isDemo,
    bool? autoDispatch,
    int? responseTargetMinutes,
    required String tokenHash,
    required int revision,
    required DateTime expiresAt,
  }) : super._(
         id: id,
         name: name,
         isDemo: isDemo,
         autoDispatch: autoDispatch,
         responseTargetMinutes: responseTargetMinutes,
         tokenHash: tokenHash,
         revision: revision,
         expiresAt: expiresAt,
       );

  /// Returns a shallow copy of this [DispatchSession]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DispatchSession copyWith({
    Object? id = _Undefined,
    String? name,
    bool? isDemo,
    bool? autoDispatch,
    int? responseTargetMinutes,
    String? tokenHash,
    int? revision,
    DateTime? expiresAt,
  }) {
    return DispatchSession(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      isDemo: isDemo ?? this.isDemo,
      autoDispatch: autoDispatch ?? this.autoDispatch,
      responseTargetMinutes:
          responseTargetMinutes ?? this.responseTargetMinutes,
      tokenHash: tokenHash ?? this.tokenHash,
      revision: revision ?? this.revision,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }
}

class DispatchSessionUpdateTable extends _is.UpdateTable<DispatchSessionTable> {
  DispatchSessionUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) =>
      _is.ColumnValue(table.name, value);

  _is.ColumnValue<bool, bool> isDemo(bool value) =>
      _is.ColumnValue(table.isDemo, value);

  _is.ColumnValue<bool, bool> autoDispatch(bool value) =>
      _is.ColumnValue(table.autoDispatch, value);

  _is.ColumnValue<int, int> responseTargetMinutes(int value) =>
      _is.ColumnValue(table.responseTargetMinutes, value);

  _is.ColumnValue<String, String> tokenHash(String value) =>
      _is.ColumnValue(table.tokenHash, value);

  _is.ColumnValue<int, int> revision(int value) =>
      _is.ColumnValue(table.revision, value);

  _is.ColumnValue<DateTime, DateTime> expiresAt(DateTime value) =>
      _is.ColumnValue(table.expiresAt, value);
}

class DispatchSessionTable extends _is.Table<int?> {
  DispatchSessionTable({super.tableRelation})
    : super(tableName: 'dispatch_session') {
    updateTable = DispatchSessionUpdateTable(this);
    name = _is.ColumnString('name', this, hasDefault: true);
    isDemo = _is.ColumnBool('isDemo', this, hasDefault: true);
    autoDispatch = _is.ColumnBool('autoDispatch', this, hasDefault: true);
    responseTargetMinutes = _is.ColumnInt(
      'responseTargetMinutes',
      this,
      hasDefault: true,
    );
    tokenHash = _is.ColumnString('tokenHash', this);
    revision = _is.ColumnInt('revision', this);
    expiresAt = _is.ColumnDateTime('expiresAt', this);
  }

  late final DispatchSessionUpdateTable updateTable;

  late final _is.ColumnString name;

  late final _is.ColumnBool isDemo;

  late final _is.ColumnBool autoDispatch;

  late final _is.ColumnInt responseTargetMinutes;

  late final _is.ColumnString tokenHash;

  late final _is.ColumnInt revision;

  late final _is.ColumnDateTime expiresAt;

  @override
  List<_is.Column> get columns => [
    id,
    name,
    isDemo,
    autoDispatch,
    responseTargetMinutes,
    tokenHash,
    revision,
    expiresAt,
  ];
}

class DispatchSessionInclude extends _is.IncludeObject {
  DispatchSessionInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => DispatchSession.t;
}

class DispatchSessionIncludeList extends _is.IncludeList {
  DispatchSessionIncludeList._({
    _is.WhereExpressionBuilder<DispatchSessionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DispatchSession.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => DispatchSession.t;
}

class DispatchSessionRepository {
  const DispatchSessionRepository._();

  /// Returns a list of [DispatchSession]s matching the given query parameters.
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
  Future<List<DispatchSession>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DispatchSessionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DispatchSessionTable>? orderBy,
    _is.OrderByListBuilder<DispatchSessionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DispatchSession>(
      where: where?.call(DispatchSession.t),
      orderBy: orderBy?.call(DispatchSession.t),
      orderByList: orderByList?.call(DispatchSession.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DispatchSession] matching the given query parameters.
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
  Future<DispatchSession?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DispatchSessionTable>? where,
    int? offset,
    _is.OrderByBuilder<DispatchSessionTable>? orderBy,
    _is.OrderByListBuilder<DispatchSessionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DispatchSession>(
      where: where?.call(DispatchSession.t),
      orderBy: orderBy?.call(DispatchSession.t),
      orderByList: orderByList?.call(DispatchSession.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DispatchSession] by its [id] or null if no such row exists.
  Future<DispatchSession?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DispatchSession>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DispatchSession]s in the list and returns the inserted rows.
  ///
  /// The returned [DispatchSession]s will have their `id` fields set.
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
  Future<List<DispatchSession>> insert(
    _is.DatabaseSession session,
    List<DispatchSession> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<DispatchSession>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [DispatchSession] and returns the inserted row.
  ///
  /// The returned [DispatchSession] will have its `id` field set.
  Future<DispatchSession> insertRow(
    _is.DatabaseSession session,
    DispatchSession row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<DispatchSession>(row, transaction: transaction);
  }

  /// Upserts all [DispatchSession]s in the list and returns the resulting rows.
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
  /// The returned [DispatchSession]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DispatchSession>> upsert(
    _is.DatabaseSession session,
    List<DispatchSession> rows, {
    required _is.ColumnSelections<DispatchSessionTable> conflictColumns,
    _is.ColumnSelections<DispatchSessionTable>? updateColumns,
    _is.WhereExpressionBuilder<DispatchSessionTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<DispatchSession>(
      rows,
      conflictColumns: conflictColumns(DispatchSession.t),
      updateColumns: updateColumns?.call(DispatchSession.t),
      updateWhere: updateWhere?.call(DispatchSession.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [DispatchSession] and returns the resulting row.
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
  /// The returned [DispatchSession] will have its `id` field set.
  Future<DispatchSession?> upsertRow(
    _is.DatabaseSession session,
    DispatchSession row, {
    required _is.ColumnSelections<DispatchSessionTable> conflictColumns,
    _is.ColumnSelections<DispatchSessionTable>? updateColumns,
    _is.WhereExpressionBuilder<DispatchSessionTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<DispatchSession>(
      row,
      conflictColumns: conflictColumns(DispatchSession.t),
      updateColumns: updateColumns?.call(DispatchSession.t),
      updateWhere: updateWhere?.call(DispatchSession.t),
      transaction: transaction,
    );
  }

  /// Updates all [DispatchSession]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DispatchSession>> update(
    _is.DatabaseSession session,
    List<DispatchSession> rows, {
    _is.ColumnSelections<DispatchSessionTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<DispatchSession>(
      rows,
      columns: columns?.call(DispatchSession.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [DispatchSession]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DispatchSession> updateRow(
    _is.DatabaseSession session,
    DispatchSession row, {
    _is.ColumnSelections<DispatchSessionTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<DispatchSession>(
      row,
      columns: columns?.call(DispatchSession.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DispatchSession] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DispatchSession?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<DispatchSessionUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<DispatchSession>(
      id,
      columnValues: columnValues(DispatchSession.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DispatchSession]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DispatchSession>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<DispatchSessionUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<DispatchSessionTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DispatchSessionTable>? orderBy,
    _is.OrderByListBuilder<DispatchSessionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<DispatchSession>(
      columnValues: columnValues(DispatchSession.t.updateTable),
      where: where(DispatchSession.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DispatchSession.t),
      orderByList: orderByList?.call(DispatchSession.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [DispatchSession]s in the list and returns the deleted rows.
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
  Future<List<DispatchSession>> delete(
    _is.DatabaseSession session,
    List<DispatchSession> rows, {
    _is.OrderByBuilder<DispatchSessionTable>? orderBy,
    _is.OrderByListBuilder<DispatchSessionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<DispatchSession>(
      rows,
      orderBy: orderBy?.call(DispatchSession.t),
      orderByList: orderByList?.call(DispatchSession.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [DispatchSession].
  Future<DispatchSession> deleteRow(
    _is.DatabaseSession session,
    DispatchSession row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DispatchSession>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DispatchSession>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DispatchSessionTable> where,
    _is.OrderByBuilder<DispatchSessionTable>? orderBy,
    _is.OrderByListBuilder<DispatchSessionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<DispatchSession>(
      where: where(DispatchSession.t),
      orderBy: orderBy?.call(DispatchSession.t),
      orderByList: orderByList?.call(DispatchSession.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DispatchSessionTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<DispatchSession>(
      where: where?.call(DispatchSession.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DispatchSession] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DispatchSessionTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DispatchSession>(
      where: where(DispatchSession.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
