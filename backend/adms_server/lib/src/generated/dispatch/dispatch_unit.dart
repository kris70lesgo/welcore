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

abstract class DispatchUnit
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  DispatchUnit._({
    this.id,
    this.plateNumber,
    this.unitType,
    bool? active,
    this.locationUpdatedAt,
    required this.workspaceId,
    required this.callSign,
    required this.crew,
    required this.latitude,
    required this.longitude,
    required this.status,
  }) : active = active ?? true;

  factory DispatchUnit({
    int? id,
    String? plateNumber,
    String? unitType,
    bool? active,
    DateTime? locationUpdatedAt,
    required int workspaceId,
    required String callSign,
    required String crew,
    required double latitude,
    required double longitude,
    required String status,
  }) = _DispatchUnitImpl;

  factory DispatchUnit.fromJson(Map<String, dynamic> jsonSerialization) {
    return DispatchUnit(
      id: jsonSerialization['id'] as int?,
      plateNumber: jsonSerialization['plateNumber'] as String?,
      unitType: jsonSerialization['unitType'] as String?,
      active: jsonSerialization['active'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['active']),
      locationUpdatedAt: jsonSerialization['locationUpdatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['locationUpdatedAt'],
            ),
      workspaceId: jsonSerialization['workspaceId'] as int,
      callSign: jsonSerialization['callSign'] as String,
      crew: jsonSerialization['crew'] as String,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      status: jsonSerialization['status'] as String,
    );
  }

  static final t = DispatchUnitTable();

  static const db = DispatchUnitRepository._();

  @override
  int? id;

  String? plateNumber;

  String? unitType;

  bool active;

  DateTime? locationUpdatedAt;

  int workspaceId;

  String callSign;

  String crew;

  double latitude;

  double longitude;

  String status;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [DispatchUnit]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DispatchUnit copyWith({
    int? id,
    String? plateNumber,
    String? unitType,
    bool? active,
    DateTime? locationUpdatedAt,
    int? workspaceId,
    String? callSign,
    String? crew,
    double? latitude,
    double? longitude,
    String? status,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DispatchUnit',
      if (id != null) 'id': id,
      if (plateNumber != null) 'plateNumber': plateNumber,
      if (unitType != null) 'unitType': unitType,
      'active': active,
      if (locationUpdatedAt != null)
        'locationUpdatedAt': locationUpdatedAt?.toJson(),
      'workspaceId': workspaceId,
      'callSign': callSign,
      'crew': crew,
      'latitude': latitude,
      'longitude': longitude,
      'status': status,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DispatchUnit',
      if (id != null) 'id': id,
      if (plateNumber != null) 'plateNumber': plateNumber,
      if (unitType != null) 'unitType': unitType,
      'active': active,
      if (locationUpdatedAt != null)
        'locationUpdatedAt': locationUpdatedAt?.toJson(),
      'workspaceId': workspaceId,
      'callSign': callSign,
      'crew': crew,
      'latitude': latitude,
      'longitude': longitude,
      'status': status,
    };
  }

  static DispatchUnitInclude include() {
    return DispatchUnitInclude._();
  }

  static DispatchUnitIncludeList includeList({
    _is.WhereExpressionBuilder<DispatchUnitTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DispatchUnitTable>? orderBy,
    _is.OrderByListBuilder<DispatchUnitTable>? orderByList,
    DispatchUnitInclude? include,
  }) {
    return DispatchUnitIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DispatchUnit.t),
      orderByList: orderByList?.call(DispatchUnit.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DispatchUnitImpl extends DispatchUnit {
  _DispatchUnitImpl({
    int? id,
    String? plateNumber,
    String? unitType,
    bool? active,
    DateTime? locationUpdatedAt,
    required int workspaceId,
    required String callSign,
    required String crew,
    required double latitude,
    required double longitude,
    required String status,
  }) : super._(
         id: id,
         plateNumber: plateNumber,
         unitType: unitType,
         active: active,
         locationUpdatedAt: locationUpdatedAt,
         workspaceId: workspaceId,
         callSign: callSign,
         crew: crew,
         latitude: latitude,
         longitude: longitude,
         status: status,
       );

  /// Returns a shallow copy of this [DispatchUnit]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DispatchUnit copyWith({
    Object? id = _Undefined,
    Object? plateNumber = _Undefined,
    Object? unitType = _Undefined,
    bool? active,
    Object? locationUpdatedAt = _Undefined,
    int? workspaceId,
    String? callSign,
    String? crew,
    double? latitude,
    double? longitude,
    String? status,
  }) {
    return DispatchUnit(
      id: id is int? ? id : this.id,
      plateNumber: plateNumber is String? ? plateNumber : this.plateNumber,
      unitType: unitType is String? ? unitType : this.unitType,
      active: active ?? this.active,
      locationUpdatedAt: locationUpdatedAt is DateTime?
          ? locationUpdatedAt
          : this.locationUpdatedAt,
      workspaceId: workspaceId ?? this.workspaceId,
      callSign: callSign ?? this.callSign,
      crew: crew ?? this.crew,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      status: status ?? this.status,
    );
  }
}

