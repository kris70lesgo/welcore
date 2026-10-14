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

abstract class MaintenanceJob
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  MaintenanceJob._({
    this.id,
    required this.workspaceId,
    required this.unitId,
    required this.title,
    required this.notes,
    required this.dueAt,
    required this.cost,
    required this.status,
    required this.updatedAt,
  });

  factory MaintenanceJob({
    int? id,
    required int workspaceId,
    required int unitId,
    required String title,
    required String notes,
    required DateTime dueAt,
    required double cost,
    required String status,
    required DateTime updatedAt,
  }) = _MaintenanceJobImpl;

  factory MaintenanceJob.fromJson(Map<String, dynamic> jsonSerialization) {
    return MaintenanceJob(
      id: jsonSerialization['id'] as int?,
      workspaceId: jsonSerialization['workspaceId'] as int,
      unitId: jsonSerialization['unitId'] as int,
      title: jsonSerialization['title'] as String,
      notes: jsonSerialization['notes'] as String,
      dueAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['dueAt']),
      cost: (jsonSerialization['cost'] as num).toDouble(),
      status: jsonSerialization['status'] as String,
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = MaintenanceJobTable();

  static const db = MaintenanceJobRepository._();

  @override
  int? id;

  int workspaceId;

  int unitId;

  String title;

  String notes;

  DateTime dueAt;

  double cost;

  String status;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [MaintenanceJob]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MaintenanceJob copyWith({
    int? id,
    int? workspaceId,
    int? unitId,
    String? title,
    String? notes,
    DateTime? dueAt,
    double? cost,
    String? status,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MaintenanceJob',
      if (id != null) 'id': id,
      'workspaceId': workspaceId,
      'unitId': unitId,
      'title': title,
      'notes': notes,
      'dueAt': dueAt.toJson(),
      'cost': cost,
      'status': status,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MaintenanceJob',
      if (id != null) 'id': id,
      'workspaceId': workspaceId,
      'unitId': unitId,
      'title': title,
      'notes': notes,
      'dueAt': dueAt.toJson(),
      'cost': cost,
      'status': status,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static MaintenanceJobInclude include() {
    return MaintenanceJobInclude._();
  }

  static MaintenanceJobIncludeList includeList({
    _is.WhereExpressionBuilder<MaintenanceJobTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MaintenanceJobTable>? orderBy,
    _is.OrderByListBuilder<MaintenanceJobTable>? orderByList,
    MaintenanceJobInclude? include,
  }) {
    return MaintenanceJobIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MaintenanceJob.t),
      orderByList: orderByList?.call(MaintenanceJob.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MaintenanceJobImpl extends MaintenanceJob {
  _MaintenanceJobImpl({
    int? id,
    required int workspaceId,
    required int unitId,
    required String title,
    required String notes,
    required DateTime dueAt,
    required double cost,
    required String status,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         workspaceId: workspaceId,
         unitId: unitId,
         title: title,
         notes: notes,
         dueAt: dueAt,
         cost: cost,
         status: status,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [MaintenanceJob]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MaintenanceJob copyWith({
    Object? id = _Undefined,
    int? workspaceId,
    int? unitId,
    String? title,
    String? notes,
    DateTime? dueAt,
    double? cost,
    String? status,
    DateTime? updatedAt,
  }) {
    return MaintenanceJob(
      id: id is int? ? id : this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      unitId: unitId ?? this.unitId,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      dueAt: dueAt ?? this.dueAt,
      cost: cost ?? this.cost,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class MaintenanceJobUpdateTable extends _is.UpdateTable<MaintenanceJobTable> {
  MaintenanceJobUpdateTable(super.table);

  _is.ColumnValue<int, int> workspaceId(int value) =>
      _is.ColumnValue(table.workspaceId, value);

  _is.ColumnValue<int, int> unitId(int value) =>
      _is.ColumnValue(table.unitId, value);

  _is.ColumnValue<String, String> title(String value) =>
      _is.ColumnValue(table.title, value);

  _is.ColumnValue<String, String> notes(String value) =>
      _is.ColumnValue(table.notes, value);

  _is.ColumnValue<DateTime, DateTime> dueAt(DateTime value) =>
      _is.ColumnValue(table.dueAt, value);

  _is.ColumnValue<double, double> cost(double value) =>
      _is.ColumnValue(table.cost, value);

  _is.ColumnValue<String, String> status(String value) =>
      _is.ColumnValue(table.status, value);

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(table.updatedAt, value);
}

class MaintenanceJobTable extends _is.Table<int?> {
  MaintenanceJobTable({super.tableRelation})
    : super(tableName: 'dispatch_maintenance') {
    updateTable = MaintenanceJobUpdateTable(this);
    workspaceId = _is.ColumnInt('workspaceId', this);
    unitId = _is.ColumnInt('unitId', this);
    title = _is.ColumnString('title', this);
    notes = _is.ColumnString('notes', this);
    dueAt = _is.ColumnDateTime('dueAt', this);
    cost = _is.ColumnDouble('cost', this);
    status = _is.ColumnString('status', this);
    updatedAt = _is.ColumnDateTime('updatedAt', this);
  }

  late final MaintenanceJobUpdateTable updateTable;

  late final _is.ColumnInt workspaceId;

  late final _is.ColumnInt unitId;

  late final _is.ColumnString title;

  late final _is.ColumnString notes;

  late final _is.ColumnDateTime dueAt;

  late final _is.ColumnDouble cost;

  late final _is.ColumnString status;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    workspaceId,
    unitId,
    title,
    notes,
    dueAt,
    cost,
    status,
    updatedAt,
  ];
}

class MaintenanceJobInclude extends _is.IncludeObject {
  MaintenanceJobInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => MaintenanceJob.t;
}

class MaintenanceJobIncludeList extends _is.IncludeList {
  MaintenanceJobIncludeList._({
    _is.WhereExpressionBuilder<MaintenanceJobTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MaintenanceJob.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => MaintenanceJob.t;
}

class MaintenanceJobRepository {
  const MaintenanceJobRepository._();

  /// Returns a list of [MaintenanceJob]s matching the given query parameters.
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
  Future<List<MaintenanceJob>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MaintenanceJobTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MaintenanceJobTable>? orderBy,
    _is.OrderByListBuilder<MaintenanceJobTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<MaintenanceJob>(
      where: where?.call(MaintenanceJob.t),
      orderBy: orderBy?.call(MaintenanceJob.t),
      orderByList: orderByList?.call(MaintenanceJob.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [MaintenanceJob] matching the given query parameters.
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
  Future<MaintenanceJob?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MaintenanceJobTable>? where,
    int? offset,
    _is.OrderByBuilder<MaintenanceJobTable>? orderBy,
    _is.OrderByListBuilder<MaintenanceJobTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<MaintenanceJob>(
      where: where?.call(MaintenanceJob.t),
      orderBy: orderBy?.call(MaintenanceJob.t),
      orderByList: orderByList?.call(MaintenanceJob.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [MaintenanceJob] by its [id] or null if no such row exists.
  Future<MaintenanceJob?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<MaintenanceJob>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [MaintenanceJob]s in the list and returns the inserted rows.
  ///
  /// The returned [MaintenanceJob]s will have their `id` fields set.
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
  Future<List<MaintenanceJob>> insert(
    _is.DatabaseSession session,
    List<MaintenanceJob> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<MaintenanceJob>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [MaintenanceJob] and returns the inserted row.
  ///
  /// The returned [MaintenanceJob] will have its `id` field set.
  Future<MaintenanceJob> insertRow(
    _is.DatabaseSession session,
    MaintenanceJob row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<MaintenanceJob>(row, transaction: transaction);
  }

  /// Upserts all [MaintenanceJob]s in the list and returns the resulting rows.
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
  /// The returned [MaintenanceJob]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MaintenanceJob>> upsert(
    _is.DatabaseSession session,
    List<MaintenanceJob> rows, {
    required _is.ColumnSelections<MaintenanceJobTable> conflictColumns,
    _is.ColumnSelections<MaintenanceJobTable>? updateColumns,
    _is.WhereExpressionBuilder<MaintenanceJobTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<MaintenanceJob>(
      rows,
      conflictColumns: conflictColumns(MaintenanceJob.t),
      updateColumns: updateColumns?.call(MaintenanceJob.t),
      updateWhere: updateWhere?.call(MaintenanceJob.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [MaintenanceJob] and returns the resulting row.
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
  /// The returned [MaintenanceJob] will have its `id` field set.
  Future<MaintenanceJob?> upsertRow(
    _is.DatabaseSession session,
    MaintenanceJob row, {
    required _is.ColumnSelections<MaintenanceJobTable> conflictColumns,
    _is.ColumnSelections<MaintenanceJobTable>? updateColumns,
    _is.WhereExpressionBuilder<MaintenanceJobTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<MaintenanceJob>(
      row,
      conflictColumns: conflictColumns(MaintenanceJob.t),
      updateColumns: updateColumns?.call(MaintenanceJob.t),
      updateWhere: updateWhere?.call(MaintenanceJob.t),
      transaction: transaction,
    );
  }

  /// Updates all [MaintenanceJob]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MaintenanceJob>> update(
    _is.DatabaseSession session,
    List<MaintenanceJob> rows, {
    _is.ColumnSelections<MaintenanceJobTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<MaintenanceJob>(
      rows,
      columns: columns?.call(MaintenanceJob.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [MaintenanceJob]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MaintenanceJob> updateRow(
    _is.DatabaseSession session,
    MaintenanceJob row, {
    _is.ColumnSelections<MaintenanceJobTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<MaintenanceJob>(
      row,
      columns: columns?.call(MaintenanceJob.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MaintenanceJob] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<MaintenanceJob?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<MaintenanceJobUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<MaintenanceJob>(
      id,
      columnValues: columnValues(MaintenanceJob.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [MaintenanceJob]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MaintenanceJob>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<MaintenanceJobUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<MaintenanceJobTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MaintenanceJobTable>? orderBy,
    _is.OrderByListBuilder<MaintenanceJobTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<MaintenanceJob>(
      columnValues: columnValues(MaintenanceJob.t.updateTable),
      where: where(MaintenanceJob.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MaintenanceJob.t),
      orderByList: orderByList?.call(MaintenanceJob.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [MaintenanceJob]s in the list and returns the deleted rows.
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
  Future<List<MaintenanceJob>> delete(
    _is.DatabaseSession session,
    List<MaintenanceJob> rows, {
    _is.OrderByBuilder<MaintenanceJobTable>? orderBy,
    _is.OrderByListBuilder<MaintenanceJobTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<MaintenanceJob>(
      rows,
      orderBy: orderBy?.call(MaintenanceJob.t),
      orderByList: orderByList?.call(MaintenanceJob.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [MaintenanceJob].
  Future<MaintenanceJob> deleteRow(
    _is.DatabaseSession session,
    MaintenanceJob row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MaintenanceJob>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MaintenanceJob>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MaintenanceJobTable> where,
    _is.OrderByBuilder<MaintenanceJobTable>? orderBy,
    _is.OrderByListBuilder<MaintenanceJobTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<MaintenanceJob>(
      where: where(MaintenanceJob.t),
      orderBy: orderBy?.call(MaintenanceJob.t),
      orderByList: orderByList?.call(MaintenanceJob.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MaintenanceJobTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<MaintenanceJob>(
      where: where?.call(MaintenanceJob.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [MaintenanceJob] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MaintenanceJobTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<MaintenanceJob>(
      where: where(MaintenanceJob.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
