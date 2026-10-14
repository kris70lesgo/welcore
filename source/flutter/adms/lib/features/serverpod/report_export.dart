import 'dart:convert';
import 'dart:typed_data';
import 'package:adms_client/adms_client.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'download.dart';

String csvCell(Object? value) {
  var s = value?.toString() ?? '';
  // Prevent spreadsheet formula evaluation in exported user-supplied text.
  if (RegExp(r'^[=+\-@\t\r]').hasMatch(s)) s = "'$s";
  return '"${s.replaceAll('"', '""')}"';
}

String incidentCsv(List<DispatchIncident> records) => [
  [
    'ID',
    'Description',
    'Address',
    'Priority',
    'Status',
    'Unit',
    'Destination',
    'Reported UTC',
    'Dispatched UTC',
    'On scene UTC',
    'Resolved UTC',
  ],
  for (final i in records)
    [
      i.id,
      i.description,
      i.address,
      i.severity,
      i.status,
      i.assignedCallSign,
      i.destinationHospitalName,
      i.createdAt.toIso8601String(),
      i.dispatchedAt?.toIso8601String(),
      i.onSceneAt?.toIso8601String(),
      i.resolvedAt?.toIso8601String(),
    ],
].map((row) => row.map(csvCell).join(',')).join('\r\n');
Future<void> exportIncidentCsv(List<DispatchIncident> records) => downloadFile(
  Uint8List.fromList(utf8.encode(incidentCsv(records))),
  'adms-incidents.csv',
  'text/csv;charset=utf-8',
);
Future<Uint8List> incidentPdfBytes(DispatchSnapshot data) async {
  final document = pw.Document();
  document.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (_) => [
        pw.Header(
          level: 0,
          text: '${data.config?.name ?? 'ADMS'} - incident report',
        ),
        pw.Text(
          'Generated ${data.serverTime.toUtc().toIso8601String()} | ${data.incidents.length} records',
        ),
        pw.SizedBox(height: 18),
        pw.TableHelper.fromTextArray(
          headers: ['ID', 'Priority', 'Status', 'Unit', 'Location'],
          data: [
            for (final i in data.incidents)
              [
                '${i.id}',
                i.severity,
                i.status,
                i.assignedCallSign ?? 'Unassigned',
                i.address,
              ],
          ],
          cellStyle: const pw.TextStyle(fontSize: 9),
        ),
      ],
    ),
  );
  return document.save();
}

Future<void> exportIncidentPdf(DispatchSnapshot data) async => downloadFile(
  await incidentPdfBytes(data),
  'adms-incidents.pdf',
  'application/pdf',
);
Future<Uint8List> carePdfBytes(
  DispatchIncident incident,
  CareReport care,
) async {
  final document = pw.Document();
  document.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (_) => [
        pw.Header(level: 0, text: 'ADMS - Patient Care Report'),
        pw.Text(
          'Incident #${incident.id} | ${incident.assignedCallSign ?? 'Unassigned'}',
        ),
        pw.Text(
          'Destination: ${incident.destinationHospitalName ?? 'Not selected'}',
        ),
        pw.SizedBox(height: 18),
        for (final row in [
          ['Patient', care.patientName],
          ['Age', '${care.age ?? 'Not recorded'}'],
          ['Condition', care.condition],
          ['Pulse', '${care.pulse ?? 'Not recorded'}'],
          [
            'Blood pressure',
            '${care.systolic ?? '-'}/${care.diastolic ?? '-'}',
          ],
          ['Oxygen saturation', '${care.oxygenSaturation ?? 'Not recorded'}'],
          ['Treatment', care.treatment],
          ['Notes', care.notes],
          ['Receiving staff', care.handedOverTo],
          ['Handover', care.signedOff ? 'Signed and locked' : 'Draft'],
        ])
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 12),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  row[0],
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                pw.Text(row[1].isEmpty ? 'Not recorded' : row[1]),
              ],
            ),
          ),
        pw.Text('Last updated: ${care.updatedAt.toUtc().toIso8601String()}'),
      ],
    ),
  );
  return document.save();
}

Future<void> exportCarePdf(DispatchIncident incident, CareReport care) async =>
    downloadFile(
      await carePdfBytes(incident, care),
      'adms-care-${incident.id}.pdf',
      'application/pdf',
    );