class DispatchUnitUpdateTable extends _is.UpdateTable<DispatchUnitTable> {
  DispatchUnitUpdateTable(super.table);

  _is.ColumnValue<String, String> plateNumber(String? value) =>
      _is.ColumnValue(table.plateNumber, value);

  _is.ColumnValue<String, String> unitType(String? value) =>
      _is.ColumnValue(table.unitType, value);

  _is.ColumnValue<bool, bool> active(bool value) =>
      _is.ColumnValue(table.active, value);

  _is.ColumnValue<DateTime, DateTime> locationUpdatedAt(DateTime? value) =>
      _is.ColumnValue(table.locationUpdatedAt, value);

  _is.ColumnValue<int, int> workspaceId(int value) =>
      _is.ColumnValue(table.workspaceId, value);

  _is.ColumnValue<String, String> callSign(String value) =>
      _is.ColumnValue(table.callSign, value);

  _is.ColumnValue<String, String> crew(String value) =>
      _is.ColumnValue(table.crew, value);

  _is.ColumnValue<double, double> latitude(double value) =>
      _is.ColumnValue(table.latitude, value);

  _is.ColumnValue<double, double> longitude(double value) =>
      _is.ColumnValue(table.longitude, value);

  _is.ColumnValue<String, String> status(String value) =>
      _is.ColumnValue(table.status, value);
}

class DispatchUnitTable extends _is.Table<int?> {
  DispatchUnitTable({super.tableRelation}) : super(tableName: 'dispatch_unit') {
    updateTable = DispatchUnitUpdateTable(this);
    plateNumber = _is.ColumnString('plateNumber', this);
    unitType = _is.ColumnString('unitType', this);
    active = _is.ColumnBool('active', this, hasDefault: true);
    locationUpdatedAt = _is.ColumnDateTime('locationUpdatedAt', this);
    workspaceId = _is.ColumnInt('workspaceId', this);
    callSign = _is.ColumnString('callSign', this);
    crew = _is.ColumnString('crew', this);
    latitude = _is.ColumnDouble('latitude', this);
    longitude = _is.ColumnDouble('longitude', this);
    status = _is.ColumnString('status', this);
  }

  late final DispatchUnitUpdateTable updateTable;

  late final _is.ColumnString plateNumber;

  late final _is.ColumnString unitType;

  late final _is.ColumnBool active;

  late final _is.ColumnDateTime locationUpdatedAt;

  late final _is.ColumnInt workspaceId;

  late final _is.ColumnString callSign;

  late final _is.ColumnString crew;

  late final _is.ColumnDouble latitude;

  late final _is.ColumnDouble longitude;

  late final _is.ColumnString status;

  @override
  List<_is.Column> get columns => [
    id,
    plateNumber,
    unitType,
    active,
    locationUpdatedAt,
    workspaceId,
    callSign,
    crew,
    latitude,
    longitude,
    status,
  ];
}

class DispatchUnitInclude extends _is.IncludeObject {
  DispatchUnitInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => DispatchUnit.t;
}

