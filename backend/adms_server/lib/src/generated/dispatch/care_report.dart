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

abstract class CareReport
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  CareReport._({
    this.id,
    required this.workspaceId,
    required this.incidentId,
    required this.patientName,
    this.age,
    required this.condition,
    this.pulse,
    this.systolic,
    this.diastolic,
    this.oxygenSaturation,
    required this.treatment,
    required this.notes,
    required this.handedOverTo,
    required this.signedOff,
    required this.updatedAt,
  });

  factory CareReport({
    int? id,
    required int workspaceId,
    required int incidentId,
    required String patientName,
    int? age,
    required String condition,
    int? pulse,
    int? systolic,
    int? diastolic,
    int? oxygenSaturation,
    required String treatment,
    required String notes,
    required String handedOverTo,
    required bool signedOff,
    required DateTime updatedAt,
  }) = _CareReportImpl;

  factory CareReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return CareReport(
      id: jsonSerialization['id'] as int?,
      workspaceId: jsonSerialization['workspaceId'] as int,
      incidentId: jsonSerialization['incidentId'] as int,
      patientName: jsonSerialization['patientName'] as String,
      age: jsonSerialization['age'] as int?,
      condition: jsonSerialization['condition'] as String,
      pulse: jsonSerialization['pulse'] as int?,
      systolic: jsonSerialization['systolic'] as int?,
      diastolic: jsonSerialization['diastolic'] as int?,
      oxygenSaturation: jsonSerialization['oxygenSaturation'] as int?,
      treatment: jsonSerialization['treatment'] as String,
      notes: jsonSerialization['notes'] as String,
      handedOverTo: jsonSerialization['handedOverTo'] as String,
      signedOff: _is.BoolJsonExtension.fromJson(jsonSerialization['signedOff']),
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = CareReportTable();

  static const db = CareReportRepository._();

  @override
  int? id;

  int workspaceId;

  int incidentId;

  String patientName;

  int? age;

  String condition;

  int? pulse;

  int? systolic;

  int? diastolic;

  int? oxygenSaturation;

  String treatment;

  String notes;

  String handedOverTo;

  bool signedOff;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CareReport]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CareReport copyWith({
    int? id,
    int? workspaceId,
    int? incidentId,
    String? patientName,
    int? age,
    String? condition,
    int? pulse,
    int? systolic,
    int? diastolic,
    int? oxygenSaturation,
    String? treatment,
    String? notes,
    String? handedOverTo,
    bool? signedOff,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CareReport',
      if (id != null) 'id': id,
      'workspaceId': workspaceId,
      'incidentId': incidentId,
      'patientName': patientName,
      if (age != null) 'age': age,
      'condition': condition,
      if (pulse != null) 'pulse': pulse,
      if (systolic != null) 'systolic': systolic,
      if (diastolic != null) 'diastolic': diastolic,
      if (oxygenSaturation != null) 'oxygenSaturation': oxygenSaturation,
      'treatment': treatment,
      'notes': notes,
      'handedOverTo': handedOverTo,
      'signedOff': signedOff,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CareReport',
      if (id != null) 'id': id,
      'workspaceId': workspaceId,
      'incidentId': incidentId,
      'patientName': patientName,
      if (age != null) 'age': age,
      'condition': condition,
      if (pulse != null) 'pulse': pulse,
      if (systolic != null) 'systolic': systolic,
      if (diastolic != null) 'diastolic': diastolic,
      if (oxygenSaturation != null) 'oxygenSaturation': oxygenSaturation,
      'treatment': treatment,
      'notes': notes,
      'handedOverTo': handedOverTo,
      'signedOff': signedOff,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static CareReportInclude include() {
    return CareReportInclude._();
  }

  static CareReportIncludeList includeList({
    _is.WhereExpressionBuilder<CareReportTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CareReportTable>? orderBy,
    _is.OrderByListBuilder<CareReportTable>? orderByList,
    CareReportInclude? include,
  }) {
    return CareReportIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CareReport.t),
      orderByList: orderByList?.call(CareReport.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CareReportImpl extends CareReport {
  _CareReportImpl({
    int? id,
    required int workspaceId,
    required int incidentId,
    required String patientName,
    int? age,
    required String condition,
    int? pulse,
    int? systolic,
    int? diastolic,
    int? oxygenSaturation,
    required String treatment,
    required String notes,
    required String handedOverTo,
    required bool signedOff,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         workspaceId: workspaceId,
         incidentId: incidentId,
         patientName: patientName,
         age: age,
         condition: condition,
         pulse: pulse,
         systolic: systolic,
         diastolic: diastolic,
         oxygenSaturation: oxygenSaturation,
         treatment: treatment,
         notes: notes,
         handedOverTo: handedOverTo,
         signedOff: signedOff,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [CareReport]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CareReport copyWith({
    Object? id = _Undefined,
    int? workspaceId,
    int? incidentId,
    String? patientName,
    Object? age = _Undefined,
    String? condition,
    Object? pulse = _Undefined,
    Object? systolic = _Undefined,
    Object? diastolic = _Undefined,
    Object? oxygenSaturation = _Undefined,
    String? treatment,
    String? notes,
    String? handedOverTo,
    bool? signedOff,
    DateTime? updatedAt,
  }) {
    return CareReport(
      id: id is int? ? id : this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      incidentId: incidentId ?? this.incidentId,
      patientName: patientName ?? this.patientName,
      age: age is int? ? age : this.age,
      condition: condition ?? this.condition,
      pulse: pulse is int? ? pulse : this.pulse,
      systolic: systolic is int? ? systolic : this.systolic,
      diastolic: diastolic is int? ? diastolic : this.diastolic,
      oxygenSaturation: oxygenSaturation is int?
          ? oxygenSaturation
          : this.oxygenSaturation,
      treatment: treatment ?? this.treatment,
      notes: notes ?? this.notes,
      handedOverTo: handedOverTo ?? this.handedOverTo,
      signedOff: signedOff ?? this.signedOff,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class CareReportUpdateTable extends _is.UpdateTable<CareReportTable> {
  CareReportUpdateTable(super.table);

  _is.ColumnValue<int, int> workspaceId(int value) =>
      _is.ColumnValue(table.workspaceId, value);

  _is.ColumnValue<int, int> incidentId(int value) =>
      _is.ColumnValue(table.incidentId, value);

  _is.ColumnValue<String, String> patientName(String value) =>
      _is.ColumnValue(table.patientName, value);

  _is.ColumnValue<int, int> age(int? value) =>
      _is.ColumnValue(table.age, value);

  _is.ColumnValue<String, String> condition(String value) =>
      _is.ColumnValue(table.condition, value);

  _is.ColumnValue<int, int> pulse(int? value) =>
      _is.ColumnValue(table.pulse, value);

  _is.ColumnValue<int, int> systolic(int? value) =>
      _is.ColumnValue(table.systolic, value);

  _is.ColumnValue<int, int> diastolic(int? value) =>
      _is.ColumnValue(table.diastolic, value);

  _is.ColumnValue<int, int> oxygenSaturation(int? value) =>
      _is.ColumnValue(table.oxygenSaturation, value);

  _is.ColumnValue<String, String> treatment(String value) =>
      _is.ColumnValue(table.treatment, value);

  _is.ColumnValue<String, String> notes(String value) =>
      _is.ColumnValue(table.notes, value);

  _is.ColumnValue<String, String> handedOverTo(String value) =>
      _is.ColumnValue(table.handedOverTo, value);

  _is.ColumnValue<bool, bool> signedOff(bool value) =>
      _is.ColumnValue(table.signedOff, value);

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(table.updatedAt, value);
}

class CareReportTable extends _is.Table<int?> {
  CareReportTable({super.tableRelation})
    : super(tableName: 'dispatch_care_report') {
    updateTable = CareReportUpdateTable(this);
    workspaceId = _is.ColumnInt('workspaceId', this);
    incidentId = _is.ColumnInt('incidentId', this);
    patientName = _is.ColumnString('patientName', this);
    age = _is.ColumnInt('age', this);
    condition = _is.ColumnString('condition', this);
    pulse = _is.ColumnInt('pulse', this);
    systolic = _is.ColumnInt('systolic', this);
    diastolic = _is.ColumnInt('diastolic', this);
    oxygenSaturation = _is.ColumnInt('oxygenSaturation', this);
    treatment = _is.ColumnString('treatment', this);
    notes = _is.ColumnString('notes', this);
    handedOverTo = _is.ColumnString('handedOverTo', this);
    signedOff = _is.ColumnBool('signedOff', this);
    updatedAt = _is.ColumnDateTime('updatedAt', this);
  }

  late final CareReportUpdateTable updateTable;

  late final _is.ColumnInt workspaceId;

  late final _is.ColumnInt incidentId;

  late final _is.ColumnString patientName;

  late final _is.ColumnInt age;

  late final _is.ColumnString condition;

  late final _is.ColumnInt pulse;

  late final _is.ColumnInt systolic;

  late final _is.ColumnInt diastolic;

  late final _is.ColumnInt oxygenSaturation;

  late final _is.ColumnString treatment;

  late final _is.ColumnString notes;

  late final _is.ColumnString handedOverTo;

  late final _is.ColumnBool signedOff;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    workspaceId,
    incidentId,
    patientName,
    age,
    condition,
    pulse,
    systolic,
    diastolic,
    oxygenSaturation,
    treatment,
    notes,
    handedOverTo,
    signedOff,
    updatedAt,
  ];
}

class CareReportInclude extends _is.IncludeObject {
  CareReportInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => CareReport.t;
}

class CareReportIncludeList extends _is.IncludeList {
  CareReportIncludeList._({
    _is.WhereExpressionBuilder<CareReportTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CareReport.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CareReport.t;
}

class CareReportRepository {
  const CareReportRepository._();

  /// Returns a list of [CareReport]s matching the given query parameters.
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
  Future<List<CareReport>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CareReportTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CareReportTable>? orderBy,
    _is.OrderByListBuilder<CareReportTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CareReport>(
      where: where?.call(CareReport.t),
      orderBy: orderBy?.call(CareReport.t),
      orderByList: orderByList?.call(CareReport.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CareReport] matching the given query parameters.
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
  Future<CareReport?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CareReportTable>? where,
    int? offset,
    _is.OrderByBuilder<CareReportTable>? orderBy,
    _is.OrderByListBuilder<CareReportTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CareReport>(
      where: where?.call(CareReport.t),
      orderBy: orderBy?.call(CareReport.t),
      orderByList: orderByList?.call(CareReport.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CareReport] by its [id] or null if no such row exists.
  Future<CareReport?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CareReport>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CareReport]s in the list and returns the inserted rows.
  ///
  /// The returned [CareReport]s will have their `id` fields set.
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
  Future<List<CareReport>> insert(
    _is.DatabaseSession session,
    List<CareReport> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CareReport>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CareReport] and returns the inserted row.
  ///
  /// The returned [CareReport] will have its `id` field set.
  Future<CareReport> insertRow(
    _is.DatabaseSession session,
    CareReport row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CareReport>(row, transaction: transaction);
  }

  /// Upserts all [CareReport]s in the list and returns the resulting rows.
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
  /// The returned [CareReport]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CareReport>> upsert(
    _is.DatabaseSession session,
    List<CareReport> rows, {
    required _is.ColumnSelections<CareReportTable> conflictColumns,
    _is.ColumnSelections<CareReportTable>? updateColumns,
    _is.WhereExpressionBuilder<CareReportTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CareReport>(
      rows,
      conflictColumns: conflictColumns(CareReport.t),
      updateColumns: updateColumns?.call(CareReport.t),
      updateWhere: updateWhere?.call(CareReport.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CareReport] and returns the resulting row.
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
  /// The returned [CareReport] will have its `id` field set.
  Future<CareReport?> upsertRow(
    _is.DatabaseSession session,
    CareReport row, {
    required _is.ColumnSelections<CareReportTable> conflictColumns,
    _is.ColumnSelections<CareReportTable>? updateColumns,
    _is.WhereExpressionBuilder<CareReportTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CareReport>(
      row,
      conflictColumns: conflictColumns(CareReport.t),
      updateColumns: updateColumns?.call(CareReport.t),
      updateWhere: updateWhere?.call(CareReport.t),
      transaction: transaction,
    );
  }

  /// Updates all [CareReport]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CareReport>> update(
    _is.DatabaseSession session,
    List<CareReport> rows, {
    _is.ColumnSelections<CareReportTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CareReport>(
      rows,
      columns: columns?.call(CareReport.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CareReport]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CareReport> updateRow(
    _is.DatabaseSession session,
    CareReport row, {
    _is.ColumnSelections<CareReportTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CareReport>(
      row,
      columns: columns?.call(CareReport.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CareReport] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CareReport?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CareReportUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CareReport>(
      id,
      columnValues: columnValues(CareReport.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CareReport]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CareReport>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CareReportUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<CareReportTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CareReportTable>? orderBy,
    _is.OrderByListBuilder<CareReportTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CareReport>(
      columnValues: columnValues(CareReport.t.updateTable),
      where: where(CareReport.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CareReport.t),
      orderByList: orderByList?.call(CareReport.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CareReport]s in the list and returns the deleted rows.
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
  Future<List<CareReport>> delete(
    _is.DatabaseSession session,
    List<CareReport> rows, {
    _is.OrderByBuilder<CareReportTable>? orderBy,
    _is.OrderByListBuilder<CareReportTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CareReport>(
      rows,
      orderBy: orderBy?.call(CareReport.t),
      orderByList: orderByList?.call(CareReport.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CareReport].
  Future<CareReport> deleteRow(
    _is.DatabaseSession session,
    CareReport row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CareReport>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CareReport>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CareReportTable> where,
    _is.OrderByBuilder<CareReportTable>? orderBy,
    _is.OrderByListBuilder<CareReportTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CareReport>(
      where: where(CareReport.t),
      orderBy: orderBy?.call(CareReport.t),
      orderByList: orderByList?.call(CareReport.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CareReportTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CareReport>(
      where: where?.call(CareReport.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CareReport] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CareReportTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CareReport>(
      where: where(CareReport.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
