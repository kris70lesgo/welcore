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

abstract class DispatchIncident
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  DispatchIncident._({
    this.id,
    this.reporterAccountId,
    this.destinationHospitalId,
    this.destinationHospitalName,
    required this.workspaceId,
    required this.description,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.severity,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.assignedUnitId,
    this.assignedCallSign,
    this.dispatchDistanceKm,
    this.dispatchedAt,
    this.onSceneAt,
    this.resolvedAt,
  });

  factory DispatchIncident({
    int? id,
    int? reporterAccountId,
    int? destinationHospitalId,
    String? destinationHospitalName,
    required int workspaceId,
    required String description,
    required String address,
    required double latitude,
    required double longitude,
    required String severity,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
    int? assignedUnitId,
    String? assignedCallSign,
    double? dispatchDistanceKm,
    DateTime? dispatchedAt,
    DateTime? onSceneAt,
    DateTime? resolvedAt,
  }) = _DispatchIncidentImpl;

  factory DispatchIncident.fromJson(Map<String, dynamic> jsonSerialization) {
    return DispatchIncident(
      id: jsonSerialization['id'] as int?,
      reporterAccountId: jsonSerialization['reporterAccountId'] as int?,
      destinationHospitalId: jsonSerialization['destinationHospitalId'] as int?,
      destinationHospitalName:
          jsonSerialization['destinationHospitalName'] as String?,
      workspaceId: jsonSerialization['workspaceId'] as int,
      description: jsonSerialization['description'] as String,
      address: jsonSerialization['address'] as String,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      severity: jsonSerialization['severity'] as String,
      status: jsonSerialization['status'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
      assignedUnitId: jsonSerialization['assignedUnitId'] as int?,
      assignedCallSign: jsonSerialization['assignedCallSign'] as String?,
      dispatchDistanceKm: (jsonSerialization['dispatchDistanceKm'] as num?)
          ?.toDouble(),
      dispatchedAt: jsonSerialization['dispatchedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['dispatchedAt'],
            ),
      onSceneAt: jsonSerialization['onSceneAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['onSceneAt']),
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['resolvedAt']),
    );
  }

  static final t = DispatchIncidentTable();

  static const db = DispatchIncidentRepository._();

  @override
  int? id;

  int? reporterAccountId;

  int? destinationHospitalId;

  String? destinationHospitalName;

  int workspaceId;

  String description;

  String address;

  double latitude;

  double longitude;

  String severity;

  String status;

  DateTime createdAt;

  DateTime updatedAt;

  int? assignedUnitId;

  String? assignedCallSign;

  double? dispatchDistanceKm;

  DateTime? dispatchedAt;

  DateTime? onSceneAt;

  DateTime? resolvedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [DispatchIncident]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DispatchIncident copyWith({
    int? id,
    int? reporterAccountId,
    int? destinationHospitalId,
    String? destinationHospitalName,
    int? workspaceId,
    String? description,
    String? address,
    double? latitude,
    double? longitude,
    String? severity,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? assignedUnitId,
    String? assignedCallSign,
    double? dispatchDistanceKm,
    DateTime? dispatchedAt,
    DateTime? onSceneAt,
    DateTime? resolvedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DispatchIncident',
      if (id != null) 'id': id,
      if (reporterAccountId != null) 'reporterAccountId': reporterAccountId,
      if (destinationHospitalId != null)
        'destinationHospitalId': destinationHospitalId,
      if (destinationHospitalName != null)
        'destinationHospitalName': destinationHospitalName,
      'workspaceId': workspaceId,
      'description': description,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'severity': severity,
      'status': status,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (assignedUnitId != null) 'assignedUnitId': assignedUnitId,
      if (assignedCallSign != null) 'assignedCallSign': assignedCallSign,
      if (dispatchDistanceKm != null) 'dispatchDistanceKm': dispatchDistanceKm,
      if (dispatchedAt != null) 'dispatchedAt': dispatchedAt?.toJson(),
      if (onSceneAt != null) 'onSceneAt': onSceneAt?.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DispatchIncident',
      if (id != null) 'id': id,
      if (reporterAccountId != null) 'reporterAccountId': reporterAccountId,
      if (destinationHospitalId != null)
        'destinationHospitalId': destinationHospitalId,
      if (destinationHospitalName != null)
        'destinationHospitalName': destinationHospitalName,
      'workspaceId': workspaceId,
      'description': description,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'severity': severity,
      'status': status,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (assignedUnitId != null) 'assignedUnitId': assignedUnitId,
      if (assignedCallSign != null) 'assignedCallSign': assignedCallSign,
      if (dispatchDistanceKm != null) 'dispatchDistanceKm': dispatchDistanceKm,
      if (dispatchedAt != null) 'dispatchedAt': dispatchedAt?.toJson(),
      if (onSceneAt != null) 'onSceneAt': onSceneAt?.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
    };
  }

  static DispatchIncidentInclude include() {
    return DispatchIncidentInclude._();
  }

  static DispatchIncidentIncludeList includeList({
    _is.WhereExpressionBuilder<DispatchIncidentTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DispatchIncidentTable>? orderBy,
    _is.OrderByListBuilder<DispatchIncidentTable>? orderByList,
    DispatchIncidentInclude? include,
  }) {
    return DispatchIncidentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DispatchIncident.t),
      orderByList: orderByList?.call(DispatchIncident.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DispatchIncidentImpl extends DispatchIncident {
  _DispatchIncidentImpl({
    int? id,
    int? reporterAccountId,
    int? destinationHospitalId,
    String? destinationHospitalName,
    required int workspaceId,
    required String description,
    required String address,
    required double latitude,
    required double longitude,
    required String severity,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
    int? assignedUnitId,
    String? assignedCallSign,
    double? dispatchDistanceKm,
    DateTime? dispatchedAt,
    DateTime? onSceneAt,
    DateTime? resolvedAt,
  }) : super._(
         id: id,
         reporterAccountId: reporterAccountId,
         destinationHospitalId: destinationHospitalId,
         destinationHospitalName: destinationHospitalName,
         workspaceId: workspaceId,
         description: description,
         address: address,
         latitude: latitude,
         longitude: longitude,
         severity: severity,
         status: status,
         createdAt: createdAt,
         updatedAt: updatedAt,
         assignedUnitId: assignedUnitId,
         assignedCallSign: assignedCallSign,
         dispatchDistanceKm: dispatchDistanceKm,
         dispatchedAt: dispatchedAt,
         onSceneAt: onSceneAt,
         resolvedAt: resolvedAt,
       );

  /// Returns a shallow copy of this [DispatchIncident]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DispatchIncident copyWith({
    Object? id = _Undefined,
    Object? reporterAccountId = _Undefined,
    Object? destinationHospitalId = _Undefined,
    Object? destinationHospitalName = _Undefined,
    int? workspaceId,
    String? description,
    String? address,
    double? latitude,
    double? longitude,
    String? severity,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? assignedUnitId = _Undefined,
    Object? assignedCallSign = _Undefined,
    Object? dispatchDistanceKm = _Undefined,
    Object? dispatchedAt = _Undefined,
    Object? onSceneAt = _Undefined,
    Object? resolvedAt = _Undefined,
  }) {
    return DispatchIncident(
      id: id is int? ? id : this.id,
      reporterAccountId: reporterAccountId is int?
          ? reporterAccountId
          : this.reporterAccountId,
      destinationHospitalId: destinationHospitalId is int?
          ? destinationHospitalId
          : this.destinationHospitalId,
      destinationHospitalName: destinationHospitalName is String?
          ? destinationHospitalName
          : this.destinationHospitalName,
      workspaceId: workspaceId ?? this.workspaceId,
      description: description ?? this.description,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      severity: severity ?? this.severity,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      assignedUnitId: assignedUnitId is int?
          ? assignedUnitId
          : this.assignedUnitId,
      assignedCallSign: assignedCallSign is String?
          ? assignedCallSign
          : this.assignedCallSign,
      dispatchDistanceKm: dispatchDistanceKm is double?
          ? dispatchDistanceKm
          : this.dispatchDistanceKm,
      dispatchedAt: dispatchedAt is DateTime?
          ? dispatchedAt
          : this.dispatchedAt,
      onSceneAt: onSceneAt is DateTime? ? onSceneAt : this.onSceneAt,
      resolvedAt: resolvedAt is DateTime? ? resolvedAt : this.resolvedAt,
    );
  }
}

