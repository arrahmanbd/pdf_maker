import 'package:flutter/material.dart';
import 'package:pdf_maker/pdf_maker.dart';
import 'package:google_fonts/google_fonts.dart';

class MyInvoice extends BlankPage {
  const MyInvoice({super.key});

  @override
  Widget createPageContent(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 595.0, // A4 width in points
      height: 842.0, // A4 height in points
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'INVOICE',
                  style: GoogleFonts.montserrat(
                      fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Text(
                  'Invoice #12345',
                  style: GoogleFonts.montserrat(fontSize: 18, color: Colors.black54),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Customer: অশ্রুকণ্যা',
              style: GoogleFonts.hindSiliguri(fontSize: 17, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Date: ${DateTime.now().toLocal()}',
              style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Table(
              border: TableBorder.all(color: Colors.black54),
              columnWidths: const {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(2),
                3: FlexColumnWidth(2),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.grey[300]),
                  children: [
                    _tableCell('Item', isHeader: true),
                    _tableCell('Quantity', isHeader: true),
                    _tableCell('Price', isHeader: true),
                    _tableCell('Total', isHeader: true),
                  ],
                ),
                TableRow(children: [
                  _tableCell('Product 1'),
                  _tableCell('2'),
                  _tableCell('\$25.00'),
                  _tableCell('\$50.00'),
                ]),
                TableRow(children: [
                  _tableCell('Product 2'),
                  _tableCell('1'),
                  _tableCell('\$40.00'),
                  _tableCell('\$40.00'),
                ]),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Total: \$90.00',
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.lato(
          fontSize: 16,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}