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
import 'dart:async' as _ida;
import 'package:adms_client/src/protocol/dispatch/auth_access.dart'
    as _i8rfd2ro;
import 'package:adms_client/src/protocol/dispatch/care_report.dart'
    as _i7zbxllt;
import 'package:adms_client/src/protocol/dispatch/demo_access.dart'
    as _iqn9qcyk;
import 'package:adms_client/src/protocol/dispatch/dispatch_snapshot.dart'
    as _iui31w0o;
import 'package:adms_client/src/protocol/dispatch/dispatch_unit.dart'
    as _ig3t87zw;
import 'package:adms_client/src/protocol/dispatch/hospital.dart' as _i1cafsuu;
import 'package:adms_client/src/protocol/dispatch/invite_access.dart'
    as _irynpkzn;
import 'package:adms_client/src/protocol/dispatch/maintenance_job.dart'
    as _iza162hw;
import 'package:http/http.dart' as _i85jenna;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'protocol.dart' as _il2as5qe;

/// {@category Endpoint}
class EndpointAccount extends _isc.EndpointRef {
  EndpointAccount(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'account';

  _ida.Future<_i8rfd2ro.AuthAccess> registerOrganization(
    String organization,
    String name,
    String email,
    String password,
  ) => caller.callServerEndpoint<_i8rfd2ro.AuthAccess>(
    'account',
    'registerOrganization',
    {
      'organization': organization,
      'name': name,
      'email': email,
      'password': password,
    },
  );

  _ida.Future<_i8rfd2ro.AuthAccess> login(String email, String password) =>
      caller.callServerEndpoint<_i8rfd2ro.AuthAccess>('account', 'login', {
        'email': email,
        'password': password,
      });

  _ida.Future<void> logout(String token) =>
      caller.callServerEndpoint<void>('account', 'logout', {'token': token});

  _ida.Future<_irynpkzn.InviteAccess> invite(
    String token,
    String email,
    String role,
    int? unitId,
    bool recovery,
  ) => caller.callServerEndpoint<_irynpkzn.InviteAccess>('account', 'invite', {
    'token': token,
    'email': email,
    'role': role,
    'unitId': unitId,
    'recovery': recovery,
  });

  _ida.Future<_i8rfd2ro.AuthAccess> acceptInvite(
    String inviteToken,
    String name,
    String password,
  ) => caller.callServerEndpoint<_i8rfd2ro.AuthAccess>(
    'account',
    'acceptInvite',
    {'inviteToken': inviteToken, 'name': name, 'password': password},
  );

  _ida.Future<void> changePassword(
    String token,
    String oldPassword,
    String newPassword,
  ) => caller.callServerEndpoint<void>('account', 'changePassword', {
    'token': token,
    'oldPassword': oldPassword,
    'newPassword': newPassword,
  });

  _ida.Future<void> updateMember(
    String token,
    int accountId,
    bool active,
    int? unitId,
  ) => caller.callServerEndpoint<void>('account', 'updateMember', {
    'token': token,
    'accountId': accountId,
    'active': active,
    'unitId': unitId,
  });
}

/// Server-authoritative dispatch workflow. Tokens grant access only to one
/// isolated, fictional workspace; no personal or real emergency data is stored.
/// {@category Endpoint}
class EndpointDispatch extends _isc.EndpointRef {
  EndpointDispatch(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'dispatch';

  _ida.Future<_iqn9qcyk.DemoAccess> startDemo() => caller
      .callServerEndpoint<_iqn9qcyk.DemoAccess>('dispatch', 'startDemo', {});

  _ida.Future<_iui31w0o.DispatchSnapshot> snapshot(String token) =>
      caller.callServerEndpoint<_iui31w0o.DispatchSnapshot>(
        'dispatch',
        'snapshot',
        {'token': token},
      );

  _ida.Stream<_iui31w0o.DispatchSnapshot> watch(String token) =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_iui31w0o.DispatchSnapshot>,
        _iui31w0o.DispatchSnapshot
      >('dispatch', 'watch', {'token': token}, {});

  _ida.Future<_iui31w0o.DispatchSnapshot> report(
    String token,
    String description,
    String address,
    double latitude,
    double longitude,
    String severity,
  ) => caller
      .callServerEndpoint<_iui31w0o.DispatchSnapshot>('dispatch', 'report', {
        'token': token,
        'description': description,
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
        'severity': severity,
      });

  _ida.Future<_iui31w0o.DispatchSnapshot> dispatchNearest(
    String token,
    int incidentId,
  ) => caller.callServerEndpoint<_iui31w0o.DispatchSnapshot>(
    'dispatch',
    'dispatchNearest',
    {'token': token, 'incidentId': incidentId},
  );

  _ida.Future<_iui31w0o.DispatchSnapshot> advance(
    String token,
    int incidentId,
    String expectedStatus,
  ) => caller.callServerEndpoint<_iui31w0o.DispatchSnapshot>(
    'dispatch',
    'advance',
    {
      'token': token,
      'incidentId': incidentId,
      'expectedStatus': expectedStatus,
    },
  );

  _ida.Future<_iui31w0o.DispatchSnapshot> cancel(
    String token,
    int incidentId,
    String reason,
  ) => caller.callServerEndpoint<_iui31w0o.DispatchSnapshot>(
    'dispatch',
    'cancel',
    {'token': token, 'incidentId': incidentId, 'reason': reason},
  );
}

/// {@category Endpoint}
class EndpointOperations extends _isc.EndpointRef {
  EndpointOperations(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'operations';

  _ida.Future<_iui31w0o.DispatchSnapshot> saveUnit(
    String token,
    _ig3t87zw.DispatchUnit input,
  ) => caller.callServerEndpoint<_iui31w0o.DispatchSnapshot>(
    'operations',
    'saveUnit',
    {'token': token, 'input': input},
  );

  _ida.Future<_iui31w0o.DispatchSnapshot> updateLocation(
    String token,
    int unitId,
    double latitude,
    double longitude,
  ) => caller.callServerEndpoint<_iui31w0o.DispatchSnapshot>(
    'operations',
    'updateLocation',
    {
      'token': token,
      'unitId': unitId,
      'latitude': latitude,
      'longitude': longitude,
    },
  );

  _ida.Future<_iui31w0o.DispatchSnapshot> saveHospital(
    String token,
    _i1cafsuu.Hospital input,
  ) => caller.callServerEndpoint<_iui31w0o.DispatchSnapshot>(
    'operations',
    'saveHospital',
    {'token': token, 'input': input},
  );

  _ida.Future<_iui31w0o.DispatchSnapshot> setDestination(
    String token,
    int incidentId,
    int hospitalId,
  ) => caller.callServerEndpoint<_iui31w0o.DispatchSnapshot>(
    'operations',
    'setDestination',
    {'token': token, 'incidentId': incidentId, 'hospitalId': hospitalId},
  );

  _ida.Future<_iui31w0o.DispatchSnapshot> saveCareReport(
    String token,
    _i7zbxllt.CareReport input,
  ) => caller.callServerEndpoint<_iui31w0o.DispatchSnapshot>(
    'operations',
    'saveCareReport',
    {'token': token, 'input': input},
  );

  _ida.Future<_iui31w0o.DispatchSnapshot> saveMaintenance(
    String token,
    _iza162hw.MaintenanceJob input,
  ) => caller.callServerEndpoint<_iui31w0o.DispatchSnapshot>(
    'operations',
    'saveMaintenance',
    {'token': token, 'input': input},
  );

  _ida.Future<_iui31w0o.DispatchSnapshot> settings(
    String token,
    String name,
    bool autoDispatch,
    int responseTargetMinutes,
  ) => caller.callServerEndpoint<_iui31w0o.DispatchSnapshot>(
    'operations',
    'settings',
    {
      'token': token,
      'name': name,
      'autoDispatch': autoDispatch,
      'responseTargetMinutes': responseTargetMinutes,
    },
  );
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(_isc.MethodCallContext, Object, StackTrace)? onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    account = EndpointAccount(this);
    dispatch = EndpointDispatch(this);
    operations = EndpointOperations(this);
  }

  late final EndpointAccount account;

  late final EndpointDispatch dispatch;

  late final EndpointOperations operations;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'account': account,
    'dispatch': dispatch,
    'operations': operations,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {};
}