class DispatchIncidentUpdateTable
    extends _is.UpdateTable<DispatchIncidentTable> {
  DispatchIncidentUpdateTable(super.table);

  _is.ColumnValue<int, int> reporterAccountId(int? value) =>
      _is.ColumnValue(table.reporterAccountId, value);

  _is.ColumnValue<int, int> destinationHospitalId(int? value) =>
      _is.ColumnValue(table.destinationHospitalId, value);

  _is.ColumnValue<String, String> destinationHospitalName(String? value) =>
      _is.ColumnValue(table.destinationHospitalName, value);

  _is.ColumnValue<int, int> workspaceId(int value) =>
      _is.ColumnValue(table.workspaceId, value);

  _is.ColumnValue<String, String> description(String value) =>
      _is.ColumnValue(table.description, value);

  _is.ColumnValue<String, String> address(String value) =>
      _is.ColumnValue(table.address, value);

  _is.ColumnValue<double, double> latitude(double value) =>
      _is.ColumnValue(table.latitude, value);

  _is.ColumnValue<double, double> longitude(double value) =>
      _is.ColumnValue(table.longitude, value);

  _is.ColumnValue<String, String> severity(String value) =>
      _is.ColumnValue(table.severity, value);

  _is.ColumnValue<String, String> status(String value) =>
      _is.ColumnValue(table.status, value);

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(table.createdAt, value);

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(table.updatedAt, value);

  _is.ColumnValue<int, int> assignedUnitId(int? value) =>
      _is.ColumnValue(table.assignedUnitId, value);

  _is.ColumnValue<String, String> assignedCallSign(String? value) =>
      _is.ColumnValue(table.assignedCallSign, value);

  _is.ColumnValue<double, double> dispatchDistanceKm(double? value) =>
      _is.ColumnValue(table.dispatchDistanceKm, value);

  _is.ColumnValue<DateTime, DateTime> dispatchedAt(DateTime? value) =>
      _is.ColumnValue(table.dispatchedAt, value);

  _is.ColumnValue<DateTime, DateTime> onSceneAt(DateTime? value) =>
      _is.ColumnValue(table.onSceneAt, value);

  _is.ColumnValue<DateTime, DateTime> resolvedAt(DateTime? value) =>
      _is.ColumnValue(table.resolvedAt, value);
}

