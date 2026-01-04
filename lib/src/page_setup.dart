// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdf;

/// [PDFRenderMode] - The mode in which the PDF is rendered.
enum PDFRenderMode { normal, isolated }

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

  /// [PDFRenderMode] - The mode in which the PDF is rendered. Default Isolated.
  ///
  final PDFRenderMode renderMode;
  PageSetup(
      {this.pageFormat = PageFormat.a4,
      this.orientation = DocumentOrientation.portrait,
      this.margins = 20.0,
      this.context,
      this.scale = 1.0,
      this.quality = 3.0,
      this.renderMode = PDFRenderMode.isolated})
      : size = _getPageSize(pageFormat, orientation);

  /// Returns the corresponding [PdfPageFormat] for the given [PageFormat].
  /// Applies landscape orientation if specified.
  PdfPageFormat getPageFormat() {
    PdfPageFormat baseFormat;
    switch (pageFormat) {
      case PageFormat.a3:
        baseFormat = PdfPageFormat.a3;
        break;
      case PageFormat.a4:
        baseFormat = PdfPageFormat.a4;
        break;
      case PageFormat.a5:
        baseFormat = PdfPageFormat.a5;
        break;
      case PageFormat.a6:
        baseFormat = PdfPageFormat.a6;
        break;
      case PageFormat.letter:
        baseFormat = PdfPageFormat.letter;
        break;
      case PageFormat.legal:
        baseFormat = PdfPageFormat.legal;
        break;
      case PageFormat.roll57:
        baseFormat = PdfPageFormat.roll57;
        break;
      case PageFormat.roll80:
        baseFormat = PdfPageFormat.roll80;
        break;
      case PageFormat.custom:
        baseFormat = PdfPageFormat.a4; // Placeholder for custom format
        break;
    }
    
    // Apply orientation: use .landscape for landscape, default is portrait
    if (orientation == DocumentOrientation.landscape) {
      return baseFormat.landscape;
    }
    return baseFormat;
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

// Function to automatically get the size based on the format and orientation
  // Uses actual PDF points dimensions to ensure accurate rendering
  static Size _getPageSize(PageFormat format, DocumentOrientation orientation) {
    Size baseSize;
    switch (format) {
      case PageFormat.a3:
        // A3: 841.89 x 1190.55 points (297 x 420 mm)
        baseSize = const Size(841.8897637795275, 1190.551181102362);
        break;
      case PageFormat.a4:
        // A4: 595.28 x 841.89 points (210 x 297 mm)
        baseSize = const Size(595.275590551181, 841.8897637795275);
        break;
      case PageFormat.a5:
        // A5: 419.53 x 595.28 points (148 x 210 mm)
        baseSize = const Size(419.5275590551181, 595.275590551181);
        break;
      case PageFormat.a6:
        // A6: 297.64 x 419.53 points (105 x 148 mm)
        baseSize = const Size(297.6377952755906, 419.52755905511816);
        break;
      case PageFormat.letter:
        // Letter: 612 x 792 points (8.5 x 11 inches)
        baseSize = const Size(612, 792);
        break;
      case PageFormat.legal:
        // Legal: 612 x 1008 points (8.5 x 14 inches)
        baseSize = const Size(612, 1008);
        break;
      case PageFormat.roll57:
        baseSize = const Size(
            57, 0); // Roll57 has a fixed width, height is user-defined
        break;
      case PageFormat.roll80:
        baseSize = const Size(
            80, 0); // Roll80 has a fixed width, height is user-defined
        break;
      case PageFormat.custom:
        baseSize = const Size(0, 0); // Custom size, to be defined by the user
        break;
      default:
        baseSize = const Size(0, 0); // Default case, in case of invalid format
    }
    
    // Swap width and height for landscape orientation
    // Note: Roll formats and custom formats are not swapped
    if (orientation == DocumentOrientation.landscape &&
        format != PageFormat.roll57 &&
        format != PageFormat.roll80 &&
        format != PageFormat.custom &&
        baseSize.width > 0 &&
        baseSize.height > 0) {
      return Size(baseSize.height, baseSize.width);
    }
    
    return baseSize;
  }

  /// ⚠️ ** Buildcontext Can't be sent to an isolate, so I ignored it**
  /// ✅ ** Convert `PageSetup` to a Map for isolate communication**
  Map<String, dynamic> toMap() {
    return {
      'pageFormat': pageFormat.index, // Convert enum to int
      'orientation': orientation.index,
      'margins': margins,
      'scale': scale,
      'quality': quality,
      'renderMode': renderMode.index,
    };
  }

  /// ✅ **Reconstruct `PageSetup` from a Map**
  factory PageSetup.fromMap(Map<String, dynamic> map) {
    return PageSetup(
      pageFormat: PageFormat.values[map['pageFormat']], // Convert int to enum
      orientation: DocumentOrientation.values[map['orientation']],
      margins: map['margins'],
      scale: map['scale'],
      quality: map['quality'],
      renderMode: PDFRenderMode.values[map['renderMode']],
    );
  }
}
