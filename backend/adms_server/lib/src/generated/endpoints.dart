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
import 'package:adms_server/src/generated/dispatch/care_report.dart'
    as _imfvljrg;
import 'package:adms_server/src/generated/dispatch/dispatch_unit.dart'
    as _ih4iao0k;
import 'package:adms_server/src/generated/dispatch/hospital.dart' as _igxrax7o;
import 'package:adms_server/src/generated/dispatch/maintenance_job.dart'
    as _ia3x1okn;
import 'package:serverpod/serverpod.dart' as _is;
import '../dispatch/account_endpoint.dart' as _ig1jq62n;
import '../dispatch/dispatch_endpoint.dart' as _icr87wgl;
import '../dispatch/operations_endpoint.dart' as _iz1yc988;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'account': _ig1jq62n.AccountEndpoint()
        ..initialize(server, 'account', null),
      'dispatch': _icr87wgl.DispatchEndpoint()
        ..initialize(server, 'dispatch', null),
      'operations': _iz1yc988.OperationsEndpoint()
        ..initialize(server, 'operations', null),
    };
    connectors['account'] = _is.EndpointConnector(
      name: 'account',
      endpoint: endpoints['account']!,
      methodConnectors: {
        'registerOrganization': _is.MethodConnector(
          name: 'registerOrganization',
          params: {
            'organization': _is.ParameterDescription(
              name: 'organization',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['account'] as _ig1jq62n.AccountEndpoint)
                  .registerOrganization(
                    session,
                    params['organization'],
                    params['name'],
                    params['email'],
                    params['password'],
                  ),
        ),
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['account'] as _ig1jq62n.AccountEndpoint).login(
                session,
                params['email'],
                params['password'],
              ),
        ),
        'logout': _is.MethodConnector(
          name: 'logout',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['account'] as _ig1jq62n.AccountEndpoint).logout(
                session,
                params['token'],
              ),
        ),
        'invite': _is.MethodConnector(
          name: 'invite',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'role': _is.ParameterDescription(
              name: 'role',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'unitId': _is.ParameterDescription(
              name: 'unitId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'recovery': _is.ParameterDescription(
              name: 'recovery',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['account'] as _ig1jq62n.AccountEndpoint).invite(
                session,
                params['token'],
                params['email'],
                params['role'],
                params['unitId'],
                params['recovery'],
              ),
        ),
        'acceptInvite': _is.MethodConnector(
          name: 'acceptInvite',
          params: {
            'inviteToken': _is.ParameterDescription(
              name: 'inviteToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['account'] as _ig1jq62n.AccountEndpoint).acceptInvite(
                session,
                params['inviteToken'],
                params['name'],
                params['password'],
              ),
        ),
        'changePassword': _is.MethodConnector(
          name: 'changePassword',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'oldPassword': _is.ParameterDescription(
              name: 'oldPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newPassword': _is.ParameterDescription(
              name: 'newPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['account'] as _ig1jq62n.AccountEndpoint)
                  .changePassword(
                    session,
                    params['token'],
                    params['oldPassword'],
                    params['newPassword'],
                  ),
        ),
        'updateMember': _is.MethodConnector(
          name: 'updateMember',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'accountId': _is.ParameterDescription(
              name: 'accountId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'active': _is.ParameterDescription(
              name: 'active',
              type: _is.getType<bool>(),
              nullable: false,
            ),
            'unitId': _is.ParameterDescription(
              name: 'unitId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['account'] as _ig1jq62n.AccountEndpoint).updateMember(
                session,
                params['token'],
                params['accountId'],
                params['active'],
                params['unitId'],
              ),
        ),
      },
    );
    connectors['dispatch'] = _is.EndpointConnector(
      name: 'dispatch',
      endpoint: endpoints['dispatch']!,
      methodConnectors: {
        'startDemo': _is.MethodConnector(
          name: 'startDemo',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['dispatch'] as _icr87wgl.DispatchEndpoint).startDemo(
                session,
              ),
        ),
        'snapshot': _is.MethodConnector(
          name: 'snapshot',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['dispatch'] as _icr87wgl.DispatchEndpoint).snapshot(
                session,
                params['token'],
              ),
        ),
        'report': _is.MethodConnector(
          name: 'report',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'description': _is.ParameterDescription(
              name: 'description',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'address': _is.ParameterDescription(
              name: 'address',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'latitude': _is.ParameterDescription(
              name: 'latitude',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'longitude': _is.ParameterDescription(
              name: 'longitude',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'severity': _is.ParameterDescription(
              name: 'severity',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['dispatch'] as _icr87wgl.DispatchEndpoint).report(
                session,
                params['token'],
                params['description'],
                params['address'],
                params['latitude'],
                params['longitude'],
                params['severity'],
              ),
        ),
        'dispatchNearest': _is.MethodConnector(
          name: 'dispatchNearest',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'incidentId': _is.ParameterDescription(
              name: 'incidentId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['dispatch'] as _icr87wgl.DispatchEndpoint)
                  .dispatchNearest(
                    session,
                    params['token'],
                    params['incidentId'],
                  ),
        ),
        'advance': _is.MethodConnector(
          name: 'advance',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'incidentId': _is.ParameterDescription(
              name: 'incidentId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'expectedStatus': _is.ParameterDescription(
              name: 'expectedStatus',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['dispatch'] as _icr87wgl.DispatchEndpoint).advance(
                session,
                params['token'],
                params['incidentId'],
                params['expectedStatus'],
              ),
        ),
        'cancel': _is.MethodConnector(
          name: 'cancel',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'incidentId': _is.ParameterDescription(
              name: 'incidentId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['dispatch'] as _icr87wgl.DispatchEndpoint).cancel(
                session,
                params['token'],
                params['incidentId'],
                params['reason'],
              ),
        ),
        'watch': _is.MethodStreamConnector(
          name: 'watch',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['dispatch'] as _icr87wgl.DispatchEndpoint).watch(
                session,
                params['token'],
              ),
        ),
      },
    );
    connectors['operations'] = _is.EndpointConnector(
      name: 'operations',
      endpoint: endpoints['operations']!,
      methodConnectors: {
        'saveUnit': _is.MethodConnector(
          name: 'saveUnit',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'input': _is.ParameterDescription(
              name: 'input',
              type: _is.getType<_ih4iao0k.DispatchUnit>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['operations'] as _iz1yc988.OperationsEndpoint)
                  .saveUnit(session, params['token'], params['input']),
        ),
        'updateLocation': _is.MethodConnector(
          name: 'updateLocation',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'unitId': _is.ParameterDescription(
              name: 'unitId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'latitude': _is.ParameterDescription(
              name: 'latitude',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'longitude': _is.ParameterDescription(
              name: 'longitude',
              type: _is.getType<double>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['operations'] as _iz1yc988.OperationsEndpoint)
                  .updateLocation(
                    session,
                    params['token'],
                    params['unitId'],
                    params['latitude'],
                    params['longitude'],
                  ),
        ),
        'saveHospital': _is.MethodConnector(
          name: 'saveHospital',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'input': _is.ParameterDescription(
              name: 'input',
              type: _is.getType<_igxrax7o.Hospital>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['operations'] as _iz1yc988.OperationsEndpoint)
                  .saveHospital(session, params['token'], params['input']),
        ),
        'setDestination': _is.MethodConnector(
          name: 'setDestination',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'incidentId': _is.ParameterDescription(
              name: 'incidentId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'hospitalId': _is.ParameterDescription(
              name: 'hospitalId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['operations'] as _iz1yc988.OperationsEndpoint)
                  .setDestination(
                    session,
                    params['token'],
                    params['incidentId'],
                    params['hospitalId'],
                  ),
        ),
        'saveCareReport': _is.MethodConnector(
          name: 'saveCareReport',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'input': _is.ParameterDescription(
              name: 'input',
              type: _is.getType<_imfvljrg.CareReport>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['operations'] as _iz1yc988.OperationsEndpoint)
                  .saveCareReport(session, params['token'], params['input']),
        ),
        'saveMaintenance': _is.MethodConnector(
          name: 'saveMaintenance',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'input': _is.ParameterDescription(
              name: 'input',
              type: _is.getType<_ia3x1okn.MaintenanceJob>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['operations'] as _iz1yc988.OperationsEndpoint)
                  .saveMaintenance(session, params['token'], params['input']),
        ),
        'settings': _is.MethodConnector(
          name: 'settings',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'autoDispatch': _is.ParameterDescription(
              name: 'autoDispatch',
              type: _is.getType<bool>(),
              nullable: false,
            ),
            'responseTargetMinutes': _is.ParameterDescription(
              name: 'responseTargetMinutes',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['operations'] as _iz1yc988.OperationsEndpoint)
                  .settings(
                    session,
                    params['token'],
                    params['name'],
                    params['autoDispatch'],
                    params['responseTargetMinutes'],
                  ),
        ),
      },
    );
  }
}
