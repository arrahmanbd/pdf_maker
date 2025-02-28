import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:pdf/widgets.dart' as pw;
import 'interface.dart';
import 'page_setup.dart';
import 'page_template.dart';
import 'render_ui.dart';

class PDFMaker implements PdfGenerator {
  /// Generates a PDF document from the provided page.
  ///
  /// [page] - The page to include in the PDF.
  ///
  /// [setup] - An option to customize your PDF.
  @override
  Future<Uint8List> createPDF(BlankPage page, {PageSetup? setup}) async {
    final Uint8List imageBytes = await RenderUI.fromWidget(
      page,
      setup!.scale,
      context: setup.context,
      targetSize: setup.size,
      quality: setup.quality,
    );

    if (setup.renderMode == PDFRenderMode.normal) {
      return _generateSyncPDF([imageBytes], setup);
    } else {
      return await compute(_generatePDF, {
        "images": [imageBytes],
        "setup": setup.toMap(), // Convert `PageSetup` to a serializable Map
      });
    }
  }

  /// Generates a multi-page PDF document.
  @override
  Future<Uint8List> createMultiPagePDF(
    List<BlankPage> pages, {
    PageSetup? setup,
  }) async {
    List<Uint8List> imageList = [];

    //  Render all pages to imagebytes first (UI thread)
    for (BlankPage page in pages) {
      final Uint8List imageBytes = await RenderUI.fromWidget(
        page,
        setup!.scale,
        context: setup.context,
        targetSize: setup.size,
        quality: setup.quality,
      );
      imageList.add(imageBytes);
    }

    if (setup!.renderMode == PDFRenderMode.normal) {
      //Cannot run in an isolate because it uses BuildContext
      return _generateSyncPDF(imageList, setup);
    } else {
      return await compute(_generatePDF, {
        "images": imageList,
        "setup": setup.toMap(), //  Convert `PageSetup` to a serializable Map
      });
    }
  }

  /// Generates a PDF synchronously (UI mode)
  /// UI Rendering function cannot be run in an isolate because it uses Widgets.
  /// A separate method must be implemented to handle this process efficiently.

  Future<Uint8List> _generateSyncPDF(List<Uint8List> images, PageSetup setup) {
    final pdf = pw.Document();

    for (Uint8List imageBytes in images) {
      final pw.ImageProvider image = pw.MemoryImage(imageBytes);
      pdf.addPage(
        pw.Page(
          pageFormat: setup.getPageFormat(),
          orientation: setup.getDocumentOrientation(),
          margin: pw.EdgeInsets.all(setup.margins),
          build: (pw.Context context) => pw.Center(child: pw.Image(image)),
        ),
      );
    }
    return pdf.save();
  }
}

/// Implemented a background isolate function for non-UI rendering tasks.
/// A separate function is required to handle PDF export in the background,
/// reducing the load on the main thread and improving performance.

Future<Uint8List> _generatePDF(Map<String, dynamic> params) async {
  final List<Uint8List> images = params["images"];
  final Map<String, dynamic> setupMap = params["setup"];

  // Convert Map back to `PageSetup`
  final PageSetup setup = PageSetup.fromMap(setupMap);

  final pdf = pw.Document();
  for (Uint8List imageBytes in images) {
    final pw.ImageProvider image = pw.MemoryImage(imageBytes);
    pdf.addPage(
      pw.Page(
        pageFormat: setup.getPageFormat(),
        orientation: setup.getDocumentOrientation(),
        margin: pw.EdgeInsets.all(setup.margins),
        build: (pw.Context context) => pw.Center(child: pw.Image(image)),
      ),
    );
  }
  return pdf.save();
}
