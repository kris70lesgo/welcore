import 'dart:convert';
import 'package:adms_client/adms_client.dart' as pod;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/models/models.dart' as domain;
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/dispatch_map.dart';
import 'dispatch_controller.dart';
import 'account_dialog.dart';
import 'operations_pages.dart';
import 'report_export.dart';

const _navy = AppColors.primaryDark;
const _teal = Color(0xFF008C7D);
const _muted = Color(0xFF64748B);
const _border = Color(0xFFE2E8F0);

class ServerpodDispatchApp extends StatefulWidget {
  const ServerpodDispatchApp({
    super.key,
    required this.controller,
    this.showMap = true,
  });
  final DispatchController controller;
  final bool showMap;
  @override
  State<ServerpodDispatchApp> createState() => _ServerpodDispatchAppState();
}

class _ServerpodDispatchAppState extends State<ServerpodDispatchApp> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'ADMS Dispatch',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      dialogTheme: DialogThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(48, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: const BorderSide(color: _border),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(minimumSize: const Size(48, 48)),
      ),
      fontFamily: 'Manrope',
      scaffoldBackgroundColor: const Color(0xFFF6F8FA),
      colorScheme: ColorScheme.fromSeed(
        seedColor: _teal,
        primary: _teal,
        surface: Colors.white,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _navy),
        bodySmall: TextStyle(color: _muted),
        headlineMedium: TextStyle(fontWeight: FontWeight.w800, color: _navy),
        titleLarge: TextStyle(fontWeight: FontWeight.w800, color: _navy),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF6F8FA),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _border),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ),
    home: DispatchWorkspace(
      controller: widget.controller,
      showMap: widget.showMap,
    ),
  );
}

class DispatchWorkspace extends StatefulWidget {
  const DispatchWorkspace({
    super.key,
    required this.controller,
    this.showMap = true,
  });
  final DispatchController controller;
  final bool showMap;
  @override
  State<DispatchWorkspace> createState() => _DispatchWorkspaceState();
}

