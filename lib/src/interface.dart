import 'dart:typed_data';
import 'package:pdf_maker/pdf_maker.dart';

abstract class PdfGenerator {
  Future<Uint8List> createPDF(BlankPage page, {PageSetup? setup});
  Future<Uint8List> createMultiPagePDF(List<BlankPage> pages, {PageSetup? setup});
}
