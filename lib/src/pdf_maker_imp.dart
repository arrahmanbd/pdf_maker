import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_maker/src/page_template.dart';
import 'interface.dart';
import 'page_setup.dart';

class PDFMaker implements PdfGenerator {
  /// Generates a PDF document from the provided page.
  ///
  /// [page] - The page to include in the PDF.
  ///
  /// [setup] - An option to customize your PDF.
  @override
  Future<Uint8List> createPDF(BlankPage page, {PageSetup? setup}) async {
    final Widget pdfWidget = page;
    double pageScale = setup!.scale;
    final Uint8List imageBytes = await _renderFromWidget(pdfWidget, pageScale,
        context: setup.context, targetSize: setup.size, quality: setup.quality);
    final pdf = pw.Document();
    final pw.ImageProvider image = pw.MemoryImage(imageBytes);
    pdf.addPage(
      pw.Page(
        pageFormat: setup.getPageFormat(),
        orientation: setup.getDocumentOrientation(),
        margin: pw.EdgeInsets.all(setup.margins),
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(image),
          );
        },
      ),
    );
    return pdf.save();
  }

  /// Render a widget as pdf page
  /// [widget] - The widget to render.
  /// [delay] - Delay before capturing (increases with widget complexity).
  /// [quality] - The quality of the pdf content 1-10.
  /// [context] - Used to inherit app theme and media query data.
  /// [targetSize] - Target size for the output image.
  Future<Uint8List> _renderFromWidget(
    Widget widget,
    double scale, {
    Duration delay = const Duration(seconds: 1),
    double? quality,
    BuildContext? context,
    Size? targetSize,
  }) async {
    // If targetSize is provided, apply the scaling factor
    Size finalTargetSize =
        targetSize ?? const Size(592, 812); // Default size A4 if no targetSize
    finalTargetSize =
        Size(finalTargetSize.width * scale, finalTargetSize.height * scale);
    // Default pixelRatio is 3.0 for higher resolution
    quality ??= 3.0; // Set a higher pixel ratio for better quality
    ui.Image image = await _widgetToUiImage(
      widget,
      delay: delay,
      quality: quality,
      context: context,
      targetSize: finalTargetSize,
    );
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();
    return byteData!.buffer.asUint8List();
  }

  /// Converts a widget into a `ui.Image`.
  ///
  /// This method handles rendering the widget in an isolated render tree
  /// and returning its image representation.
  static Future<ui.Image> _widgetToUiImage(
    Widget widget, {
    Duration delay = const Duration(seconds: 1),
    double? quality,
    BuildContext? context,
    Size? targetSize,
  }) async {
    int retryCounter = 3;
    bool isDirty = false;

    Widget child = widget;

    if (context != null) {
      child = InheritedTheme.captureAll(
        context,
        MediaQuery(
          data: MediaQuery.of(context),
          child: Material(child: child),
        ),
      );
    }

    final RenderRepaintBoundary repaintBoundary = RenderRepaintBoundary();
    final platformDispatcher = WidgetsBinding.instance.platformDispatcher;
    final fallbackView = platformDispatcher.views.first;
    final view =
        context == null ? fallbackView : View.maybeOf(context) ?? fallbackView;
    Size logicalSize = targetSize ?? view.physicalSize / view.devicePixelRatio;
    Size imageSize = targetSize ?? view.physicalSize;

    assert(logicalSize.aspectRatio.toStringAsPrecision(5) ==
        imageSize.aspectRatio.toStringAsPrecision(5));

    final RenderView renderView = RenderView(
      view: view,
      child: RenderPositionedBox(
          alignment: Alignment.center, child: repaintBoundary),
      configuration: ViewConfiguration(
        logicalConstraints: BoxConstraints(
          maxWidth: logicalSize.width,
          maxHeight: logicalSize.height,
        ),
        devicePixelRatio: quality ?? 3.0,
      ),
    );

    final PipelineOwner pipelineOwner = PipelineOwner();
    final BuildOwner buildOwner = BuildOwner(
        focusManager: FocusManager(), onBuildScheduled: () => isDirty = true);

    pipelineOwner.rootNode = renderView;
    renderView.prepareInitialFrame();

    final RenderObjectToWidgetElement<RenderBox> rootElement =
        RenderObjectToWidgetAdapter<RenderBox>(
      container: repaintBoundary,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: child,
      ),
    ).attachToRenderTree(buildOwner);

    buildOwner.buildScope(rootElement);
    buildOwner.finalizeTree();

    pipelineOwner.flushLayout();
    pipelineOwner.flushCompositingBits();
    pipelineOwner.flushPaint();

    ui.Image? image;

    do {
      isDirty = false;

      image = await repaintBoundary.toImage(
          pixelRatio: quality ?? (imageSize.width / logicalSize.width));

      await Future.delayed(delay);

      if (isDirty) {
        buildOwner.buildScope(rootElement);
        buildOwner.finalizeTree();
        pipelineOwner.flushLayout();
        pipelineOwner.flushCompositingBits();
        pipelineOwner.flushPaint();
      }

      retryCounter--;
    } while (isDirty && retryCounter >= 0);

    return image;
  }
}
