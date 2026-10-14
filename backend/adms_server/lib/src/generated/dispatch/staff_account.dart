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

abstract class StaffAccount
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  StaffAccount._({
    this.id,
    required this.workspaceId,
    required this.email,
    required this.name,
    required this.role,
    required this.passwordSalt,
    required this.passwordHash,
    required this.active,
    this.assignedUnitId,
    required this.createdAt,
  });

  factory StaffAccount({
    int? id,
    required int workspaceId,
    required String email,
    required String name,
    required String role,
    required String passwordSalt,
    required String passwordHash,
    required bool active,
    int? assignedUnitId,
    required DateTime createdAt,
  }) = _StaffAccountImpl;

  factory StaffAccount.fromJson(Map<String, dynamic> jsonSerialization) {
    return StaffAccount(
      id: jsonSerialization['id'] as int?,
      workspaceId: jsonSerialization['workspaceId'] as int,
      email: jsonSerialization['email'] as String,
      name: jsonSerialization['name'] as String,
      role: jsonSerialization['role'] as String,
      passwordSalt: jsonSerialization['passwordSalt'] as String,
      passwordHash: jsonSerialization['passwordHash'] as String,
      active: _is.BoolJsonExtension.fromJson(jsonSerialization['active']),
      assignedUnitId: jsonSerialization['assignedUnitId'] as int?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = StaffAccountTable();

  static const db = StaffAccountRepository._();

  @override
  int? id;

  int workspaceId;

  String email;

  String name;

  String role;

  String passwordSalt;

  String passwordHash;

  bool active;

  int? assignedUnitId;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [StaffAccount]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  StaffAccount copyWith({
    int? id,
    int? workspaceId,
    String? email,
    String? name,
    String? role,
    String? passwordSalt,
    String? passwordHash,
    bool? active,
    int? assignedUnitId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StaffAccount',
      if (id != null) 'id': id,
      'workspaceId': workspaceId,
      'email': email,
      'name': name,
      'role': role,
      'passwordSalt': passwordSalt,
      'passwordHash': passwordHash,
      'active': active,
      if (assignedUnitId != null) 'assignedUnitId': assignedUnitId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static StaffAccountInclude include() {
    return StaffAccountInclude._();
  }

  static StaffAccountIncludeList includeList({
    _is.WhereExpressionBuilder<StaffAccountTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StaffAccountTable>? orderBy,
    _is.OrderByListBuilder<StaffAccountTable>? orderByList,
    StaffAccountInclude? include,
  }) {
    return StaffAccountIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StaffAccount.t),
      orderByList: orderByList?.call(StaffAccount.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StaffAccountImpl extends StaffAccount {
  _StaffAccountImpl({
    int? id,
    required int workspaceId,
    required String email,
    required String name,
    required String role,
    required String passwordSalt,
    required String passwordHash,
    required bool active,
    int? assignedUnitId,
    required DateTime createdAt,
  }) : super._(
         id: id,
         workspaceId: workspaceId,
         email: email,
         name: name,
         role: role,
         passwordSalt: passwordSalt,
         passwordHash: passwordHash,
         active: active,
         assignedUnitId: assignedUnitId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [StaffAccount]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  StaffAccount copyWith({
    Object? id = _Undefined,
    int? workspaceId,
    String? email,
    String? name,
    String? role,
    String? passwordSalt,
    String? passwordHash,
    bool? active,
    Object? assignedUnitId = _Undefined,
    DateTime? createdAt,
  }) {
    return StaffAccount(
      id: id is int? ? id : this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      passwordSalt: passwordSalt ?? this.passwordSalt,
      passwordHash: passwordHash ?? this.passwordHash,
      active: active ?? this.active,
      assignedUnitId: assignedUnitId is int?
          ? assignedUnitId
          : this.assignedUnitId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class StaffAccountUpdateTable extends _is.UpdateTable<StaffAccountTable> {
  StaffAccountUpdateTable(super.table);

  _is.ColumnValue<int, int> workspaceId(int value) =>
      _is.ColumnValue(table.workspaceId, value);

  _is.ColumnValue<String, String> email(String value) =>
      _is.ColumnValue(table.email, value);

  _is.ColumnValue<String, String> name(String value) =>
      _is.ColumnValue(table.name, value);

  _is.ColumnValue<String, String> role(String value) =>
      _is.ColumnValue(table.role, value);

  _is.ColumnValue<String, String> passwordSalt(String value) =>
      _is.ColumnValue(table.passwordSalt, value);

  _is.ColumnValue<String, String> passwordHash(String value) =>
      _is.ColumnValue(table.passwordHash, value);

  _is.ColumnValue<bool, bool> active(bool value) =>
      _is.ColumnValue(table.active, value);

  _is.ColumnValue<int, int> assignedUnitId(int? value) =>
      _is.ColumnValue(table.assignedUnitId, value);

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(table.createdAt, value);
}

class StaffAccountTable extends _is.Table<int?> {
  StaffAccountTable({super.tableRelation}) : super(tableName: 'staff_account') {
    updateTable = StaffAccountUpdateTable(this);
    workspaceId = _is.ColumnInt('workspaceId', this);
    email = _is.ColumnString('email', this);
    name = _is.ColumnString('name', this);
    role = _is.ColumnString('role', this);
    passwordSalt = _is.ColumnString('passwordSalt', this);
    passwordHash = _is.ColumnString('passwordHash', this);
    active = _is.ColumnBool('active', this);
    assignedUnitId = _is.ColumnInt('assignedUnitId', this);
    createdAt = _is.ColumnDateTime('createdAt', this);
  }

  late final StaffAccountUpdateTable updateTable;

  late final _is.ColumnInt workspaceId;

  late final _is.ColumnString email;

  late final _is.ColumnString name;

  late final _is.ColumnString role;

  late final _is.ColumnString passwordSalt;

  late final _is.ColumnString passwordHash;

  late final _is.ColumnBool active;

  late final _is.ColumnInt assignedUnitId;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    workspaceId,
    email,
    name,
    role,
    passwordSalt,
    passwordHash,
    active,
    assignedUnitId,
    createdAt,
  ];
}

class StaffAccountInclude extends _is.IncludeObject {
  StaffAccountInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => StaffAccount.t;
}

class StaffAccountIncludeList extends _is.IncludeList {
  StaffAccountIncludeList._({
    _is.WhereExpressionBuilder<StaffAccountTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StaffAccount.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => StaffAccount.t;
}

class StaffAccountRepository {
  const StaffAccountRepository._();

  /// Returns a list of [StaffAccount]s matching the given query parameters.
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
  Future<List<StaffAccount>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StaffAccountTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StaffAccountTable>? orderBy,
    _is.OrderByListBuilder<StaffAccountTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<StaffAccount>(
      where: where?.call(StaffAccount.t),
      orderBy: orderBy?.call(StaffAccount.t),
      orderByList: orderByList?.call(StaffAccount.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [StaffAccount] matching the given query parameters.
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
  Future<StaffAccount?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StaffAccountTable>? where,
    int? offset,
    _is.OrderByBuilder<StaffAccountTable>? orderBy,
    _is.OrderByListBuilder<StaffAccountTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<StaffAccount>(
      where: where?.call(StaffAccount.t),
      orderBy: orderBy?.call(StaffAccount.t),
      orderByList: orderByList?.call(StaffAccount.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [StaffAccount] by its [id] or null if no such row exists.
  Future<StaffAccount?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<StaffAccount>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [StaffAccount]s in the list and returns the inserted rows.
  ///
  /// The returned [StaffAccount]s will have their `id` fields set.
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
  Future<List<StaffAccount>> insert(
    _is.DatabaseSession session,
    List<StaffAccount> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<StaffAccount>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [StaffAccount] and returns the inserted row.
  ///
  /// The returned [StaffAccount] will have its `id` field set.
  Future<StaffAccount> insertRow(
    _is.DatabaseSession session,
    StaffAccount row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<StaffAccount>(row, transaction: transaction);
  }

  /// Upserts all [StaffAccount]s in the list and returns the resulting rows.
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
  /// The returned [StaffAccount]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StaffAccount>> upsert(
    _is.DatabaseSession session,
    List<StaffAccount> rows, {
    required _is.ColumnSelections<StaffAccountTable> conflictColumns,
    _is.ColumnSelections<StaffAccountTable>? updateColumns,
    _is.WhereExpressionBuilder<StaffAccountTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<StaffAccount>(
      rows,
      conflictColumns: conflictColumns(StaffAccount.t),
      updateColumns: updateColumns?.call(StaffAccount.t),
      updateWhere: updateWhere?.call(StaffAccount.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [StaffAccount] and returns the resulting row.
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
  /// The returned [StaffAccount] will have its `id` field set.
  Future<StaffAccount?> upsertRow(
    _is.DatabaseSession session,
    StaffAccount row, {
    required _is.ColumnSelections<StaffAccountTable> conflictColumns,
    _is.ColumnSelections<StaffAccountTable>? updateColumns,
    _is.WhereExpressionBuilder<StaffAccountTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<StaffAccount>(
      row,
      conflictColumns: conflictColumns(StaffAccount.t),
      updateColumns: updateColumns?.call(StaffAccount.t),
      updateWhere: updateWhere?.call(StaffAccount.t),
      transaction: transaction,
    );
  }

  /// Updates all [StaffAccount]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StaffAccount>> update(
    _is.DatabaseSession session,
    List<StaffAccount> rows, {
    _is.ColumnSelections<StaffAccountTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<StaffAccount>(
      rows,
      columns: columns?.call(StaffAccount.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [StaffAccount]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StaffAccount> updateRow(
    _is.DatabaseSession session,
    StaffAccount row, {
    _is.ColumnSelections<StaffAccountTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<StaffAccount>(
      row,
      columns: columns?.call(StaffAccount.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StaffAccount] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StaffAccount?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<StaffAccountUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<StaffAccount>(
      id,
      columnValues: columnValues(StaffAccount.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StaffAccount]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StaffAccount>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<StaffAccountUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<StaffAccountTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StaffAccountTable>? orderBy,
    _is.OrderByListBuilder<StaffAccountTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<StaffAccount>(
      columnValues: columnValues(StaffAccount.t.updateTable),
      where: where(StaffAccount.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StaffAccount.t),
      orderByList: orderByList?.call(StaffAccount.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [StaffAccount]s in the list and returns the deleted rows.
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
  Future<List<StaffAccount>> delete(
    _is.DatabaseSession session,
    List<StaffAccount> rows, {
    _is.OrderByBuilder<StaffAccountTable>? orderBy,
    _is.OrderByListBuilder<StaffAccountTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<StaffAccount>(
      rows,
      orderBy: orderBy?.call(StaffAccount.t),
      orderByList: orderByList?.call(StaffAccount.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [StaffAccount].
  Future<StaffAccount> deleteRow(
    _is.DatabaseSession session,
    StaffAccount row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StaffAccount>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StaffAccount>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StaffAccountTable> where,
    _is.OrderByBuilder<StaffAccountTable>? orderBy,
    _is.OrderByListBuilder<StaffAccountTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<StaffAccount>(
      where: where(StaffAccount.t),
      orderBy: orderBy?.call(StaffAccount.t),
      orderByList: orderByList?.call(StaffAccount.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StaffAccountTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<StaffAccount>(
      where: where?.call(StaffAccount.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [StaffAccount] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StaffAccountTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<StaffAccount>(
      where: where(StaffAccount.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
