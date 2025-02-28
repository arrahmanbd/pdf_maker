import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_maker/pdf_maker.dart';
import 'package:pdf_maker_example/book_cover.dart';

import 'invoice_demo.dart';

void main() {
  runApp(const MaterialApp(home: PDFMakerExample()));
}

class PDFMakerExample extends StatefulWidget {
  const PDFMakerExample({super.key});

  @override
  _PDFMakerExampleState createState() => _PDFMakerExampleState();
}

enum Proc { single, multi, none }

class _PDFMakerExampleState extends State<PDFMakerExample> {
  double loadingProgress = 0.0;
  Proc type = Proc.none;

  int _selectedIndex = 0;
  final List<BlankPage> pages = [
    const BookCover(),
    const Page2(),
    const Page3(),
  ];

  @override
  void initState() {
    super.initState();
    _simulateProgress(); // Simulate loading to test UI responsiveness
  }

  /// Simulates progress updates to test UI freezing
  void _simulateProgress() {
    loadingProgress = 0.0; // Reset progress
    _updateProgress(1); // Start the progress loop
  }

  /// Updates the loading progress step-by-step
  void _updateProgress(int step) {
    if (step > 10) {
      Future.delayed(const Duration(milliseconds: 200),
          _simulateProgress); // Restart after a short delay
      return;
    }

    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() {
          loadingProgress = step / 10;
        });
        _updateProgress(step + 1); // Proceed to next step
      }
    });
  }

  /// Saves the generated PDF file to the temporary directory and opens it
  Future<void> _saveAndOpen(Uint8List file) async {
    try {
      final location = await getDownloadsDirectory();
      final path = '${location!.path}/pdf_maker.pdf';
      final pdfFile = File(path);
      await pdfFile.writeAsBytes(file);
      print("File saved in: ${pdfFile.path}");
      await OpenFile.open(pdfFile.path);
    } catch (e) {
      debugPrint("Error saving or opening PDF: $e");
    }
  }

  /// Handles item tap in the bottom navigation bar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      type = Proc.values[index];
    });
    _generatePDF().then((file) {
      setState(() {
        type = Proc.none;
      });
      return _saveAndOpen(file);
    });
  }

  /// Generates and saves a PDF based on the selected index
  Future<Uint8List> _generatePDF() async {
    final maker = PDFMaker();
    switch (type) {
      case Proc.single:
        return await maker.createPDF(const MyInvoice(),
            setup: PageSetup(
                context: context, renderMode: PDFRenderMode.isolated));
      case Proc.multi:
        return await maker.createMultiPagePDF(pages,
            setup: PageSetup(
              context: context,
              renderMode: PDFRenderMode.isolated,
            ));
      default:
        //no data
        return Uint8List.fromList([]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.primaries[1],
        foregroundColor: Colors.white,
        title: const Text("Generate PDF File"),
        // To Test that UI Isn't freezing
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child: LinearProgressIndicator(
            value: loadingProgress,
            color: Colors.primaries[2],
            backgroundColor: Colors.grey[300],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Text(
                'Preview of ${_selectedIndex == 1 ? 'Multiple Page' : 'Single Page'}  PDF'),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: _selectedIndex == 0
                    ? const MyInvoice()
                    : Column(
                        children: pages,
                      ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          _buildBottomNavItem(
            active: type == Proc.single,
            label: 'Single Page',
            icon: Icons.line_style_outlined,
          ),
          _buildBottomNavItem(
            active: type == Proc.multi,
            label: 'Multi Page',
            icon: Icons.list_alt_rounded,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.primaries[1],
        unselectedItemColor: Colors.primaries[2],
        selectedFontSize: 16,
        unselectedFontSize: 16,
        onTap: _onItemTapped,
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavItem(
      {required bool active, required String label, required IconData icon}) {
    return BottomNavigationBarItem(
      tooltip: 'Generate $label pdf',
      icon: !active
          ? Icon(icon)
          : CupertinoActivityIndicator(
              color: Colors.primaries[1],
            ), // Center the icon inside the square button

      label: label,
    );
  }
}
