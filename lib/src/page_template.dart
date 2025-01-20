import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'page_setup.dart';
import 'pdf_maker_imp.dart';

abstract class BlankPage extends StatelessWidget {
  const BlankPage({super.key});

  /// Subclasses must implement this method to define their content.
  Widget createPageContent(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return createPageContent(context);
  }

  /// Helper function to create a PDF from a Template.
  static Future<Uint8List> createPDF(BlankPage page, {PageSetup? setup}) async {
    return PDFMaker().createPDF(page, setup: setup);
  }
}