class _DispatchWorkspaceState extends State<DispatchWorkspace> {
  int _page = 0;
  int? _selectedId;
  bool _showClosed = false;
  String _query = '';
  int _lastSeenRevision = 0;
  List<(int, IconData, String)> get _navigation => [
    (
      0,
      Icons.radar,
      c.role == 'citizen'
          ? 'My incidents'
          : c.role == 'crew'
          ? 'My responses'
          : 'Dispatch desk',
    ),
    if (c.role != 'citizen')
      (
        1,
        Icons.airport_shuttle_outlined,
        c.role == 'crew' ? 'My unit' : 'Fleet status',
      ),
    (2, Icons.history, 'Activity log'),
    if (c.canDispatch) (3, Icons.bar_chart, 'Reports & analytics'),
    if (c.role == 'admin') (4, Icons.people_outline, 'Members'),
    if (c.canDispatch) (5, Icons.local_hospital_outlined, 'Hospitals'),
    if (c.canDispatch) (6, Icons.build_outlined, 'Maintenance'),
    if (c.role == 'admin') (7, Icons.settings_outlined, 'Settings'),
  ];
  DispatchController get c => widget.controller;

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: c,
    builder: (context, _) {
      if (c.data == null) return _welcome();
      if (!_navigation.any((item) => item.$1 == _page)) _page = 0;
      if (_page == 2) _lastSeenRevision = c.data!.revision;
      final wide = MediaQuery.sizeOf(context).width >= 1050;
      return Scaffold(
        body: Row(
          children: [
            if (wide) _sidebar(),
            Expanded(
              child: Column(
                children: [
                  _header(wide),
                  if (!c.online) _connectionBanner(),
                  if (c.error != null) _errorBanner(),
                  if (!wide)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              key: ValueKey(_page),
                              initialValue: _page,
                              isExpanded: true,
                              decoration: const InputDecoration(
                                labelText: 'Section',
                                isDense: true,
                              ),
                              items: [
                                for (final item in _navigation)
                                  DropdownMenuItem(
                                    value: item.$1,
                                    child: Text(
                                      item.$1 == 0
                                          ? 'Dispatch'
                                          : item.$1 == 1
                                          ? 'Fleet'
                                          : item.$1 == 2
                                          ? 'Activity'
                                          : item.$3,
                                    ),
                                  ),
                              ],
                              onChanged: (value) =>
                                  setState(() => _page = value!),
                            ),
                          ),
                        ],
                      ),
                    ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(wide ? 28 : 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _pageHeading(),
                          const SizedBox(height: 22),
                          _metrics(),
                          const SizedBox(height: 24),
                          if (_page == 0)
                            _dispatchDesk(wide)
                          else if (_page == 2)
                            _activity()
                          else
                            OperationsPages(controller: c, page: _page),
                          const SizedBox(height: 24),
                          Text(
                            c.isDemo
                                ? 'SIMULATION WORKSPACE  ·  Fictional fleet and incidents  ·  Powered by Serverpod'
                                : '${c.data!.viewer?.name ?? ''} · ${c.role} · Powered by Serverpod',
                            style: TextStyle(
                              fontSize: 12,
                              letterSpacing: 1.2,
                              color: _muted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );

  Widget _welcome() => Scaffold(
    body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: _panel(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _brand(dark: false),
                const SizedBox(height: 40),
                const _Tag(text: 'SERVERPOD HACKATHON · 2026', color: _teal),
                const SizedBox(height: 20),
                const Text(
                  'Every response\nstarts with a clear plan.',
                  style: TextStyle(
                    fontSize: 36,
                    height: 1.15,
                    fontWeight: FontWeight.w800,
                    color: _navy,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'One dispatch desk. A ready crew. A complete response.\nReport an incident, assign the nearest ambulance, and follow the response through hospital handover.',
                  style: TextStyle(height: 1.7, color: _muted, fontSize: 15),
                ),
                const SizedBox(height: 24),
                for (final (icon, text) in [
                  (
                    Icons.storage_outlined,
                    'Real records, stored in PostgreSQL',
                  ),
                  (
                    Icons.near_me_outlined,
                    'Server-side nearest-unit assignment',
                  ),
                  (Icons.sync, 'Live updates across browser windows'),
                ])
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: Row(
                      children: [
                        Icon(icon, size: 20, color: _teal),
                        const SizedBox(width: 12),
                        Expanded(child: Text(text)),
                      ],
                    ),
                  ),
                const SizedBox(height: 18),
                if (c.error != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      c.error!,
                      style: const TextStyle(color: AppColors.critical),
                    ),
                  ),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: c.loading
                        ? null
                        : c.token == null
                        ? c.startDemo
                        : c.connect,
                    icon: c.loading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.arrow_forward),
                    label: Text(
                      c.loading
                          ? 'Connecting to Serverpod…'
                          : c.token == null
                          ? 'Start dispatch demo'
                          : 'Reconnect to workspace',
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    OutlinedButton(
                      onPressed: c.loading ? null : () => _account('login'),
                      child: const Text('Sign in'),
                    ),
                    OutlinedButton(
                      onPressed: c.loading
                          ? null
                          : () => _account('organization'),
                      child: const Text('Create organization'),
                    ),
                    TextButton(
                      onPressed: c.loading
                          ? null
                          : () => _account('invitation'),
                      child: const Text('Join with invitation'),
                    ),
                  ],
                ),
                if (c.token != null)
                  TextButton(
                    onPressed: c.loading ? null : c.leaveDemo,
                    child: const Text('Leave expired workspace'),
                  ),
                const SizedBox(height: 16),
                const Text(
                  'A private demo with three fictional ambulances. Your workspace stays available for 24 hours. This simulation does not send emergency requests.',
                  style: TextStyle(fontSize: 12, color: _muted, height: 1.5),
                ),
              ],
            ),
            padding: 32,
          ),
        ),
      ),
    ),
  );

  Widget _brand({required bool dark}) => Row(
    children: [
      Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: _teal,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      const SizedBox(width: 12),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ADMS',
            style: TextStyle(
              color: dark ? Colors.white : _navy,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
            ),
          ),
          Text(
            'DISPATCH',
            style: TextStyle(
              color: dark ? Colors.white54 : _muted,
              fontSize: 12,
              letterSpacing: 2.5,
            ),
          ),
        ],
      ),
    ],
  );

  Widget _sidebar() => Container(
    width: 220,
    color: _navy,
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        _brand(dark: true),
        const SizedBox(height: 28),
        const Text(
          'OPERATIONS',
          style: TextStyle(
            color: Colors.white38,
            fontSize: 12,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (final item in _navigation)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Material(
                      color: _page == item.$1
                          ? const Color(0xFF28415D)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => setState(() => _page = item.$1),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 14,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                item.$2,
                                color: _page == item.$1
                                    ? const Color(0xFF59D8BF)
                                    : Colors.white54,
                                size: 19,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  item.$3,
                                  style: TextStyle(
                                    color: _page == item.$1
                                        ? Colors.white
                                        : Colors.white60,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          c.data!.viewer?.name ?? 'Demo administrator',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          c.isDemo ? 'Private simulation' : c.role.toUpperCase(),
          style: const TextStyle(color: Colors.white54, fontSize: 10),
        ),
        TextButton.icon(
          onPressed: c.busy
              ? null
              : () async {
                  await c.leaveDemo();
                  if (mounted) setState(() => _selectedId = null);
                },
          icon: const Icon(Icons.logout, size: 16, color: Colors.white54),
          label: Text(
            c.isDemo ? 'Leave demo' : 'Sign out',
            style: const TextStyle(color: Colors.white54, fontSize: 11),
          ),
        ),
        const Text(
          'Built with Serverpod',
          style: TextStyle(color: Color(0xFF59D8BF), fontSize: 10),
        ),
      ],
    ),
  );

  Future<void> _account(String mode) async {
    await showDialog<bool>(
      context: context,
      builder: (_) => AccountDialog(controller: c, mode: mode),
    );
    if (mounted) setState(() => _page = 0);
  }

  Widget _header(bool wide) => Container(
    padding: EdgeInsets.symmetric(horizontal: wide ? 28 : 16, vertical: 18),
    decoration: const BoxDecoration(
      color: Colors.white,
      border: Border(bottom: BorderSide(color: _border)),
    ),
    child: Row(
      children: [
        if (!wide) ...[
          const Icon(Icons.add_box, color: _teal),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: Text(
            c.data!.config?.name ?? 'Manila operations',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          ),
        ),
        _Tag(
          text: c.live
              ? '● LIVE'
              : c.online
              ? '● SYNCING'
              : '● OFFLINE',
          color: c.online ? _teal : AppColors.critical,
        ),
        const SizedBox(width: 10),
        Tooltip(
          message: 'Refresh from Serverpod',
          child: IconButton(
            onPressed: c.busy ? null : c.refresh,
            icon: const Icon(Icons.refresh, size: 20),
          ),
        ),
        Tooltip(
          message: 'Response notifications',
          child: IconButton(
            tooltip: 'Response notifications',
            onPressed: () => setState(() {
              _page = 2;
              _lastSeenRevision = c.data!.revision;
            }),
            icon: Badge(
              isLabelVisible: c.data!.revision > _lastSeenRevision,
              label: Text('${c.data!.revision - _lastSeenRevision}'),
              child: const Icon(Icons.notifications_none, size: 20),
            ),
          ),
        ),
        if (wide) ...[
          const SizedBox(width: 8),
          const CircleAvatar(
            radius: 17,
            backgroundColor: Color(0xFFF0F5F5),
            child: Icon(Icons.headset_mic_outlined, size: 18, color: _teal),
          ),
        ],
        if (!wide)
          PopupMenuButton<String>(
            enabled: !c.busy,
            onSelected: (_) => c.leaveDemo(),
            itemBuilder: (_) => [
              const PopupMenuItem(value: 'leave', child: Text('Leave demo')),
            ],
          ),
      ],
    ),
  );

  Widget _pageHeading() => Wrap(
    alignment: WrapAlignment.spaceBetween,
    crossAxisAlignment: WrapCrossAlignment.center,
    spacing: 20,
    runSpacing: 16,
    children: [
      SizedBox(
        width: 430,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _navigation.firstWhere((item) => item.$1 == _page).$3,
              style: const TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w800,
                color: _navy,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              c.role == 'citizen'
                  ? 'Report and track your own requests.'
                  : c.role == 'crew'
                  ? 'Your assigned responses and patient handovers.'
                  : 'Coordinate your organization, fleet, and responses.',
              style: const TextStyle(color: _muted, fontSize: 12),
            ),
          ],
        ),
      ),
      if (c.canReport)
        FilledButton.icon(
          key: const Key('report-incident'),
          onPressed: c.busy || !c.online ? null : _reportDialog,
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Report incident'),
        ),
    ],
  );

  Widget _metrics() {
    final data = c.data!;
    final available = data.units.where((u) => u.status == 'available').length;
    final active = data.incidents.where((i) => !_closed(i)).length;
    final completed = data.incidents
        .where((i) => i.status == 'resolved')
        .length;
    final responses = data.incidents
        .where((i) => i.onSceneAt != null && i.dispatchedAt != null)
        .toList();
    final average = responses.isEmpty
        ? '—'
        : '${(responses.map((i) => i.onSceneAt!.difference(i.dispatchedAt!).inSeconds).reduce((a, b) => a + b) / responses.length / 60).toStringAsFixed(1)} min';
    final cards = [
      (
        Icons.airport_shuttle_outlined,
        '$available / ${data.units.length}',
        'Units available',
        'Ready for assignment',
        _teal,
      ),
      (
        Icons.radar,
        '$active',
        'Open incidents',
        'Awaiting or in response',
        AppColors.primary,
      ),
      (
        Icons.task_alt,
        '$completed',
        'Responses completed',
        'Hospital handover finished',
        _teal,
      ),
      (
        Icons.timer_outlined,
        average,
        'Average response',
        'Dispatch → arrival at scene',
        AppColors.primary,
      ),
    ];
    return LayoutBuilder(
      builder: (_, constraints) {
        final count = constraints.maxWidth >= 780
            ? 4
            : constraints.maxWidth >= 450
            ? 2
            : 1;
        final width = (constraints.maxWidth - (count - 1) * 12) / count;
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: cards
              .map(
                (card) => SizedBox(
                  width: width,
                  child: _panel(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                card.$3.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  letterSpacing: .9,
                                  color: _muted,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Icon(card.$1, size: 18, color: card.$5),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Text(
                          card.$2,
                          style: const TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          card.$4,
                          style: const TextStyle(fontSize: 12, color: _muted),
                        ),
                      ],
                    ),
                    padding: 18,
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }

  Widget _dispatchDesk(bool wide) {
    final selected = _selected;
    final primary = Column(
      children: [_map(), const SizedBox(height: 20), _queue()],
    );
    final secondary = Column(
      children: [
        _details(selected),
        const SizedBox(height: 20),
        _fleet(compact: true),
      ],
    );
    if (!wide) {
      return Column(
        children: c.role == 'crew'
            ? [secondary, const SizedBox(height: 20), primary]
            : [primary, const SizedBox(height: 20), secondary],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: primary),
        const SizedBox(width: 20),
        SizedBox(width: 310, child: secondary),
      ],
    );
  }

  Widget _map() => Container(
    decoration: BoxDecoration(
      border: Border.all(color: _border),
      borderRadius: BorderRadius.circular(16),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
          child: Row(
            children: [
              const Icon(Icons.public, size: 18, color: _teal),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Live coverage',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                ),
              ),
              Text(
                '${c.data!.units.length} units',
                style: const TextStyle(fontSize: 12, color: _muted),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).width < 700 ? 260 : 330,
          child: widget.showMap
              ? DispatchMapWidget(
                  incidents: c.data!.incidents
                      .where((i) => !_closed(i))
                      .map(_mapIncident)
                      .toList(),
                  units: c.data!.units.map(_mapUnit).toList(),
                  centerLatitude: 14.5995,
                  centerLongitude: 120.9842,
                  initialZoom: 13,
                  onIncidentTap: (incident) =>
                      setState(() => _selectedId = int.parse(incident.id)),
                )
              : const ColoredBox(
                  color: Color(0xFFE7EFED),
                  child: Center(child: Text('Map preview')),
                ),
        ),
      ],
    ),
  );

  Widget _queue() {
    final incidents = c.data!.incidents
        .where((i) => _showClosed ? _closed(i) : !_closed(i))
        .toList();
    incidents.removeWhere(
      (i) =>
          !('${i.id} ${i.description} ${i.address} ${i.assignedCallSign ?? ''}')
              .toLowerCase()
              .contains(_query.toLowerCase().trim()),
    );
    int rank(String s) => s == 'critical'
        ? 0
        : s == 'urgent'
        ? 1
        : 2;
    incidents.sort(
      (a, b) => rank(a.severity) != rank(b.severity)
          ? rank(a.severity).compareTo(rank(b.severity))
          : a.createdAt.compareTo(b.createdAt),
    );
    return _panel(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 16,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Incident queue',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF5F2),
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: const Color(0xFFD1E8E2)),
                    ),
                    child: Text(
                      '${incidents.length}',
                      style: const TextStyle(
                        color: _teal,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              SegmentedButton<bool>(
                style: const ButtonStyle(visualDensity: VisualDensity.compact),
                segments: const [
                  ButtonSegment(value: false, label: Text('Active')),
                  ButtonSegment(value: true, label: Text('Closed')),
                ],
                selected: {_showClosed},
                onSelectionChanged: (s) =>
                    setState(() => _showClosed = s.first),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Search incidents',
              prefixIcon: Icon(Icons.search),
              isDense: true,
            ),
            onChanged: (value) => setState(() => _query = value),
          ),
          const SizedBox(height: 16),
          if (incidents.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      _showClosed ? Icons.task_alt : Icons.radar,
                      size: 32,
                      color: _teal,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _showClosed
                          ? 'No closed responses yet.'
                          : 'The queue is clear.',
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _showClosed
                          ? 'Completed and cancelled incidents appear here.'
                          : 'Report an incident to begin a response.',
                      style: const TextStyle(color: _muted, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),
          for (final incident in incidents)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Material(
                color: _selected?.id == incident.id
                    ? const Color(0xFFEDF7F4)
                    : const Color(0xFFF7F9FB),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: _selected?.id == incident.id
                        ? _teal.withValues(alpha: .4)
                        : Colors.transparent,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  key: Key('incident-${incident.id}'),
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => setState(() => _selectedId = incident.id),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 4,
                          height: 48,
                          decoration: BoxDecoration(
                            color: _priorityColor(incident.severity),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                incident.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                incident.address,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: _muted,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 6,
                                children: [
                                  _Tag(
                                    text: incident.severity.toUpperCase(),
                                    color: _priorityColor(incident.severity),
                                  ),
                                  _Tag(
                                    text: _statusLabel(incident.status),
                                    color: _teal,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          DateFormat(
                            'HH:mm',
                          ).format(incident.createdAt.toLocal()),
                          style: const TextStyle(fontSize: 12, color: _muted),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  pod.DispatchIncident? get _selected {
    final list = c.data?.incidents ?? [];
    for (final incident in list) {
      if (incident.id == _selectedId) return incident;
    }
    for (final incident in list) {
      if (!_closed(incident)) return incident;
    }
    return null;
  }

  Widget _details(pod.DispatchIncident? incident) => _panel(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Response details',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
        ),
        const SizedBox(height: 18),
        if (incident == null) ...[
          const Icon(Icons.touch_app_outlined, color: _muted, size: 32),
          const SizedBox(height: 12),
          const Text(
            'Select an incident',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          const Text(
            'Review its location, assign a crew, and follow the response here.',
            style: TextStyle(fontSize: 12, color: _muted, height: 1.6),
          ),
        ] else ...[
          Wrap(
            spacing: 8,
            children: [
              _Tag(
                text: '#${incident.id.toString().padLeft(4, '0')}',
                color: _muted,
              ),
              _Tag(
                text: incident.severity.toUpperCase(),
                color: _priorityColor(incident.severity),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            incident.description,
            style: const TextStyle(
              fontSize: 16,
              height: 1.4,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_on_outlined, size: 16, color: _muted),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  incident.address,
                  style: const TextStyle(fontSize: 12, color: _muted),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: _border),
          const SizedBox(height: 12),
          const Text(
            'ASSIGNED UNIT',
            style: TextStyle(fontSize: 12, letterSpacing: 1, color: _muted),
          ),
          const SizedBox(height: 8),
          Text(
            incident.assignedCallSign ?? 'Awaiting assignment',
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
          ),
          if (incident.dispatchDistanceKm != null) ...[
            const SizedBox(height: 6),
            Text(
              '${incident.dispatchDistanceKm!.toStringAsFixed(2)} km straight-line distance',
              style: const TextStyle(fontSize: 12, color: _muted),
            ),
          ],
          const SizedBox(height: 20),
          if (c.canRespond &&
              !_closed(incident) &&
              (c.data!.hospitals ?? []).isNotEmpty) ...[
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              key: ValueKey(
                'destination-${incident.id}-${incident.destinationHospitalId}',
              ),
              isExpanded: true,
              initialValue: incident.destinationHospitalId,
              decoration: const InputDecoration(
                labelText: 'Receiving hospital',
                isDense: true,
              ),
              items: [
                for (final h in c.data!.hospitals!.where(
                  (h) => h.active || h.id == incident.destinationHospitalId,
                ))
                  DropdownMenuItem(
                    value: h.id,
                    child: Text(h.name, overflow: TextOverflow.ellipsis),
                  ),
              ],
              onChanged: c.busy || incident.status == 'atHospital'
                  ? null
                  : (value) => c.setDestination(incident.id!, value!),
            ),
          ],
          if (c.canRespond &&
              [
                'onScene',
                'transporting',
                'atHospital',
                'resolved',
              ].contains(incident.status)) ...[
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: c.busy
                  ? null
                  : () => showCareEditor(context, c, incident),
              icon: const Icon(Icons.assignment_outlined, size: 16),
              label: Text(
                (c.data!.careReports ?? []).any(
                      (r) => r.incidentId == incident.id && r.signedOff,
                    )
                    ? 'Download signed care report'
                    : 'Patient care & handover',
              ),
            ),
            if ((c.data!.careReports ?? []).any(
              (r) => r.incidentId == incident.id,
            ))
              TextButton(
                onPressed: () => exportCarePdf(
                  incident,
                  c.data!.careReports!.firstWhere(
                    (r) => r.incidentId == incident.id,
                  ),
                ),
                child: const Text('Export care PDF'),
              ),
          ],
          if (c.role == 'crew' && c.data!.viewer?.assignedUnitId != null) ...[
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: c.busy
                  ? null
                  : () => reportDeviceLocation(
                      context,
                      c,
                      c.data!.viewer!.assignedUnitId!,
                    ),
              icon: const Icon(Icons.my_location, size: 16),
              label: const Text('Report device location'),
            ),
          ],
          _timeline(incident),
          const SizedBox(height: 20),
          if (!_closed(incident) &&
              (incident.status == 'pending' ? c.canDispatch : c.canRespond))
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                key: const Key('advance-response'),
                onPressed: c.busy || !c.online
                    ? null
                    : () => incident.status == 'pending'
                          ? c.dispatchNearest(incident.id!)
                          : c.advance(incident),
                icon: c.busy
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Icon(
                        incident.status == 'pending'
                            ? Icons.near_me
                            : Icons.arrow_forward,
                        size: 18,
                      ),
                label: Text(
                  _actionLabel(incident.status),
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
          if (!_closed(incident) &&
              (c.canDispatch ||
                  (c.role == 'citizen' && incident.status == 'pending')))
            Center(
              child: TextButton(
                onPressed: c.busy || !c.online
                    ? null
                    : () => _cancelDialog(incident),
                child: const Text(
                  'Cancel incident',
                  style: TextStyle(color: _muted, fontSize: 11),
                ),
              ),
            ),
          if (_closed(incident))
            _Tag(
              text: _statusLabel(incident.status),
              color: incident.status == 'resolved' ? _teal : _muted,
            ),
          const SizedBox(height: 8),
          const Text(
            'Updates are validated and saved by Serverpod.',
            style: TextStyle(fontSize: 12, color: _muted, height: 1.5),
          ),
        ],
      ],
    ),
  );

  Widget _timeline(pod.DispatchIncident incident) {
    const steps = [
      'pending',
      'dispatched',
      'enRoute',
      'onScene',
      'transporting',
      'atHospital',
      'resolved',
    ];
    final current = steps.indexOf(incident.status);
    return Column(
      children: [
        for (var index = 0; index < steps.length; index++)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Icon(
                  index <= current ? Icons.check_circle : Icons.circle_outlined,
                  color: index <= current ? _teal : _border,
                  size: 16,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _statusLabel(steps[index]),
                    style: TextStyle(
                      fontSize: 12,
                      color: index <= current ? _navy : _muted,
                      fontWeight: index == current
                          ? FontWeight.w800
                          : FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _fleet({bool compact = false}) => _panel(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          compact ? 'Fleet readiness' : 'Ambulance units',
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
        ),
        const SizedBox(height: 8),
        Text(
          c.isDemo
              ? 'Positions are simulated for this demo.'
              : 'Last reported unit positions.',
          style: TextStyle(fontSize: 12, color: _muted),
        ),
        const SizedBox(height: 18),
        for (final unit in c.data!.units)
          Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: unit.status == 'available'
                        ? const Color(0xFFEBF7F1)
                        : const Color(0xFFF1F4F8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.airport_shuttle_outlined,
                    size: 21,
                    color: unit.status == 'available'
                        ? _teal
                        : AppColors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        unit.callSign,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        compact ? _statusLabel(unit.status) : unit.crew,
                        style: const TextStyle(fontSize: 12, color: _muted),
                      ),
                    ],
                  ),
                ),
                if (compact)
                  Icon(
                    Icons.circle,
                    size: 8,
                    color: unit.status == 'available'
                        ? _teal
                        : AppColors.urgent,
                  )
                else
                  _Tag(
                    text: _statusLabel(unit.status),
                    color: unit.status == 'available'
                        ? _teal
                        : AppColors.primary,
                  ),
              ],
            ),
          ),
      ],
    ),
  );

  Widget _activity() => _panel(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Response timeline',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        const Text(
          'The latest 100 events in your workspace. All times shown in your local timezone.',
          style: TextStyle(fontSize: 12, color: _muted),
        ),
        const SizedBox(height: 24),
        if (c.data!.events.isEmpty)
          const Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              'No activity yet. Report your first incident to get started.',
            ),
          ),
        for (final event in c.data!.events)
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.check_circle_outline, size: 18, color: _teal),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.message,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Incident #${event.incidentId} · ${DateFormat('dd MMM, HH:mm:ss').format(event.createdAt.toLocal())}',
                        style: const TextStyle(fontSize: 12, color: _muted),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );

  Widget _connectionBanner() => Container(
    color: const Color(0xFFFFF3DD),
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    child: const Text(
      'Connection interrupted. Displaying the last saved state; reconnect before making changes.',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 12),
    ),
  );
  Widget _errorBanner() => Material(
    color: const Color(0xFFFEECEC),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 4, 4),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: AppColors.critical, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              c.error!,
              style: const TextStyle(fontSize: 12, color: AppColors.critical),
            ),
          ),
          TextButton(onPressed: c.refresh, child: const Text('Refresh')),
          IconButton(
            onPressed: c.clearError,
            icon: const Icon(Icons.close, size: 16),
          ),
        ],
      ),
    ),
  );

  Future<void> _reportDialog() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => _ReportDialog(controller: c),
    );
    if (result == true && mounted) {
      setState(() {
        _page = 0;
        _showClosed = false;
        _selectedId = c.data!.incidents.first.id;
      });
    }
  }

  Future<void> _cancelDialog(pod.DispatchIncident incident) async {
    final reason = TextEditingController();
    final form = GlobalKey<FormState>();
    final accepted = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Cancel this incident?'),
        content: SizedBox(
          width: 360,
          child: Form(
            key: form,
            child: TextFormField(
              controller: reason,
              maxLength: 200,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Reason for cancellation',
              ),
              validator: (v) => (v?.trim().length ?? 0) < 3
                  ? 'Enter a reason of at least 3 characters.'
                  : null,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Keep incident'),
          ),
          FilledButton(
            onPressed: () {
              if (form.currentState!.validate()) {
                Navigator.pop(dialogContext, true);
              }
            },
            child: const Text('Confirm cancellation'),
          ),
        ],
      ),
    );
    final text = reason.text;
    reason.dispose();
    if (accepted == true) await c.cancel(incident.id!, text);
  }

  domain.Incident _mapIncident(pod.DispatchIncident i) => domain.Incident(
    id: '${i.id}',
    municipalityId: '${i.workspaceId}',
    description: i.description,
    severity: domain.IncidentSeverity.values.byName(i.severity),
    status: domain.IncidentStatus.values.byName(i.status),
    incidentType: 'medical',
    latitude: i.latitude,
    longitude: i.longitude,
    address: i.address,
    createdAt: i.createdAt,
    assignedUnitId: i.assignedUnitId?.toString(),
    assignedUnitCallSign: i.assignedCallSign,
  );
  domain.AmbulanceUnit _mapUnit(pod.DispatchUnit u) => domain.AmbulanceUnit(
    id: '${u.id}',
    municipalityId: '${u.workspaceId}',
    callSign: u.callSign,
    plateNumber: 'DEMO',
    type: domain.UnitType.als,
    status: u.status == 'dispatched'
        ? domain.UnitStatus.enRoute
        : domain.UnitStatus.values.byName(u.status),
    assignedDriverName: u.crew,
    latitude: u.latitude,
    longitude: u.longitude,
    createdAt: c.data!.serverTime,
  );
}

