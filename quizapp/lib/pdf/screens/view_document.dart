import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:quizapp/pdf/widgets/omr_options.dart';

Future<Uint8List> getDocumentBytes(
    pw.Document document,
    ) async {
  document.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (ctx) {
        return [
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 16),
                child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      ...List.generate(15, (index) {
                        return pw.Column(
                          children: [
                            pw.Container(
                              height: 30,
                              child: pw.Text(
                                (index + 1).toString(),
                                style: const pw.TextStyle(fontSize: 22),
                              ),
                            ),
                            pw.SizedBox(height: 10),
                          ],
                        );
                      }),
                    ]),
              ),
              pw.SizedBox(width: 10),
              pw.Container(
                padding:
                const pw.EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: PdfColor.fromHex('#000000'),
                    width: 2,
                  ),
                ),
                child: pw.Column(
                  children: [
                    ...List.generate(15, (index) {
                      return pw.Column(children: [
                        OmrOptions(4),
                        if (index < 14) pw.SizedBox(height: 10),
                      ]);
                    }),
                  ],
                ),
              ),
            ],
          )
        ];
      },
    ),
  );
  return document.save();
}

Future<Uint8List> generateDocument() async {
  Uint8List? bytes;
  final document = pw.Document();
  try {
    bytes = await getDocumentBytes(document);
  } catch (e) {
    debugPrint(e.toString());
  }
  return bytes ?? Uint8List.fromList([]);
}

class ViewDocument extends StatefulWidget {
  const ViewDocument({super.key});

  @override
  State<ViewDocument> createState() => _ViewDocumentState();
}

class _ViewDocumentState extends State<ViewDocument> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PdfPreview(
            build: (_) => generateDocument(),
          ),
        )
      ],
    );
  }
}
