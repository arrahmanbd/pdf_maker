import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_maker/pdf_maker.dart';

import 'invoice_demo.dart';
import 'doc_demo.dart';

void main() {
  runApp(const MaterialApp(home: PDFMakerExample()));
}

class PDFMakerExample extends StatelessWidget {
  const PDFMakerExample({super.key});

  void saveAndOpen(Uint8List file) async {
    final location = await getTemporaryDirectory();
    final path = '${location.path}/pdf_maker.pdf';
    final pdfFile = File(path);
    await pdfFile.writeAsBytes(file);
    await OpenFile.open(pdfFile.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Generate PDF File")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(child: SingleChildScrollView(child: MyInvoice())),
            ElevatedButton(
              onPressed: () async {
                PDFMaker maker = PDFMaker();
                maker
                    .createPDF(
                  const MultiLanguagePDF(),
                  setup: PageSetup(
                      context: context,
                      quality: 4.0,
                      scale: 1.0,
                      pageFormat: PageFormat.a4,
                      margins: 40),
                )
                    .then((file) {
                  saveAndOpen(file);
                });
              },
              child: const Text("Create Demo PDF Letter"),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final pdfFile = await BlankPage.createPDF(
                    const MyInvoice(),
                    setup: PageSetup(context: context),
                  );
                  saveAndOpen(pdfFile);
                } catch (e) {
                  print("Error creating PDF: $e");
                }
              },
              child: const Text("Create Demo PDF Invoice"),
            ),
          ],
        ),
      ),
    );
  }
}
