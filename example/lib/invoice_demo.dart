import 'package:flutter/material.dart';
import 'package:pdf_maker/pdf_maker.dart';

class MyInvoice extends BlankPage {
  const MyInvoice({super.key});

  @override
  Widget createPageContent(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 595.0, // A4 width in points
      height: 842.0, // A4 height in points
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'INVOICE',
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  'Invoice #12345',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text('Customer: Himu'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text('Date: ${DateTime.now().toLocal()}'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Table(
              border: TableBorder.all(),
              children: const [
                TableRow(
                  children: [
                    TableCell(
                        child: Text('Item',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    TableCell(
                        child: Text('Quantity',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    TableCell(
                        child: Text('Price',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    TableCell(
                        child: Text('Total',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(child: Text('Product 1')),
                    TableCell(child: Text('2')),
                    TableCell(child: Text('\$25.00')),
                    TableCell(child: Text('\$50.00')),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(child: Text('Product 2')),
                    TableCell(child: Text('1')),
                    TableCell(child: Text('\$40.00')),
                    TableCell(child: Text('\$40.00')),
                  ],
                ),
              ],
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Total: \$90.00',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