class DispatchIncidentTable extends _is.Table<int?> {
  DispatchIncidentTable({super.tableRelation})
    : super(tableName: 'dispatch_incident') {
    updateTable = DispatchIncidentUpdateTable(this);
    reporterAccountId = _is.ColumnInt('reporterAccountId', this);
    destinationHospitalId = _is.ColumnInt('destinationHospitalId', this);
    destinationHospitalName = _is.ColumnString('destinationHospitalName', this);
    workspaceId = _is.ColumnInt('workspaceId', this);
    description = _is.ColumnString('description', this);
    address = _is.ColumnString('address', this);
    latitude = _is.ColumnDouble('latitude', this);
    longitude = _is.ColumnDouble('longitude', this);
    severity = _is.ColumnString('severity', this);
    status = _is.ColumnString('status', this);
    createdAt = _is.ColumnDateTime('createdAt', this);
    updatedAt = _is.ColumnDateTime('updatedAt', this);
    assignedUnitId = _is.ColumnInt('assignedUnitId', this);
    assignedCallSign = _is.ColumnString('assignedCallSign', this);
    dispatchDistanceKm = _is.ColumnDouble('dispatchDistanceKm', this);
    dispatchedAt = _is.ColumnDateTime('dispatchedAt', this);
    onSceneAt = _is.ColumnDateTime('onSceneAt', this);
    resolvedAt = _is.ColumnDateTime('resolvedAt', this);
  }

  late final DispatchIncidentUpdateTable updateTable;

  late final _is.ColumnInt reporterAccountId;

  late final _is.ColumnInt destinationHospitalId;

  late final _is.ColumnString destinationHospitalName;

  late final _is.ColumnInt workspaceId;

  late final _is.ColumnString description;

  late final _is.ColumnString address;

  late final _is.ColumnDouble latitude;

  late final _is.ColumnDouble longitude;

  late final _is.ColumnString severity;

  late final _is.ColumnString status;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  late final _is.ColumnInt assignedUnitId;

  late final _is.ColumnString assignedCallSign;

  late final _is.ColumnDouble dispatchDistanceKm;

  late final _is.ColumnDateTime dispatchedAt;

  late final _is.ColumnDateTime onSceneAt;

  late final _is.ColumnDateTime resolvedAt;

  @override
  List<_is.Column> get columns => [
    id,
    reporterAccountId,
    destinationHospitalId,
    destinationHospitalName,
    workspaceId,
    description,
    address,
    latitude,
    longitude,
    severity,
    status,
    createdAt,
    updatedAt,
    assignedUnitId,
    assignedCallSign,
    dispatchDistanceKm,
    dispatchedAt,
    onSceneAt,
    resolvedAt,
  ];
}

class DispatchIncidentInclude extends _is.IncludeObject {
  DispatchIncidentInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => DispatchIncident.t;
}

