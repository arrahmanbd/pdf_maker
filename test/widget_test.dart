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
  group('Template Widget Tests', () {
    testWidgets('Template builds correctly', (WidgetTester tester) async {
      // Arrange
      const TestTemplate testTemplate = TestTemplate();

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: testTemplate,
          ),
        ),
      );

      // Assert
      expect(find.text('This is a test template'), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
    });

    test('createPDF generates a valid PDF from a widget', () async {
      // Arrange
      const BlankPage testWidget = TestTemplate();
      final PageSetup setup = PageSetup(
        pageFormat: PageFormat.a4,
        scale: 1.0,
        margins: 10.0,
        quality: 2.0,
      );

      // Act
      final Uint8List pdfBytes =
          await BlankPage.createPDF(testWidget, setup: setup);

      // Assert
      expect(pdfBytes, isNotEmpty);
      expect(pdfBytes.length, greaterThan(0));
    });
  });
}
