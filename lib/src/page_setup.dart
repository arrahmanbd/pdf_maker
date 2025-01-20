// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdf;

enum PageFormat {
  a3,
  a4,
  a5,
  a6,
  letter,
  legal,
  roll57,
  roll80,
  custom,
}

enum DocumentOrientation {
  portrait,
  landscape,
}

class PageSetup {
  /// [pageFormat] - a4,a3,a6,letter,roll etc
  final PageFormat pageFormat;
  
  /// [orientation] - Set the orientation of the document.
  ///
  final DocumentOrientation orientation;
  /// [margins] - Set the default margin from every side
  /// 
  final double margins;
  final Size size;
  /// [context] - Used to inherit app theme and media query data.
  ///
  final BuildContext? context;
  
  /// [scale] - The scale of the pdf content. Default is 1.0.
  ///
  final double scale;
  
  /// [quality] - The quality of the pdf content 1-10.
  ///
  final double? quality;
  PageSetup(
      {this.pageFormat = PageFormat.a4,
      this.orientation = DocumentOrientation.portrait,
      this.margins = 20.0,
      this.context,
      this.scale = 1.0,
      this.quality = 3.0})
      : size = _getPageSize(pageFormat);

  /// Returns the corresponding [PdfPageFormat] for the given [PageFormat].
  PdfPageFormat getPageFormat() {
    switch (pageFormat) {
      case PageFormat.a3:
        return PdfPageFormat.a3;
      case PageFormat.a4:
        return PdfPageFormat.a4;
      case PageFormat.a5:
        return PdfPageFormat.a5;
      case PageFormat.a6:
        return PdfPageFormat.a6;
      case PageFormat.letter:
        return PdfPageFormat.letter;
      case PageFormat.legal:
        return PdfPageFormat.legal;
      case PageFormat.roll57:
        return PdfPageFormat.roll57;
      case PageFormat.roll80:
        return PdfPageFormat.roll80;
      case PageFormat.custom:
        return PdfPageFormat.a4; // Placeholder for custom format
    }
  }

  /// Converts [DocumentOrientation] to [pdf.PageOrientation].
  pdf.PageOrientation getDocumentOrientation() {
    switch (orientation) {
      case DocumentOrientation.portrait:
        return pdf.PageOrientation.portrait;
      case DocumentOrientation.landscape:
        return pdf.PageOrientation.landscape;
    }
  }

// Function to automatically get the size based on the format
  static Size _getPageSize(PageFormat format) {
    switch (format) {
      case PageFormat.a3:
        return const Size(592, 844); // A3 in pixels
      case PageFormat.a4:
        return const Size(592, 812); // A4 in pixels
      case PageFormat.a5:
        return const Size(419, 592); // A5 in pixels
      case PageFormat.a6:
        return const Size(296, 419); // A6 in pixels
      case PageFormat.letter:
        return const Size(612, 792); // Letter size in pixels
      case PageFormat.legal:
        return const Size(612, 1008); // Legal size in pixels
      case PageFormat.roll57:
        return const Size(
            57, 0); // Roll57 has a fixed width, height is user-defined
      case PageFormat.roll80:
        return const Size(
            80, 0); // Roll80 has a fixed width, height is user-defined
      case PageFormat.custom:
        return const Size(0, 0); // Custom size, to be defined by the user
      default:
        return const Size(0, 0); // Default case, in case of invalid format
    }
  }
}
