import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> downloadFile(Uint8List bytes, String name, String mime) async {
  if (mime == 'application/pdf') {
    await Printing.sharePdf(bytes: bytes, filename: name);
    return;
  }
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/$name');
  await file.writeAsBytes(bytes);
  await launchUrl(Uri.file(file.path));
}
