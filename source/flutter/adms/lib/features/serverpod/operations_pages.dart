import 'package:adms_client/adms_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'dispatch_controller.dart';
import 'report_export.dart';

const _ink = Color(0xFF152A45),
    _accent = Color(0xFF008C7D),
    _gray = Color(0xFF64748B);

class OperationsPages extends StatefulWidget {
  const OperationsPages({
    super.key,
    required this.controller,
    required this.page,
  });
  final DispatchController controller;
  final int page;
  @override
  State<OperationsPages> createState() => _OperationsPagesState();
}

class _OperationsPagesState extends State<OperationsPages> {
  DispatchController get c => widget.controller;
  int _days = 0;
  @override
  Widget build(BuildContext context) => switch (widget.page) {
    1 => _fleet(),
    3 => _analytics(),
    4 => _staff(),
    5 => _hospitals(),
    6 => _maintenance(),
    7 => _settings(),
    _ => const SizedBox.shrink(),
  };
  Widget _box(String title, List<Widget> children, {Widget? action}) =>
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: 18,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: _ink,
                  ),
                ),
                ?action,
              ],
            ),
            const SizedBox(height: 20),
            ...children,
          ],
        ),
      );
  Widget _row(
    String title,
    String subtitle,
    List<Widget> actions, {
    IconData icon = Icons.list_alt,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: 18),
    child: Wrap(
      spacing: 14,
      runSpacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Icon(icon, color: _accent),
        SizedBox(
          width: 240,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: _gray),
              ),
            ],
          ),
        ),
        ...actions,
      ],
    ),
  );
  Widget _fleet() => _box(
    'Ambulance units',
    [
      const Text(
        'Manage readiness, crew details, and reported locations.',
        style: TextStyle(color: _gray, fontSize: 12),
      ),
      const SizedBox(height: 18),
      for (final unit in c.data!.units)
        _row(
          unit.callSign,
          '${unit.unitType ?? 'ALS'} · ${unit.crew}\n${unit.active ? unit.status : 'Inactive'} · ${unit.latitude.toStringAsFixed(4)}, ${unit.longitude.toStringAsFixed(4)}',
          [
            if (c.canDispatch)
              OutlinedButton(
                onPressed: c.busy ? null : () => _editUnit(unit),
                child: const Text('Edit unit'),
              ),
            if (c.canRespond)
              OutlinedButton(
                onPressed: c.busy ? null : () => _editLocation(unit),
                child: const Text('Update location'),
              ),
          ],
          icon: Icons.airport_shuttle_outlined,
        ),
      if (c.data!.units.isEmpty)
        const Text(
          'No unit assigned yet. Ask your administrator to assign your crew.',
        ),
    ],
    action: c.canDispatch
        ? FilledButton.icon(
            onPressed: c.busy ? null : () => _editUnit(null),
            icon: const Icon(Icons.add),
            label: const Text('Add ambulance'),
          )
        : null,
  );

  Future<void> _editUnit(DispatchUnit? unit) async {
    final statuses =
        unit != null && !['available', 'outOfService'].contains(unit.status)
        ? [unit.status]
        : ['available', 'outOfService'];
    await showEditor(
      context,
      c,
      unit == null ? 'Add ambulance' : 'Edit ${unit.callSign}',
      [
        Entry('call', 'Call sign', unit?.callSign ?? '', required: true),
        Entry('crew', 'Crew name', unit?.crew ?? '', required: true),
        Entry('plate', 'Plate number', unit?.plateNumber ?? ''),
        Entry(
          'type',
          'Unit type',
          unit?.unitType ?? 'ALS',
          options: const ['ALS', 'BLS', 'MICU', 'Rescue'],
        ),
        Entry(
          'status',
          'Availability',
          unit?.status ?? 'available',
          options: statuses,
        ),
        Entry(
          'active',
          'Active',
          unit?.active == false ? 'false' : 'true',
          options: const ['true', 'false'],
        ),
        Entry('lat', 'Latitude', '${unit?.latitude ?? 14.5995}', numeric: true),
        Entry(
          'lng',
          'Longitude',
          '${unit?.longitude ?? 120.9842}',
          numeric: true,
        ),
      ],
      (v) => c.saveUnit(
        DispatchUnit(
          id: unit?.id,
          workspaceId: c.data!.viewer?.workspaceId ?? 0,
          callSign: v['call']!,
          crew: v['crew']!,
          plateNumber: v['plate'],
          unitType: v['type'],
          status: v['status']!,
          active: v['active'] == 'true',
          latitude: double.parse(v['lat']!),
          longitude: double.parse(v['lng']!),
        ),
      ),
    );
  }

  Future<void> _editLocation(DispatchUnit unit) async {
    await showEditor(
      context,
      c,
      'Update ${unit.callSign} location',
      [
        Entry('lat', 'Latitude', '${unit.latitude}', numeric: true),
        Entry('lng', 'Longitude', '${unit.longitude}', numeric: true),
      ],
      (v) => c.updateLocation(
        unit.id!,
        double.parse(v['lat']!),
        double.parse(v['lng']!),
      ),
    );
  }

  Widget _hospitals() => _box(
    'Receiving hospitals',
    [
      for (final h in c.data!.hospitals ?? <Hospital>[])
        _row(
          h.name,
          '${h.address}\n${h.phone.isEmpty ? 'No phone recorded' : h.phone} · ${h.active ? 'Active' : 'Inactive'}',
          [
            OutlinedButton(
              onPressed: c.busy ? null : () => _editHospital(h),
              child: const Text('Edit hospital'),
            ),
          ],
          icon: Icons.local_hospital_outlined,
        ),
      if ((c.data!.hospitals ?? []).isEmpty)
        const Text('Add a receiving hospital to enable destination selection.'),
    ],
    action: FilledButton.icon(
      onPressed: c.busy ? null : () => _editHospital(null),
      icon: const Icon(Icons.add),
      label: const Text('Add hospital'),
    ),
  );
  Future<void> _editHospital(Hospital? h) async => showEditor(
    context,
    c,
    h == null ? 'Add hospital' : 'Edit hospital',
    [
      Entry('name', 'Hospital name', h?.name ?? '', required: true),
      Entry('address', 'Address', h?.address ?? '', required: true),
      Entry('phone', 'Phone', h?.phone ?? ''),
      Entry('lat', 'Latitude', '${h?.latitude ?? 14.604}', numeric: true),
      Entry('lng', 'Longitude', '${h?.longitude ?? 120.986}', numeric: true),
      Entry(
        'active',
        'Active',
        h?.active == false ? 'false' : 'true',
        options: const ['true', 'false'],
      ),
    ],
    (v) => c.saveHospital(
      Hospital(
        id: h?.id,
        workspaceId: 0,
        name: v['name']!,
        address: v['address']!,
        phone: v['phone']!,
        latitude: double.parse(v['lat']!),
        longitude: double.parse(v['lng']!),
        active: v['active'] == 'true',
      ),
    ),
  );

  Widget _maintenance() => _box(
    'Fleet maintenance',
    [
      for (final job in c.data!.maintenance ?? <MaintenanceJob>[])
        _row(
          job.title,
          'Unit #${job.unitId} · ${DateFormat('dd MMM yyyy').format(job.dueAt.toLocal())}\n${job.status} · Cost ${job.cost.toStringAsFixed(2)}',
          [
            if (job.status != 'completed')
              OutlinedButton(
                onPressed: c.busy ? null : () => _advanceMaintenance(job),
                child: Text(
                  job.status == 'scheduled' ? 'Start work' : 'Complete work',
                ),
              ),
          ],
          icon: Icons.build_outlined,
        ),
      if ((c.data!.maintenance ?? []).isEmpty)
        const Text(
          'No maintenance scheduled. Units in active maintenance cannot be dispatched.',
        ),
    ],
    action: FilledButton.icon(
      onPressed: c.busy || c.data!.units.isEmpty ? null : _addMaintenance,
      icon: const Icon(Icons.add),
      label: const Text('Schedule maintenance'),
    ),
  );
  Future<void> _addMaintenance() async => showEditor(
    context,
    c,
    'Schedule maintenance',
    [
      Entry(
        'unit',
        'Ambulance',
        '${c.data!.units.first.id}',
        options: [for (final u in c.data!.units) '${u.id}'],
        labels: {for (final u in c.data!.units) '${u.id}': u.callSign},
      ),
      Entry('title', 'Work required', '', required: true),
      Entry('notes', 'Notes', '', lines: 2),
      Entry(
        'date',
        'Due date (YYYY-MM-DD)',
        DateFormat('yyyy-MM-dd').format(DateTime.now()),
        date: true,
      ),
      Entry('cost', 'Estimated cost', '0', numeric: true),
    ],
    (v) => c.saveMaintenance(
      MaintenanceJob(
        workspaceId: 0,
        unitId: int.parse(v['unit']!),
        title: v['title']!,
        notes: v['notes']!,
        dueAt: DateTime.parse(v['date']!),
        cost: double.parse(v['cost']!),
        status: 'scheduled',
        updatedAt: DateTime.now().toUtc(),
      ),
    ),
  );
  Future<void> _advanceMaintenance(MaintenanceJob job) async {
    final next = job.copyWith(
      status: job.status == 'scheduled' ? 'inProgress' : 'completed',
    );
    await c.saveMaintenance(next);
  }

  Widget _staff() => _box(
    'Organization members',
    [
      if (c.isDemo)
        const Text(
          'Create a persistent organization to invite staff and citizens. Demo visitors remain isolated.',
        ),
      for (final a in c.data!.staff ?? <StaffProfile>[])
        _row(
          a.name,
          '${a.email}\n${a.role} · ${a.active ? 'Active' : 'Disabled'}${a.assignedUnitId == null ? '' : ' · Unit #${a.assignedUnitId}'}',
          [
            if (a.id != c.data!.viewer?.id)
              OutlinedButton(
                onPressed: c.busy
                    ? null
                    : () => c.updateMember(a.id, !a.active, a.assignedUnitId),
                child: Text(a.active ? 'Deactivate' : 'Reactivate'),
              ),
            if (a.role == 'crew')
              OutlinedButton(
                onPressed: c.busy ? null : () => _assignCrew(a),
                child: const Text('Assign unit'),
              ),
            if (a.active)
              TextButton(
                onPressed: c.busy ? null : () => _invite(recovery: a),
                child: const Text('Recovery code'),
              ),
          ],
          icon: Icons.person_outline,
        ),
    ],
    action: FilledButton.icon(
      onPressed: c.busy || c.isDemo ? null : () => _invite(),
      icon: const Icon(Icons.person_add_outlined),
      label: const Text('Invite member'),
    ),
  );
  Future<void> _assignCrew(StaffProfile member) async => showEditor(
    context,
    c,
    'Assign ${member.name}',
    [
      Entry(
        'unit',
        'Ambulance',
        '${member.assignedUnitId ?? c.data!.units.firstOrNull?.id ?? 0}',
        options: [
          for (final u in c.data!.units.where((u) => u.active)) '${u.id}',
        ],
        labels: {for (final u in c.data!.units) '${u.id}': u.callSign},
      ),
    ],
    (v) => c.updateMember(member.id, member.active, int.parse(v['unit']!)),
  );
  Future<void> _invite({StaffProfile? recovery}) async {
    InviteAccess? created;
    await showEditor(
      context,
      c,
      recovery == null ? 'Invite a member' : 'Issue account recovery',
      [
        Entry('email', 'Email', recovery?.email ?? '', required: true),
        if (recovery == null)
          Entry(
            'role',
            'Role',
            'dispatcher',
            options: const ['admin', 'dispatcher', 'crew', 'citizen'],
          ),
        if (recovery == null)
          Entry(
            'unit',
            'Crew unit (ignored for other roles)',
            '${c.data!.units.firstOrNull?.id ?? 0}',
            options: [
              for (final u in c.data!.units.where((u) => u.active)) '${u.id}',
            ],
            labels: {for (final u in c.data!.units) '${u.id}': u.callSign},
          ),
      ],
      (v) async {
        created = await c.invite(
          v['email']!,
          recovery?.role ?? v['role']!,
          int.tryParse(v['unit'] ?? ''),
          recovery != null,
        );
        return created != null;
      },
    );
    if (created != null && mounted) {
      final invite = created!;
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(
            invite.recovery ? 'Account recovery code' : 'Invitation ready',
          ),
          content: SizedBox(
            width: 420,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${invite.email} · ${invite.role}\nExpires ${DateFormat('dd MMM, HH:mm').format(invite.expiresAt.toLocal())}',
                ),
                const SizedBox(height: 16),
                SelectableText(invite.token),
                const SizedBox(height: 14),
                const Text(
                  'Share this one-time code privately. The recipient selects “Join with invitation” on the welcome screen.',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: invite.token));
              },
              child: const Text('Copy code'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Done'),
            ),
          ],
        ),
      );
    }
  }

  Widget _settings() => _box('Organization settings', [
    _row(
      c.data!.config?.name ?? 'Manila operations',
      'Automatic dispatch: ${c.data!.config?.autoDispatch == true ? 'Enabled' : 'Disabled'}\nResponse target: ${c.data!.config?.responseTargetMinutes ?? 10} minutes',
      [
        OutlinedButton(
          onPressed: c.busy
              ? null
              : () => showEditor(
                  context,
                  c,
                  'Edit organization settings',
                  [
                    Entry(
                      'name',
                      'Organization name',
                      c.data!.config?.name ?? 'Manila operations',
                      required: true,
                    ),
                    Entry(
                      'auto',
                      'Automatic dispatch',
                      c.data!.config?.autoDispatch == true ? 'true' : 'false',
                      options: const ['true', 'false'],
                    ),
                    Entry(
                      'target',
                      'Response target (minutes)',
                      '${c.data!.config?.responseTargetMinutes ?? 10}',
                      numeric: true,
                    ),
                  ],
                  (v) => c.settings(
                    v['name']!,
                    v['auto'] == 'true',
                    int.parse(v['target']!),
                  ),
                ),
          child: const Text('Edit settings'),
        ),
      ],
      icon: Icons.settings_outlined,
    ),
    if (!c.isDemo)
      OutlinedButton(
        onPressed: c.busy
            ? null
            : () => showEditor(context, c, 'Change your password', [
                Entry(
                  'old',
                  'Current password',
                  '',
                  secret: true,
                  required: true,
                ),
                Entry(
                  'new',
                  'New password (12+ characters)',
                  '',
                  secret: true,
                  required: true,
                ),
              ], (v) => c.changePassword(v['old']!, v['new']!)),
        child: const Text('Change password'),
      ),
    const SizedBox(height: 16),
    const Text(
      'Staff enrollment and recovery use administrator-issued codes. Demo fleet positions are fictional; account workspaces can report device or manual coordinates.',
      style: TextStyle(color: _gray, fontSize: 12, height: 1.6),
    ),
  ]);

  Widget _analytics() {
    final records = c.data!.incidents
        .where(
          (i) =>
              _days == 0 ||
              c.data!.serverTime.difference(i.createdAt).inDays < _days,
        )
        .toList();
    final arrived = records
        .where((i) => i.onSceneAt != null && i.dispatchedAt != null)
        .toList();
    final target = c.data!.config?.responseTargetMinutes ?? 10;
    final compliance = arrived.isEmpty
        ? '—'
        : '${(arrived.where((i) => i.onSceneAt!.difference(i.dispatchedAt!).inSeconds <= target * 60).length / arrived.length * 100).toStringAsFixed(0)}%';
    return _box('Reports & analytics', [
      Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          DropdownButton<int>(
            value: _days,
            items: const [
              DropdownMenuItem(value: 0, child: Text('All records')),
              DropdownMenuItem(value: 7, child: Text('Last 7 days')),
              DropdownMenuItem(value: 30, child: Text('Last 30 days')),
            ],
            onChanged: (v) => setState(() => _days = v!),
          ),
          OutlinedButton.icon(
            onPressed: () => exportIncidentCsv(records),
            icon: const Icon(Icons.table_view),
            label: const Text('Export CSV'),
          ),
          OutlinedButton.icon(
            onPressed: () =>
                exportIncidentPdf(c.data!.copyWith(incidents: records)),
            icon: const Icon(Icons.picture_as_pdf_outlined),
            label: const Text('Export PDF'),
          ),
        ],
      ),
      const SizedBox(height: 20),
      Text(
        'Response target compliance: $compliance',
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
      ),
      const SizedBox(height: 8),
      Text(
        '${arrived.length} recorded scene arrivals · Target $target minutes',
        style: const TextStyle(color: _gray),
      ),
      const SizedBox(height: 24),
      const Text(
        'Incident priority',
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
      const SizedBox(height: 16),
      for (final priority in ['critical', 'urgent', 'normal'])
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$priority · ${records.where((i) => i.severity == priority).length}',
              ),
              const SizedBox(height: 6),
              LinearProgressIndicator(
                value: records.isEmpty
                    ? 0
                    : records.where((i) => i.severity == priority).length /
                          records.length,
                color: priority == 'critical' ? Colors.red : _accent,
                backgroundColor: const Color(0xFFF1F5F9),
                minHeight: 8,
              ),
            ],
          ),
        ),
      const SizedBox(height: 12),
      Text(
        '${records.where((i) => i.status == 'resolved').length} completed · ${records.where((i) => i.status == 'cancelled').length} cancelled · ${records.length} total',
      ),
      const SizedBox(height: 10),
      const Text(
        'Distances are straight-line estimates. Metrics use actual server timestamps from the recorded response actions.',
        style: TextStyle(fontSize: 12, color: _gray),
      ),
    ]);
  }
}