class _ReportDialog extends StatefulWidget {
  const _ReportDialog({required this.controller});
  final DispatchController controller;
  @override
  State<_ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<_ReportDialog> {
  final _form = GlobalKey<FormState>();
  final _description = TextEditingController();
  final _address = TextEditingController();
  final _latitude = TextEditingController(text: '14.5998');
  final _longitude = TextEditingController(text: '120.9850');
  String _severity = 'urgent';
  bool _saving = false;
  String? _error;
  String get _draftKey =>
      'adms.intake.${widget.controller.data?.viewer?.workspaceId ?? 0}.${widget.controller.data?.viewer?.id ?? widget.controller.token}';
  @override
  void initState() {
    super.initState();
    final stored = widget.controller.preferences?.getString(_draftKey);
    if (stored != null) {
      try {
        final v = jsonDecode(stored) as Map<String, dynamic>;
        _description.text = v['description'] as String? ?? '';
        _address.text = v['address'] as String? ?? '';
        _latitude.text = v['latitude'] as String? ?? '14.5998';
        _longitude.text = v['longitude'] as String? ?? '120.9850';
        final severity = v['severity'] as String?;
        _severity = ['critical', 'urgent', 'normal'].contains(severity)
            ? severity!
            : 'urgent';
      } catch (_) {
        /* Ignore an invalid local draft. */
      }
    }
    for (final field in [_description, _address, _latitude, _longitude]) {
      field.addListener(_saveDraft);
    }
  }

  void _saveDraft() {
    widget.controller.preferences?.setString(
      _draftKey,
      jsonEncode({
        'description': _description.text,
        'address': _address.text,
        'latitude': _latitude.text,
        'longitude': _longitude.text,
        'severity': _severity,
      }),
    );
  }

  @override
  void dispose() {
    _description.dispose();
    _address.dispose();
    _latitude.dispose();
    _longitude.dispose();
    super.dispose();
  }

  void _example() => setState(() {
    _description.text = 'Road collision · person needs assistance';
    _address.text = 'Near Manila City Hall';
    _latitude.text = '14.5998';
    _longitude.text = '120.9850';
    _severity = 'urgent';
  });
  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('Report an incident'),
    content: SizedBox(
      width: 440,
      child: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'This report is saved to your simulation workspace.',
                style: TextStyle(fontSize: 12, color: _muted),
              ),
              TextButton.icon(
                onPressed: _saving ? null : _example,
                icon: const Icon(Icons.auto_awesome_outlined, size: 16),
                label: const Text('Fill example incident'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                key: const Key('incident-description'),
                controller: _description,
                maxLength: 1000,
                maxLines: 2,
                enabled: !_saving,
                decoration: const InputDecoration(
                  labelText: 'What happened?',
                  hintText: 'Describe the situation',
                ),
                validator: (v) => (v?.trim().length ?? 0) < 8
                    ? 'Use at least 8 characters.'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                key: const Key('incident-address'),
                controller: _address,
                maxLength: 200,
                enabled: !_saving,
                decoration: const InputDecoration(
                  labelText: 'Address or landmark',
                ),
                validator: (v) =>
                    (v?.trim().length ?? 0) < 3 ? 'Enter a location.' : null,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _latitude,
                      enabled: !_saving,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                        signed: true,
                      ),
                      decoration: const InputDecoration(labelText: 'Latitude'),
                      validator: (v) => _coordinate(v, 90),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _longitude,
                      enabled: !_saving,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                        signed: true,
                      ),
                      decoration: const InputDecoration(labelText: 'Longitude'),
                      validator: (v) => _coordinate(v, 180),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                initialValue: _severity,
                key: ValueKey(_severity),
                decoration: const InputDecoration(labelText: 'Priority'),
                items: const [
                  DropdownMenuItem(value: 'critical', child: Text('Critical')),
                  DropdownMenuItem(value: 'urgent', child: Text('Urgent')),
                  DropdownMenuItem(value: 'normal', child: Text('Normal')),
                ],
                onChanged: _saving
                    ? null
                    : (value) => setState(() => _severity = value!),
              ),
              if (_error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    _error!,
                    style: const TextStyle(
                      color: AppColors.critical,
                      fontSize: 12,
                    ),
                  ),
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
        child: Text(_saving ? 'Saving…' : 'Create incident'),
      ),
    ],
  );
  String? _coordinate(String? value, double max) {
    final number = double.tryParse(value ?? '');
    return number == null || !number.isFinite || number.abs() > max
        ? 'Enter −${max.toInt()} to ${max.toInt()}.'
        : null;
  }

  Future<void> _submit() async {
    if (!_form.currentState!.validate()) return;
    setState(() {
      _saving = true;
      _error = null;
    });
    final success = await widget.controller.report(
      _description.text,
      _address.text,
      double.parse(_latitude.text),
      double.parse(_longitude.text),
      _severity,
    );
    if (!mounted) return;
    if (success) {
      await widget.controller.preferences?.remove(_draftKey);
      if (!mounted) return;
      Navigator.pop(context, true);
    } else {
      setState(() {
        _saving = false;
        _error = widget.controller.error;
      });
    }
  }
}

