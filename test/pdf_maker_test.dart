import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdf_maker/pdf_maker.dart';

/// A concrete implementation of Template for testing purposes.
class TestTemplate extends BlankPage {
  const TestTemplate({super.key});

  @override
  Widget createPageContent(BuildContext context) {
    return const Center(
      child: Text('This is a test template'),
    );
  }
}

void main() {
  group('PDFMaker Tests', () {
    late PDFMaker pdfMaker;

    setUp(() {
      pdfMaker = PDFMaker();
    });

    TestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('createPDF generates a valid PDF file',
        (WidgetTester tester) async {
      // Arrange
      final PageSetup setup = PageSetup(
        pageFormat: PageFormat.a4,
        scale: 1.0,
        margins: 10.0,
        quality: 2.0,
      );

      const widget = TestTemplate();

      // Wait for the widget to render before creating the PDF
      await tester.pumpWidget(widget);

      // Act
      final Uint8List pdfBytes = await pdfMaker.createPDF(widget, setup: setup);
      final Uint8List multiPage = await pdfMaker
          .createMultiPagePDF([widget, widget, widget], setup: setup);

      // Assert
      expect(pdfBytes, isNotEmpty, reason: "PDF bytes should not be empty.");
      expect(pdfBytes.length, greaterThan(0),
          reason: "PDF size should be greater than 0.");
      expect(multiPage, isNotEmpty,
          reason: "Multi Page PDF bytes should not be empty.");
      expect(multiPage.length, greaterThan(1),
          reason: "Multi Page PDF size should be greater than 1.");
    });
  });
}