class Entry {
  Entry(
    this.key,
    this.label,
    this.value, {
    this.required = false,
    this.numeric = false,
    this.date = false,
    this.secret = false,
    this.lines = 1,
    this.options,
    this.labels,
  });
  final String key, label, value;
  final bool required, numeric, date, secret;
  final int lines;
  final List<String>? options;
  final Map<String, String>? labels;
}

Future<void> showEditor(
  BuildContext context,
  DispatchController controller,
  String title,
  List<Entry> entries,
  Future<bool> Function(Map<String, String>) save,
) => showDialog<void>(
  context: context,
  builder: (_) => _Editor(
    controller: controller,
    title: title,
    entries: entries,
    save: save,
  ),
);

class _Editor extends StatefulWidget {
  const _Editor({
    required this.controller,
    required this.title,
    required this.entries,
    required this.save,
  });
  final DispatchController controller;
  final String title;
  final List<Entry> entries;
  final Future<bool> Function(Map<String, String>) save;
  @override
  State<_Editor> createState() => _EditorState();
}

class _EditorState extends State<_Editor> {
  final _form = GlobalKey<FormState>();
  late final Map<String, TextEditingController> _values = {
    for (final e in widget.entries) e.key: TextEditingController(text: e.value),
  };
  bool _saving = false;
  String? _error;
  @override
  void dispose() {
    for (final c in _values.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.title),
    content: SizedBox(
      width: 440,
      child: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final e in widget.entries)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: e.options != null
                      ? DropdownButtonFormField<String>(
                          isExpanded: true,
                          initialValue:
                              e.options!.contains(_values[e.key]!.text)
                              ? _values[e.key]!.text
                              : null,
                          decoration: InputDecoration(labelText: e.label),
                          items: e.options!
                              .map(
                                (o) => DropdownMenuItem(
                                  value: o,
                                  child: Text(e.labels?[o] ?? o),
                                ),
                              )
                              .toList(),
                          onChanged: _saving
                              ? null
                              : (v) => _values[e.key]!.text = v ?? '',
                          validator: (v) =>
                              v == null ? 'Choose an option.' : null,
                        )
                      : TextFormField(
                          controller: _values[e.key],
                          enabled: !_saving,
                          obscureText: e.secret,
                          maxLines: e.lines,
                          keyboardType: e.numeric
                              ? const TextInputType.numberWithOptions(
                                  decimal: true,
                                  signed: true,
                                )
                              : TextInputType.text,
                          decoration: InputDecoration(labelText: e.label),
                          validator: (v) {
                            if (e.required && (v?.trim().isEmpty ?? true)) {
                              return 'Required.';
                            }
                            if (e.numeric &&
                                (double.tryParse(v ?? '') == null ||
                                    !double.parse(v!).isFinite)) {
                              return 'Enter a valid number.';
                            }
                            if (e.date && DateTime.tryParse(v ?? '') == null) {
                              return 'Use YYYY-MM-DD.';
                            }
                            return null;
                          },
                        ),
                ),
              if (_error != null)
                Text(
                  _error!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
            ],
          ),
        ),
      ),
    ),
    actions: [
      TextButton(
        onPressed: _saving ? null : () => Navigator.pop(context),
        child: const Text('Back'),
      ),
      FilledButton(
        onPressed: _saving ? null : _submit,
        child: Text(_saving ? 'Saving…' : 'Save'),
      ),
    ],
  );
  Future<void> _submit() async {
    if (!_form.currentState!.validate()) return;
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      final ok = await widget.save({
        for (final e in _values.entries) e.key: e.value.text,
      });
      if (!mounted) return;
      if (ok) {
        Navigator.pop(context);
      } else {
        setState(() {
          _saving = false;
          _error = widget.controller.error ?? 'Could not save.';
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _saving = false;
          _error = 'Check the entered values and try again.';
        });
      }
    }
  }
}

