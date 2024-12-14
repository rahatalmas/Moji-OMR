import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class OmrOptions extends pw.StatelessWidget {
  OmrOptions(this.totalOptionCount);

  final int totalOptionCount;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Row(
      children: [
        pw.Container(
          height: 30,
          width: 30,
          decoration: pw.BoxDecoration(
            shape: pw.BoxShape.circle,
            border: pw.Border.all(color: PdfColor.fromHex('#000000'), width: 2),
          ),
          child: pw.Center(
            child: pw.Text("A"),
          ),
        ),
        pw.SizedBox(width: 7),
        pw.Container(
          height: 30,
          width: 30,
          decoration: pw.BoxDecoration(
            shape: pw.BoxShape.circle,
            border: pw.Border.all(color: PdfColor.fromHex('#000000'), width: 2),
          ),
          child: pw.Center(
            child: pw.Text("B"),
          ),
        ),
        pw.SizedBox(width: 7),
        pw.Container(
          height: 30,
          width: 30,
          decoration: pw.BoxDecoration(
            shape: pw.BoxShape.circle,
            border: pw.Border.all(color: PdfColor.fromHex('#000000'), width: 2),
          ),
          child: pw.Center(
            child: pw.Text("C"),
          ),
        ),
        pw.SizedBox(width: 7),
        pw.Container(
          height: 30,
          width: 30,
          decoration: pw.BoxDecoration(
            shape: pw.BoxShape.circle,
            border: pw.Border.all(color: PdfColor.fromHex('#000000'), width: 2),
          ),
          child: pw.Center(
            child: pw.Text("D"),
          ),
        ),
      ],
    );
  }
}
