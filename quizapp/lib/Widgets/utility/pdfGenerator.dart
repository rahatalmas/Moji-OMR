import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:quizapp/providers/questionProvider.dart';

class PdfGenerator {
  static Future<void> generatePdf(BuildContext context) async {
    final questionProvider = Provider.of<QuestionProvider>(context, listen: false);

    final pdf = pw.Document(
      //pageMode: PdfPageMode.none
    );

    pdf.addPage(
      pw.Page(
        pageTheme: const pw.PageTheme(

        ),
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text('Quiz Questions', style: const pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 20),
              ...questionProvider.questions.map((question) {
                return pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(question.questionText, style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(height: 5),
                    ...question.options.asMap().entries.map((entry) {
                      final optionIndex = entry.key;
                      final option = entry.value;
                      return pw.Text('Option ${String.fromCharCode(65 + optionIndex)}: $option', style: pw.TextStyle(fontSize: 14));
                    }).toList(),
                    pw.SizedBox(height: 5),
                    pw.Text('Correct Answer: ${question.correctAnswer}', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(height: 20),
                  ],
                );
              }),
            ],
          );
        },
      ),
    );

    // Save PDF to file
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/quiz_questions.pdf");
    await file.writeAsBytes(await pdf.save());

    print("PDF saved at: ${file.path}");
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }
}