Future<void> showCareEditor(
  BuildContext context,
  DispatchController c,
  DispatchIncident incident,
) async {
  final care = (c.data!.careReports ?? <CareReport>[])
      .where((r) => r.incidentId == incident.id)
      .firstOrNull;
  if (care?.signedOff == true ||
      ['resolved', 'cancelled'].contains(incident.status)) {
    if (care != null) await exportCarePdf(incident, care);
    return;
  }
  await showEditor(
    context,
    c,
    'Patient care · incident #${incident.id}',
    [
      Entry('patient', 'Patient name', care?.patientName ?? ''),
      Entry('age', 'Age', care?.age?.toString() ?? ''),
      Entry('condition', 'Condition', care?.condition ?? '', lines: 2),
      Entry('pulse', 'Pulse', care?.pulse?.toString() ?? ''),
      Entry('systolic', 'Systolic pressure', care?.systolic?.toString() ?? ''),
      Entry(
        'diastolic',
        'Diastolic pressure',
        care?.diastolic?.toString() ?? '',
      ),
      Entry(
        'oxygen',
        'Oxygen saturation (%)',
        care?.oxygenSaturation?.toString() ?? '',
      ),
      Entry('treatment', 'Treatment', care?.treatment ?? '', lines: 2),
      Entry('notes', 'Notes', care?.notes ?? '', lines: 2),
      Entry('handover', 'Receiving staff', care?.handedOverTo ?? ''),
      if (incident.status == 'atHospital')
        Entry(
          'signed',
          'Sign and lock handover',
          'false',
          options: const ['false', 'true'],
        ),
    ],
    (v) => c.saveCareReport(
      CareReport(
        workspaceId: 0,
        incidentId: incident.id!,
        patientName: v['patient']!,
        age: _optionalInt(v['age']),
        condition: v['condition']!,
        pulse: _optionalInt(v['pulse']),
        systolic: _optionalInt(v['systolic']),
        diastolic: _optionalInt(v['diastolic']),
        oxygenSaturation: _optionalInt(v['oxygen']),
        treatment: v['treatment']!,
        notes: v['notes']!,
        handedOverTo: v['handover']!,
        signedOff: v['signed'] == 'true',
        updatedAt: DateTime.now().toUtc(),
      ),
    ),
  );
}

int? _optionalInt(String? text) {
  if (text == null || text.trim().isEmpty) return null;
  return int.parse(text);
}

Future<void> reportDeviceLocation(
  BuildContext context,
  DispatchController c,
  int unitId,
) async {
  try {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw StateError('permission');
    }
    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 15),
      ),
    );
    await c.updateLocation(unitId, position.latitude, position.longitude);
  } catch (_) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Location could not be read. Use manual coordinates in Fleet.',
          ),
        ),
      );
    }
  }
}
