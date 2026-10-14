/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'dispatch/auth_access.dart' as _i8nqich0;
import 'dispatch/care_report.dart' as _ioq64fq7;
import 'dispatch/demo_access.dart' as _ibw91gj7;
import 'dispatch/dispatch_event.dart' as _i3il5by7;
import 'dispatch/dispatch_exception.dart' as _ianatnwr;
import 'dispatch/dispatch_incident.dart' as _ij4w9jgx;
import 'dispatch/dispatch_session.dart' as _isj5369a;
import 'dispatch/dispatch_snapshot.dart' as _iua6f297;
import 'dispatch/dispatch_unit.dart' as _iyuv25k5;
import 'dispatch/hospital.dart' as _i10k8j4y;
import 'dispatch/invite_access.dart' as _i1mq8ass;
import 'dispatch/maintenance_job.dart' as _iwc209pn;
import 'dispatch/staff_account.dart' as _i1okvm19;
import 'dispatch/staff_invite.dart' as _i6rbwel4;
import 'dispatch/staff_profile.dart' as _inpgeoak;
import 'dispatch/staff_session.dart' as _ipy0xdiy;
import 'dispatch/workspace_config.dart' as _i7a46nnq;
export 'dispatch/auth_access.dart';
export 'dispatch/care_report.dart';
export 'dispatch/demo_access.dart';
export 'dispatch/dispatch_event.dart';
export 'dispatch/dispatch_exception.dart';
export 'dispatch/dispatch_incident.dart';
export 'dispatch/dispatch_session.dart';
export 'dispatch/dispatch_snapshot.dart';
export 'dispatch/dispatch_unit.dart';
export 'dispatch/hospital.dart';
export 'dispatch/invite_access.dart';
export 'dispatch/maintenance_job.dart';
export 'dispatch/staff_account.dart';
export 'dispatch/staff_invite.dart';
export 'dispatch/staff_profile.dart';
export 'dispatch/staff_session.dart';
export 'dispatch/workspace_config.dart';

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'dispatch_care_report',
      dartName: 'CareReport',
      schema: 'public',
      module: 'adms',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'workspaceId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'incidentId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'patientName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'age',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'condition',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'pulse',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'systolic',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'diastolic',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'oxygenSaturation',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'treatment',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'notes',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'handedOverTo',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'signedOff',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'dispatch_care_report_incidentid_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'incidentId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'dispatch_event',
      dartName: 'DispatchEvent',
      schema: 'public',
      module: 'adms',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'workspaceId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'incidentId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'message',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'dispatch_event_workspace_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'workspaceId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'dispatch_hospital',
      dartName: 'Hospital',
      schema: 'public',
      module: 'adms',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'workspaceId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'address',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'phone',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'latitude',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'longitude',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'active',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'dispatch_incident',
      dartName: 'DispatchIncident',
      schema: 'public',
      module: 'adms',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'reporterAccountId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'destinationHospitalId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'destinationHospitalName',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'workspaceId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'address',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'latitude',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'longitude',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'severity',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'assignedUnitId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'assignedCallSign',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'dispatchDistanceKm',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _isp.ColumnDefinition(
          name: 'dispatchedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'onSceneAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'resolvedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'dispatch_incident_workspace_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'workspaceId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'dispatch_maintenance',
      dartName: 'MaintenanceJob',
      schema: 'public',
      module: 'adms',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'workspaceId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'unitId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'notes',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'dueAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'cost',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'dispatch_session',
      dartName: 'DispatchSession',
      schema: 'public',
      module: 'adms',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'Manila operations\'',
        ),
        _isp.ColumnDefinition(
          name: 'isDemo',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _isp.ColumnDefinition(
          name: 'autoDispatch',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'responseTargetMinutes',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '10',
        ),
        _isp.ColumnDefinition(
          name: 'tokenHash',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'revision',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'expiresAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'dispatch_session_token_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'tokenHash',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'dispatch_unit',
      dartName: 'DispatchUnit',
      schema: 'public',
      module: 'adms',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'plateNumber',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'unitType',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'active',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _isp.ColumnDefinition(
          name: 'locationUpdatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'workspaceId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'callSign',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'crew',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'latitude',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'longitude',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'dispatch_unit_workspace_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'workspaceId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'staff_account',
      dartName: 'StaffAccount',
      schema: 'public',
      module: 'adms',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'workspaceId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'email',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'role',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'passwordSalt',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'passwordHash',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'active',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'assignedUnitId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'staff_account_email_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'email',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'staff_invite',
      dartName: 'StaffInvite',
      schema: 'public',
      module: 'adms',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'workspaceId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'tokenHash',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'email',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'role',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'assignedUnitId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'recoveryAccountId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'expiresAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'usedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'staff_invite_tokenhash_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'tokenHash',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'staff_session',
      dartName: 'StaffSession',
      schema: 'public',
      module: 'adms',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'accountId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'tokenHash',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'expiresAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'staff_session_tokenhash_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'tokenHash',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._isp.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(dynamic data, [Type? t]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _is.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i8nqich0.AuthAccess) {
      return _i8nqich0.AuthAccess.fromJson(data) as T;
    }
    if (t == _ioq64fq7.CareReport) {
      return _ioq64fq7.CareReport.fromJson(data) as T;
    }
    if (t == _ibw91gj7.DemoAccess) {
      return _ibw91gj7.DemoAccess.fromJson(data) as T;
    }
    if (t == _i3il5by7.DispatchEvent) {
      return _i3il5by7.DispatchEvent.fromJson(data) as T;
    }
    if (t == _ianatnwr.DispatchException) {
      return _ianatnwr.DispatchException.fromJson(data) as T;
    }
    if (t == _ij4w9jgx.DispatchIncident) {
      return _ij4w9jgx.DispatchIncident.fromJson(data) as T;
    }
    if (t == _isj5369a.DispatchSession) {
      return _isj5369a.DispatchSession.fromJson(data) as T;
    }
    if (t == _iua6f297.DispatchSnapshot) {
      return _iua6f297.DispatchSnapshot.fromJson(data) as T;
    }
    if (t == _iyuv25k5.DispatchUnit) {
      return _iyuv25k5.DispatchUnit.fromJson(data) as T;
    }
    if (t == _i10k8j4y.Hospital) {
      return _i10k8j4y.Hospital.fromJson(data) as T;
    }
    if (t == _i1mq8ass.InviteAccess) {
      return _i1mq8ass.InviteAccess.fromJson(data) as T;
    }
    if (t == _iwc209pn.MaintenanceJob) {
      return _iwc209pn.MaintenanceJob.fromJson(data) as T;
    }
    if (t == _i1okvm19.StaffAccount) {
      return _i1okvm19.StaffAccount.fromJson(data) as T;
    }
    if (t == _i6rbwel4.StaffInvite) {
      return _i6rbwel4.StaffInvite.fromJson(data) as T;
    }
    if (t == _inpgeoak.StaffProfile) {
      return _inpgeoak.StaffProfile.fromJson(data) as T;
    }
    if (t == _ipy0xdiy.StaffSession) {
      return _ipy0xdiy.StaffSession.fromJson(data) as T;
    }
    if (t == _i7a46nnq.WorkspaceConfig) {
      return _i7a46nnq.WorkspaceConfig.fromJson(data) as T;
    }
    if (t == _is.getType<_i8nqich0.AuthAccess?>()) {
      return (data != null ? _i8nqich0.AuthAccess.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ioq64fq7.CareReport?>()) {
      return (data != null ? _ioq64fq7.CareReport.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ibw91gj7.DemoAccess?>()) {
      return (data != null ? _ibw91gj7.DemoAccess.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i3il5by7.DispatchEvent?>()) {
      return (data != null ? _i3il5by7.DispatchEvent.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ianatnwr.DispatchException?>()) {
      return (data != null ? _ianatnwr.DispatchException.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ij4w9jgx.DispatchIncident?>()) {
      return (data != null ? _ij4w9jgx.DispatchIncident.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_isj5369a.DispatchSession?>()) {
      return (data != null ? _isj5369a.DispatchSession.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iua6f297.DispatchSnapshot?>()) {
      return (data != null ? _iua6f297.DispatchSnapshot.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iyuv25k5.DispatchUnit?>()) {
      return (data != null ? _iyuv25k5.DispatchUnit.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i10k8j4y.Hospital?>()) {
      return (data != null ? _i10k8j4y.Hospital.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i1mq8ass.InviteAccess?>()) {
      return (data != null ? _i1mq8ass.InviteAccess.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iwc209pn.MaintenanceJob?>()) {
      return (data != null ? _iwc209pn.MaintenanceJob.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i1okvm19.StaffAccount?>()) {
      return (data != null ? _i1okvm19.StaffAccount.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i6rbwel4.StaffInvite?>()) {
      return (data != null ? _i6rbwel4.StaffInvite.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_inpgeoak.StaffProfile?>()) {
      return (data != null ? _inpgeoak.StaffProfile.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ipy0xdiy.StaffSession?>()) {
      return (data != null ? _ipy0xdiy.StaffSession.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i7a46nnq.WorkspaceConfig?>()) {
      return (data != null ? _i7a46nnq.WorkspaceConfig.fromJson(data) : null)
          as T;
    }
    if (t == List<_i10k8j4y.Hospital>) {
      return (data as List)
              .map((e) => deserialize<_i10k8j4y.Hospital>(e))
              .toList()
          as T;
    }
    if (t == _is.getType<List<_i10k8j4y.Hospital>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i10k8j4y.Hospital>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_ioq64fq7.CareReport>) {
      return (data as List)
              .map((e) => deserialize<_ioq64fq7.CareReport>(e))
              .toList()
          as T;
    }
    if (t == _is.getType<List<_ioq64fq7.CareReport>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_ioq64fq7.CareReport>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_iwc209pn.MaintenanceJob>) {
      return (data as List)
              .map((e) => deserialize<_iwc209pn.MaintenanceJob>(e))
              .toList()
          as T;
    }
    if (t == _is.getType<List<_iwc209pn.MaintenanceJob>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_iwc209pn.MaintenanceJob>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_inpgeoak.StaffProfile>) {
      return (data as List)
              .map((e) => deserialize<_inpgeoak.StaffProfile>(e))
              .toList()
          as T;
    }
    if (t == _is.getType<List<_inpgeoak.StaffProfile>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_inpgeoak.StaffProfile>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_ij4w9jgx.DispatchIncident>) {
      return (data as List)
              .map((e) => deserialize<_ij4w9jgx.DispatchIncident>(e))
              .toList()
          as T;
    }
    if (t == List<_iyuv25k5.DispatchUnit>) {
      return (data as List)
              .map((e) => deserialize<_iyuv25k5.DispatchUnit>(e))
              .toList()
          as T;
    }
    if (t == List<_i3il5by7.DispatchEvent>) {
      return (data as List)
              .map((e) => deserialize<_i3il5by7.DispatchEvent>(e))
              .toList()
          as T;
    }
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i8nqich0.AuthAccess => 'AuthAccess',
      _ioq64fq7.CareReport => 'CareReport',
      _ibw91gj7.DemoAccess => 'DemoAccess',
      _i3il5by7.DispatchEvent => 'DispatchEvent',
      _ianatnwr.DispatchException => 'DispatchException',
      _ij4w9jgx.DispatchIncident => 'DispatchIncident',
      _isj5369a.DispatchSession => 'DispatchSession',
      _iua6f297.DispatchSnapshot => 'DispatchSnapshot',
      _iyuv25k5.DispatchUnit => 'DispatchUnit',
      _i10k8j4y.Hospital => 'Hospital',
      _i1mq8ass.InviteAccess => 'InviteAccess',
      _iwc209pn.MaintenanceJob => 'MaintenanceJob',
      _i1okvm19.StaffAccount => 'StaffAccount',
      _i6rbwel4.StaffInvite => 'StaffInvite',
      _inpgeoak.StaffProfile => 'StaffProfile',
      _ipy0xdiy.StaffSession => 'StaffSession',
      _i7a46nnq.WorkspaceConfig => 'WorkspaceConfig',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('adms.', '');
    }

    switch (data) {
      case _i8nqich0.AuthAccess():
        return 'AuthAccess';
      case _ioq64fq7.CareReport():
        return 'CareReport';
      case _ibw91gj7.DemoAccess():
        return 'DemoAccess';
      case _i3il5by7.DispatchEvent():
        return 'DispatchEvent';
      case _ianatnwr.DispatchException():
        return 'DispatchException';
      case _ij4w9jgx.DispatchIncident():
        return 'DispatchIncident';
      case _isj5369a.DispatchSession():
        return 'DispatchSession';
      case _iua6f297.DispatchSnapshot():
        return 'DispatchSnapshot';
      case _iyuv25k5.DispatchUnit():
        return 'DispatchUnit';
      case _i10k8j4y.Hospital():
        return 'Hospital';
      case _i1mq8ass.InviteAccess():
        return 'InviteAccess';
      case _iwc209pn.MaintenanceJob():
        return 'MaintenanceJob';
      case _i1okvm19.StaffAccount():
        return 'StaffAccount';
      case _i6rbwel4.StaffInvite():
        return 'StaffInvite';
      case _inpgeoak.StaffProfile():
        return 'StaffProfile';
      case _ipy0xdiy.StaffSession():
        return 'StaffSession';
      case _i7a46nnq.WorkspaceConfig():
        return 'WorkspaceConfig';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AuthAccess') {
      return deserialize<_i8nqich0.AuthAccess>(data['data']);
    }
    if (dataClassName == 'CareReport') {
      return deserialize<_ioq64fq7.CareReport>(data['data']);
    }
    if (dataClassName == 'DemoAccess') {
      return deserialize<_ibw91gj7.DemoAccess>(data['data']);
    }
    if (dataClassName == 'DispatchEvent') {
      return deserialize<_i3il5by7.DispatchEvent>(data['data']);
    }
    if (dataClassName == 'DispatchException') {
      return deserialize<_ianatnwr.DispatchException>(data['data']);
    }
    if (dataClassName == 'DispatchIncident') {
      return deserialize<_ij4w9jgx.DispatchIncident>(data['data']);
    }
    if (dataClassName == 'DispatchSession') {
      return deserialize<_isj5369a.DispatchSession>(data['data']);
    }
    if (dataClassName == 'DispatchSnapshot') {
      return deserialize<_iua6f297.DispatchSnapshot>(data['data']);
    }
    if (dataClassName == 'DispatchUnit') {
      return deserialize<_iyuv25k5.DispatchUnit>(data['data']);
    }
    if (dataClassName == 'Hospital') {
      return deserialize<_i10k8j4y.Hospital>(data['data']);
    }
    if (dataClassName == 'InviteAccess') {
      return deserialize<_i1mq8ass.InviteAccess>(data['data']);
    }
    if (dataClassName == 'MaintenanceJob') {
      return deserialize<_iwc209pn.MaintenanceJob>(data['data']);
    }
    if (dataClassName == 'StaffAccount') {
      return deserialize<_i1okvm19.StaffAccount>(data['data']);
    }
    if (dataClassName == 'StaffInvite') {
      return deserialize<_i6rbwel4.StaffInvite>(data['data']);
    }
    if (dataClassName == 'StaffProfile') {
      return deserialize<_inpgeoak.StaffProfile>(data['data']);
    }
    if (dataClassName == 'StaffSession') {
      return deserialize<_ipy0xdiy.StaffSession>(data['data']);
    }
    if (dataClassName == 'WorkspaceConfig') {
      return deserialize<_i7a46nnq.WorkspaceConfig>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _ioq64fq7.CareReport:
        return _ioq64fq7.CareReport.t;
      case _i3il5by7.DispatchEvent:
        return _i3il5by7.DispatchEvent.t;
      case _ij4w9jgx.DispatchIncident:
        return _ij4w9jgx.DispatchIncident.t;
      case _isj5369a.DispatchSession:
        return _isj5369a.DispatchSession.t;
      case _iyuv25k5.DispatchUnit:
        return _iyuv25k5.DispatchUnit.t;
      case _i10k8j4y.Hospital:
        return _i10k8j4y.Hospital.t;
      case _iwc209pn.MaintenanceJob:
        return _iwc209pn.MaintenanceJob.t;
      case _i1okvm19.StaffAccount:
        return _i1okvm19.StaffAccount.t;
      case _i6rbwel4.StaffInvite:
        return _i6rbwel4.StaffInvite.t;
      case _ipy0xdiy.StaffSession:
        return _ipy0xdiy.StaffSession.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'adms';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _isp.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