class DispatchIncidentIncludeList extends _is.IncludeList {
  DispatchIncidentIncludeList._({
    _is.WhereExpressionBuilder<DispatchIncidentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DispatchIncident.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => DispatchIncident.t;
}

class DispatchIncidentRepository {
  const DispatchIncidentRepository._();

  /// Returns a list of [DispatchIncident]s matching the given query parameters.
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
  Future<List<DispatchIncident>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DispatchIncidentTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DispatchIncidentTable>? orderBy,
    _is.OrderByListBuilder<DispatchIncidentTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DispatchIncident>(
      where: where?.call(DispatchIncident.t),
      orderBy: orderBy?.call(DispatchIncident.t),
      orderByList: orderByList?.call(DispatchIncident.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DispatchIncident] matching the given query parameters.
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
  Future<DispatchIncident?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DispatchIncidentTable>? where,
    int? offset,
    _is.OrderByBuilder<DispatchIncidentTable>? orderBy,
    _is.OrderByListBuilder<DispatchIncidentTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DispatchIncident>(
      where: where?.call(DispatchIncident.t),
      orderBy: orderBy?.call(DispatchIncident.t),
      orderByList: orderByList?.call(DispatchIncident.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DispatchIncident] by its [id] or null if no such row exists.
  Future<DispatchIncident?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DispatchIncident>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DispatchIncident]s in the list and returns the inserted rows.
  ///
  /// The returned [DispatchIncident]s will have their `id` fields set.
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
  Future<List<DispatchIncident>> insert(
    _is.DatabaseSession session,
    List<DispatchIncident> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<DispatchIncident>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [DispatchIncident] and returns the inserted row.
  ///
  /// The returned [DispatchIncident] will have its `id` field set.
  Future<DispatchIncident> insertRow(
    _is.DatabaseSession session,
    DispatchIncident row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<DispatchIncident>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [DispatchIncident]s in the list and returns the resulting rows.
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
  /// The returned [DispatchIncident]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DispatchIncident>> upsert(
    _is.DatabaseSession session,
    List<DispatchIncident> rows, {
    required _is.ColumnSelections<DispatchIncidentTable> conflictColumns,
    _is.ColumnSelections<DispatchIncidentTable>? updateColumns,
    _is.WhereExpressionBuilder<DispatchIncidentTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<DispatchIncident>(
      rows,
      conflictColumns: conflictColumns(DispatchIncident.t),
      updateColumns: updateColumns?.call(DispatchIncident.t),
      updateWhere: updateWhere?.call(DispatchIncident.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [DispatchIncident] and returns the resulting row.
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
  /// The returned [DispatchIncident] will have its `id` field set.
  Future<DispatchIncident?> upsertRow(
    _is.DatabaseSession session,
    DispatchIncident row, {
    required _is.ColumnSelections<DispatchIncidentTable> conflictColumns,
    _is.ColumnSelections<DispatchIncidentTable>? updateColumns,
    _is.WhereExpressionBuilder<DispatchIncidentTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<DispatchIncident>(
      row,
      conflictColumns: conflictColumns(DispatchIncident.t),
      updateColumns: updateColumns?.call(DispatchIncident.t),
      updateWhere: updateWhere?.call(DispatchIncident.t),
      transaction: transaction,
    );
  }

  /// Updates all [DispatchIncident]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DispatchIncident>> update(
    _is.DatabaseSession session,
    List<DispatchIncident> rows, {
    _is.ColumnSelections<DispatchIncidentTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<DispatchIncident>(
      rows,
      columns: columns?.call(DispatchIncident.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [DispatchIncident]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DispatchIncident> updateRow(
    _is.DatabaseSession session,
    DispatchIncident row, {
    _is.ColumnSelections<DispatchIncidentTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<DispatchIncident>(
      row,
      columns: columns?.call(DispatchIncident.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DispatchIncident] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DispatchIncident?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<DispatchIncidentUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<DispatchIncident>(
      id,
      columnValues: columnValues(DispatchIncident.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DispatchIncident]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DispatchIncident>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<DispatchIncidentUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<DispatchIncidentTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DispatchIncidentTable>? orderBy,
    _is.OrderByListBuilder<DispatchIncidentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<DispatchIncident>(
      columnValues: columnValues(DispatchIncident.t.updateTable),
      where: where(DispatchIncident.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DispatchIncident.t),
      orderByList: orderByList?.call(DispatchIncident.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [DispatchIncident]s in the list and returns the deleted rows.
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
  Future<List<DispatchIncident>> delete(
    _is.DatabaseSession session,
    List<DispatchIncident> rows, {
    _is.OrderByBuilder<DispatchIncidentTable>? orderBy,
    _is.OrderByListBuilder<DispatchIncidentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<DispatchIncident>(
      rows,
      orderBy: orderBy?.call(DispatchIncident.t),
      orderByList: orderByList?.call(DispatchIncident.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [DispatchIncident].
  Future<DispatchIncident> deleteRow(
    _is.DatabaseSession session,
    DispatchIncident row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DispatchIncident>(
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
  Future<List<DispatchIncident>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DispatchIncidentTable> where,
    _is.OrderByBuilder<DispatchIncidentTable>? orderBy,
    _is.OrderByListBuilder<DispatchIncidentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<DispatchIncident>(
      where: where(DispatchIncident.t),
      orderBy: orderBy?.call(DispatchIncident.t),
      orderByList: orderByList?.call(DispatchIncident.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DispatchIncidentTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<DispatchIncident>(
      where: where?.call(DispatchIncident.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DispatchIncident] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DispatchIncidentTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DispatchIncident>(
      where: where(DispatchIncident.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
