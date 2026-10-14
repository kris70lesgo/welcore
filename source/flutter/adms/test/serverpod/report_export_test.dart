import 'dart:convert';
import 'package:adms/features/serverpod/report_export.dart';
import 'package:adms_client/adms_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'fake_gateway.dart';

void main() {
  test('CSV quotes commas and escapes embedded quotes', () {
    expect(csvCell('Manila, "test"'), '"Manila, ""test"""');
  });
  test('CSV prevents formula injection', () {
    for (final text in [
      '=HYPERLINK("test")',
      '+SUM(1,2)',
      '@SUM(1,2)',
      '-1+1',
    ]) {
      expect(csvCell(text), startsWith('"\''));
    }
  });
  test('incident export contains real visible records and timestamps', () {
    final data = exampleSnapshot(withIncident: true);
    final csv = incidentCsv(data.incidents);
    expect(csv, contains('Road collision needs assistance'));
    expect(csv, contains('2026-10-14T00:00:00.000Z'));
  });
  test('incident and care reports produce valid PDF files', () async {
    final data = exampleSnapshot(withIncident: true);
    expect(
      utf8.decode((await incidentPdfBytes(data)).take(5).toList()),
      '%PDF-',
    );
    final care = CareReport(
      workspaceId: 1,
      incidentId: 11,
      patientName: 'Test patient',
      condition: 'Stable',
      treatment: 'Recorded treatment',
      notes: 'Test only',
      handedOverTo: 'Nurse',
      signedOff: true,
      updatedAt: DateTime.now().toUtc(),
    );
    expect(
      utf8.decode(
        (await carePdfBytes(data.incidents.single, care)).take(5).toList(),
      ),
      '%PDF-',
    );
  });
}
