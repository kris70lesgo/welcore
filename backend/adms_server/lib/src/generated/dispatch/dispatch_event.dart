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

abstract class DispatchEvent
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  DispatchEvent._({
    this.id,
    required this.workspaceId,
    required this.incidentId,
    required this.message,
    required this.status,
    required this.createdAt,
  });

  factory DispatchEvent({
    int? id,
    required int workspaceId,
    required int incidentId,
    required String message,
    required String status,
    required DateTime createdAt,
  }) = _DispatchEventImpl;

  factory DispatchEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return DispatchEvent(
      id: jsonSerialization['id'] as int?,
      workspaceId: jsonSerialization['workspaceId'] as int,
      incidentId: jsonSerialization['incidentId'] as int,
      message: jsonSerialization['message'] as String,
      status: jsonSerialization['status'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = DispatchEventTable();

  static const db = DispatchEventRepository._();

  @override
  int? id;

  int workspaceId;

  int incidentId;

  String message;

  String status;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [DispatchEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DispatchEvent copyWith({
    int? id,
    int? workspaceId,
    int? incidentId,
    String? message,
    String? status,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DispatchEvent',
      if (id != null) 'id': id,
      'workspaceId': workspaceId,
      'incidentId': incidentId,
      'message': message,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DispatchEvent',
      if (id != null) 'id': id,
      'workspaceId': workspaceId,
      'incidentId': incidentId,
      'message': message,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  static DispatchEventInclude include() {
    return DispatchEventInclude._();
  }

  static DispatchEventIncludeList includeList({
    _is.WhereExpressionBuilder<DispatchEventTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DispatchEventTable>? orderBy,
    _is.OrderByListBuilder<DispatchEventTable>? orderByList,
    DispatchEventInclude? include,
  }) {
    return DispatchEventIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DispatchEvent.t),
      orderByList: orderByList?.call(DispatchEvent.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DispatchEventImpl extends DispatchEvent {
  _DispatchEventImpl({
    int? id,
    required int workspaceId,
    required int incidentId,
    required String message,
    required String status,
    required DateTime createdAt,
  }) : super._(
         id: id,
         workspaceId: workspaceId,
         incidentId: incidentId,
         message: message,
         status: status,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [DispatchEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DispatchEvent copyWith({
    Object? id = _Undefined,
    int? workspaceId,
    int? incidentId,
    String? message,
    String? status,
    DateTime? createdAt,
  }) {
    return DispatchEvent(
      id: id is int? ? id : this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      incidentId: incidentId ?? this.incidentId,
      message: message ?? this.message,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class DispatchEventUpdateTable extends _is.UpdateTable<DispatchEventTable> {
  DispatchEventUpdateTable(super.table);

  _is.ColumnValue<int, int> workspaceId(int value) =>
      _is.ColumnValue(table.workspaceId, value);

  _is.ColumnValue<int, int> incidentId(int value) =>
      _is.ColumnValue(table.incidentId, value);

  _is.ColumnValue<String, String> message(String value) =>
      _is.ColumnValue(table.message, value);

  _is.ColumnValue<String, String> status(String value) =>
      _is.ColumnValue(table.status, value);

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(table.createdAt, value);
}

class DispatchEventTable extends _is.Table<int?> {
  DispatchEventTable({super.tableRelation})
    : super(tableName: 'dispatch_event') {
    updateTable = DispatchEventUpdateTable(this);
    workspaceId = _is.ColumnInt('workspaceId', this);
    incidentId = _is.ColumnInt('incidentId', this);
    message = _is.ColumnString('message', this);
    status = _is.ColumnString('status', this);
    createdAt = _is.ColumnDateTime('createdAt', this);
  }

  late final DispatchEventUpdateTable updateTable;

  late final _is.ColumnInt workspaceId;

  late final _is.ColumnInt incidentId;

  late final _is.ColumnString message;

  late final _is.ColumnString status;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    workspaceId,
    incidentId,
    message,
    status,
    createdAt,
  ];
}

class DispatchEventInclude extends _is.IncludeObject {
  DispatchEventInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => DispatchEvent.t;
}

class DispatchEventIncludeList extends _is.IncludeList {
  DispatchEventIncludeList._({
    _is.WhereExpressionBuilder<DispatchEventTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DispatchEvent.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => DispatchEvent.t;
}

class DispatchEventRepository {
  const DispatchEventRepository._();

  /// Returns a list of [DispatchEvent]s matching the given query parameters.
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
  Future<List<DispatchEvent>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DispatchEventTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DispatchEventTable>? orderBy,
    _is.OrderByListBuilder<DispatchEventTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DispatchEvent>(
      where: where?.call(DispatchEvent.t),
      orderBy: orderBy?.call(DispatchEvent.t),
      orderByList: orderByList?.call(DispatchEvent.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DispatchEvent] matching the given query parameters.
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
  Future<DispatchEvent?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DispatchEventTable>? where,
    int? offset,
    _is.OrderByBuilder<DispatchEventTable>? orderBy,
    _is.OrderByListBuilder<DispatchEventTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DispatchEvent>(
      where: where?.call(DispatchEvent.t),
      orderBy: orderBy?.call(DispatchEvent.t),
      orderByList: orderByList?.call(DispatchEvent.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DispatchEvent] by its [id] or null if no such row exists.
  Future<DispatchEvent?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DispatchEvent>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DispatchEvent]s in the list and returns the inserted rows.
  ///
  /// The returned [DispatchEvent]s will have their `id` fields set.
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
  Future<List<DispatchEvent>> insert(
    _is.DatabaseSession session,
    List<DispatchEvent> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<DispatchEvent>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [DispatchEvent] and returns the inserted row.
  ///
  /// The returned [DispatchEvent] will have its `id` field set.
  Future<DispatchEvent> insertRow(
    _is.DatabaseSession session,
    DispatchEvent row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<DispatchEvent>(row, transaction: transaction);
  }

  /// Upserts all [DispatchEvent]s in the list and returns the resulting rows.
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
  /// The returned [DispatchEvent]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DispatchEvent>> upsert(
    _is.DatabaseSession session,
    List<DispatchEvent> rows, {
    required _is.ColumnSelections<DispatchEventTable> conflictColumns,
    _is.ColumnSelections<DispatchEventTable>? updateColumns,
    _is.WhereExpressionBuilder<DispatchEventTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<DispatchEvent>(
      rows,
      conflictColumns: conflictColumns(DispatchEvent.t),
      updateColumns: updateColumns?.call(DispatchEvent.t),
      updateWhere: updateWhere?.call(DispatchEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [DispatchEvent] and returns the resulting row.
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
  /// The returned [DispatchEvent] will have its `id` field set.
  Future<DispatchEvent?> upsertRow(
    _is.DatabaseSession session,
    DispatchEvent row, {
    required _is.ColumnSelections<DispatchEventTable> conflictColumns,
    _is.ColumnSelections<DispatchEventTable>? updateColumns,
    _is.WhereExpressionBuilder<DispatchEventTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<DispatchEvent>(
      row,
      conflictColumns: conflictColumns(DispatchEvent.t),
      updateColumns: updateColumns?.call(DispatchEvent.t),
      updateWhere: updateWhere?.call(DispatchEvent.t),
      transaction: transaction,
    );
  }

  /// Updates all [DispatchEvent]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DispatchEvent>> update(
    _is.DatabaseSession session,
    List<DispatchEvent> rows, {
    _is.ColumnSelections<DispatchEventTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<DispatchEvent>(
      rows,
      columns: columns?.call(DispatchEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [DispatchEvent]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DispatchEvent> updateRow(
    _is.DatabaseSession session,
    DispatchEvent row, {
    _is.ColumnSelections<DispatchEventTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<DispatchEvent>(
      row,
      columns: columns?.call(DispatchEvent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DispatchEvent] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DispatchEvent?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<DispatchEventUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<DispatchEvent>(
      id,
      columnValues: columnValues(DispatchEvent.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DispatchEvent]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DispatchEvent>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<DispatchEventUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<DispatchEventTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DispatchEventTable>? orderBy,
    _is.OrderByListBuilder<DispatchEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<DispatchEvent>(
      columnValues: columnValues(DispatchEvent.t.updateTable),
      where: where(DispatchEvent.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DispatchEvent.t),
      orderByList: orderByList?.call(DispatchEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [DispatchEvent]s in the list and returns the deleted rows.
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
  Future<List<DispatchEvent>> delete(
    _is.DatabaseSession session,
    List<DispatchEvent> rows, {
    _is.OrderByBuilder<DispatchEventTable>? orderBy,
    _is.OrderByListBuilder<DispatchEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<DispatchEvent>(
      rows,
      orderBy: orderBy?.call(DispatchEvent.t),
      orderByList: orderByList?.call(DispatchEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [DispatchEvent].
  Future<DispatchEvent> deleteRow(
    _is.DatabaseSession session,
    DispatchEvent row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DispatchEvent>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DispatchEvent>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DispatchEventTable> where,
    _is.OrderByBuilder<DispatchEventTable>? orderBy,
    _is.OrderByListBuilder<DispatchEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<DispatchEvent>(
      where: where(DispatchEvent.t),
      orderBy: orderBy?.call(DispatchEvent.t),
      orderByList: orderByList?.call(DispatchEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DispatchEventTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<DispatchEvent>(
      where: where?.call(DispatchEvent.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DispatchEvent] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DispatchEventTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DispatchEvent>(
      where: where(DispatchEvent.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
