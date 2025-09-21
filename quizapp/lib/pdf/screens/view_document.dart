import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:quizapp/pdf/widgets/omr_options.dart';
import 'package:collection/collection.dart';

List<String> _omrCircleData = ['A', 'B', 'C', 'D'];

Future<Uint8List> getDocumentBytes(pw.Document document) async {
  final headerColor = PdfColor.fromInt(0xffd0e6f7); // soft blue
  final sectionBgColor = PdfColor.fromInt(0xfff7f9fc); // very light blue/gray
  final baseTextStyle = pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold);
  final borderColor = PdfColors.blue800;

  document.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(20),
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // ===== Row 1: Logo and Exam Name =====
            pw.Container(
              //padding: const pw.EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              color: headerColor,
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  // Logo Box
                  pw.Container(
                    height: 32,
                    width: 40,
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.black, width: 1.2),
                      color: PdfColors.white,
                    ),
                    child: pw.Center(
                      child: pw.Text("OMR", style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
                    ),
                  ),
                  pw.SizedBox(width: 20),
                  // Exam Name
                  pw.Expanded(
                    child: pw.Text(
                      "EXAM NAME HERE",
                      style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold, color: PdfColors.blue800),
                    ),
                  ),
                ],
              ),
            ),
            // ===== Row 2: Exam ID, Serial Number, Instructions =====
            pw.Container(
              padding: const pw.EdgeInsets.all(10),
              color: sectionBgColor,
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // Exam ID (flex: 2)
                  pw.Expanded(
                    flex: 2,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Container(
                          padding: const pw.EdgeInsets.only(bottom: 8),
                          child: pw.Text("Exam ID", style: baseTextStyle.copyWith(color: PdfColors.blue900)),
                        ),
                        ...List.generate(10, (index) {
                          return pw.Padding(
                            padding: const pw.EdgeInsets.only(bottom: 6),
                            child: OmrOptions(totalOptionCount: 4, value: index.toString()),
                          );
                        }),
                      ],
                    ),
                  ),
                  pw.SizedBox(width: 15),

                  // Serial Number (flex: 2)
                  pw.Expanded(
                    flex: 2,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Container(
                          padding: const pw.EdgeInsets.only(bottom: 8),
                          child: pw.Text("Serial Number", style: baseTextStyle.copyWith(color: PdfColors.blue900)),
                        ),
                        ...List.generate(10, (index) {
                          return pw.Padding(
                            padding: const pw.EdgeInsets.only(bottom: 6),
                            child: OmrOptions(totalOptionCount: 4, value: index.toString()),
                          );
                        }),
                      ],
                    ),
                  ),
                  pw.SizedBox(width: 15),

                  // Instructions (flex: 3)
                  pw.Expanded(
                    flex: 3,
                    child: pw.Container(
                      padding: const pw.EdgeInsets.all(8),
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColors.blue800, width: 1),
                        borderRadius: pw.BorderRadius.circular(6),
                        color: PdfColors.white,
                      ),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text("Instructions", style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900)),
                          pw.SizedBox(height: 8),
                          pw.Bullet(text: "Use black or blue pen only."),
                          pw.Bullet(text: "Fill bubbles completely and clearly."),
                          pw.Bullet(text: "Do not fill more than one bubble per question."),
                          pw.Bullet(text: "Avoid stray marks or shading."),
                          pw.Bullet(text: "Keep the sheet clean and flat."),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 10),

            // ===== Row 3: Answer Section =====
            pw.Text(
              "Answer Section",
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900),
            ),
            pw.SizedBox(height: 10),

            pw.Container(
              decoration: pw.BoxDecoration(

                borderRadius: pw.BorderRadius.circular(4),
                color: sectionBgColor,
              ),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: List.generate(4, (colIndex) {
                  return pw.Expanded(
                    child: pw.Container(
                      padding: const pw.EdgeInsets.all(6),
                      child: pw.Column(
                        children: List.generate(20, (index) {
                          final questionNumber = colIndex * 20 + index + 1;
                          final isEvenRow = questionNumber % 2 == 0;
                          return pw.Container(
                            color: isEvenRow ? PdfColors.white : PdfColors.grey50,
                            padding: const pw.EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                            child: pw.Row(
                              children: [
                                // Question Number
                                pw.Container(
                                  width: 18,
                                  child: pw.Text(
                                    questionNumber.toString(),
                                    textAlign: pw.TextAlign.right,
                                    style: const pw.TextStyle(fontSize: 10),
                                  ),
                                ),
                                pw.SizedBox(width: 6),

                                // Bubbles wrapped in boxes
                                ..._omrCircleData.mapIndexed((i, val) {
                                  return pw.Container(
                                    margin: const pw.EdgeInsets.symmetric(horizontal: 4),
                                    padding: const pw.EdgeInsets.all(2),

                                    child: OmrOptions(
                                      totalOptionCount: 4,
                                      value: val,
                                      isSingle: true,
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        );
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
    return Scaffold(
      appBar: AppBar(title: const Text("Preview OMR Sheet")),
      body: Column(
        children: [
          Expanded(
            child: PdfPreview(
              build: (_) => generateDocument(),
              canChangeOrientation: false,
              canChangePageFormat: false,
              useActions: true,
              allowSharing: true,
              allowPrinting: true,
            ),
          )
        ],
      ),
    );
  }
}