Widget _panel(Widget child, {double padding = 20}) => Container(
  width: double.infinity,
  padding: EdgeInsets.all(padding),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: _border),
  ),
  child: child,
);

class _Tag extends StatelessWidget {
  const _Tag({required this.text, required this.color});
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
    decoration: BoxDecoration(
      color: color.withValues(alpha: .08),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 12,
        fontWeight: FontWeight.w800,
        letterSpacing: .3,
      ),
    ),
  );
}

bool _closed(pod.DispatchIncident i) =>
    i.status == 'resolved' || i.status == 'cancelled';
Color _priorityColor(String severity) => severity == 'critical'
    ? AppColors.critical
    : severity == 'urgent'
    ? AppColors.urgentDark
    : _teal;
String _statusLabel(String status) => switch (status) {
  'pending' => 'Reported',
  'dispatched' => 'Dispatched',
  'enRoute' => 'En route',
  'onScene' => 'On scene',
  'transporting' => 'Transporting',
  'atHospital' => 'At hospital',
  'resolved' => 'Completed',
  'cancelled' => 'Cancelled',
  'available' => 'Available',
  _ => status,
};
String _actionLabel(String status) => switch (status) {
  'pending' => 'Dispatch nearest unit',
  'dispatched' => 'Start response',
  'enRoute' => 'Arrived at scene',
  'onScene' => 'Transport patient',
  'transporting' => 'Arrived at hospital',
  'atHospital' => 'Complete handover',
  _ => 'Response complete',
};
