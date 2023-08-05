import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:external_path/external_path.dart';
import 'package:get/get.dart';

Future<void> printFileAsPdf(nameFile, function, context) async {
  if (await Permission.storage.request().isGranted) {
    late String fileDir;
    final output = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
    fileDir = '$output/$nameFile' +
        DateTime.now().toIso8601String().replaceAll(":", "") +
        '.pdf';
    final file = File(fileDir);
    await file.writeAsBytes(await Printing.convertHtml(
      format: PdfPageFormat.letter,
      html: function,
    ));

    // OpenFile.open(fileDir);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("File downloaded successfully".tr),
      duration: const Duration(seconds: 5),
      action: SnackBarAction(
        label: 'Open file'.tr,
        textColor: Colors.white,
        onPressed: () {
          OpenFile.open(fileDir);
        },
      ),
    ));
  } else {
    return;
  }
}

Future<String> logoBase64() async {
  ByteData bytes = await rootBundle.load('assets/icons/logo.png');
  var buffer = bytes.buffer;
  String m = base64.encode(Uint8List.view(buffer));
  return m;
}