class DispatchUnitIncludeList extends _is.IncludeList {
  DispatchUnitIncludeList._({
    _is.WhereExpressionBuilder<DispatchUnitTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DispatchUnit.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => DispatchUnit.t;
}

class DispatchUnitRepository {
  const DispatchUnitRepository._();

  /// Returns a list of [DispatchUnit]s matching the given query parameters.
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
  Future<List<DispatchUnit>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DispatchUnitTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DispatchUnitTable>? orderBy,
    _is.OrderByListBuilder<DispatchUnitTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DispatchUnit>(
      where: where?.call(DispatchUnit.t),
      orderBy: orderBy?.call(DispatchUnit.t),
      orderByList: orderByList?.call(DispatchUnit.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DispatchUnit] matching the given query parameters.
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
  Future<DispatchUnit?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DispatchUnitTable>? where,
    int? offset,
    _is.OrderByBuilder<DispatchUnitTable>? orderBy,
    _is.OrderByListBuilder<DispatchUnitTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DispatchUnit>(
      where: where?.call(DispatchUnit.t),
      orderBy: orderBy?.call(DispatchUnit.t),
      orderByList: orderByList?.call(DispatchUnit.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DispatchUnit] by its [id] or null if no such row exists.
  Future<DispatchUnit?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DispatchUnit>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DispatchUnit]s in the list and returns the inserted rows.
  ///
  /// The returned [DispatchUnit]s will have their `id` fields set.
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
  Future<List<DispatchUnit>> insert(
    _is.DatabaseSession session,
    List<DispatchUnit> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<DispatchUnit>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [DispatchUnit] and returns the inserted row.
  ///
  /// The returned [DispatchUnit] will have its `id` field set.
  Future<DispatchUnit> insertRow(
    _is.DatabaseSession session,
    DispatchUnit row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<DispatchUnit>(row, transaction: transaction);
  }

  /// Upserts all [DispatchUnit]s in the list and returns the resulting rows.
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
  /// The returned [DispatchUnit]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DispatchUnit>> upsert(
    _is.DatabaseSession session,
    List<DispatchUnit> rows, {
    required _is.ColumnSelections<DispatchUnitTable> conflictColumns,
    _is.ColumnSelections<DispatchUnitTable>? updateColumns,
    _is.WhereExpressionBuilder<DispatchUnitTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<DispatchUnit>(
      rows,
      conflictColumns: conflictColumns(DispatchUnit.t),
      updateColumns: updateColumns?.call(DispatchUnit.t),
      updateWhere: updateWhere?.call(DispatchUnit.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [DispatchUnit] and returns the resulting row.
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
  /// The returned [DispatchUnit] will have its `id` field set.
  Future<DispatchUnit?> upsertRow(
    _is.DatabaseSession session,
    DispatchUnit row, {
    required _is.ColumnSelections<DispatchUnitTable> conflictColumns,
    _is.ColumnSelections<DispatchUnitTable>? updateColumns,
    _is.WhereExpressionBuilder<DispatchUnitTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<DispatchUnit>(
      row,
      conflictColumns: conflictColumns(DispatchUnit.t),
      updateColumns: updateColumns?.call(DispatchUnit.t),
      updateWhere: updateWhere?.call(DispatchUnit.t),
      transaction: transaction,
    );
  }

  /// Updates all [DispatchUnit]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DispatchUnit>> update(
    _is.DatabaseSession session,
    List<DispatchUnit> rows, {
    _is.ColumnSelections<DispatchUnitTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<DispatchUnit>(
      rows,
      columns: columns?.call(DispatchUnit.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [DispatchUnit]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DispatchUnit> updateRow(
    _is.DatabaseSession session,
    DispatchUnit row, {
    _is.ColumnSelections<DispatchUnitTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<DispatchUnit>(
      row,
      columns: columns?.call(DispatchUnit.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DispatchUnit] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DispatchUnit?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<DispatchUnitUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<DispatchUnit>(
      id,
      columnValues: columnValues(DispatchUnit.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DispatchUnit]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DispatchUnit>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<DispatchUnitUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<DispatchUnitTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DispatchUnitTable>? orderBy,
    _is.OrderByListBuilder<DispatchUnitTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<DispatchUnit>(
      columnValues: columnValues(DispatchUnit.t.updateTable),
      where: where(DispatchUnit.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DispatchUnit.t),
      orderByList: orderByList?.call(DispatchUnit.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [DispatchUnit]s in the list and returns the deleted rows.
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
  Future<List<DispatchUnit>> delete(
    _is.DatabaseSession session,
    List<DispatchUnit> rows, {
    _is.OrderByBuilder<DispatchUnitTable>? orderBy,
    _is.OrderByListBuilder<DispatchUnitTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<DispatchUnit>(
      rows,
      orderBy: orderBy?.call(DispatchUnit.t),
      orderByList: orderByList?.call(DispatchUnit.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [DispatchUnit].
  Future<DispatchUnit> deleteRow(
    _is.DatabaseSession session,
    DispatchUnit row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DispatchUnit>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DispatchUnit>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DispatchUnitTable> where,
    _is.OrderByBuilder<DispatchUnitTable>? orderBy,
    _is.OrderByListBuilder<DispatchUnitTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<DispatchUnit>(
      where: where(DispatchUnit.t),
      orderBy: orderBy?.call(DispatchUnit.t),
      orderByList: orderByList?.call(DispatchUnit.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DispatchUnitTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<DispatchUnit>(
      where: where?.call(DispatchUnit.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DispatchUnit] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DispatchUnitTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DispatchUnit>(
      where: where(DispatchUnit.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
