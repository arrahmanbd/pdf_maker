import 'package:flutter/foundation.dart';
import 'package:pdf_maker/pdf_maker.dart';

extension BlankPageExtensions on BlankPage {
  /// Generates a PDF file from the current BlankPage instance.
  Future<Uint8List> toPDF({PageSetup? setup}) async {
    return BlankPage.createPDF(this, setup: setup);
  }
}
