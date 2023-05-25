import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<Uint8List> generateCertificate(
    PdfPageFormat pageFormat, Map<String, String> data) async {
  final pdf = pw.Document();

  final libreBaskerville = await PdfGoogleFonts.libreBaskervilleRegular();
  final libreBaskervilleItalic = await PdfGoogleFonts.libreBaskervilleItalic();
  final libreBaskervilleBold = await PdfGoogleFonts.libreBaskervilleBold();
  final robotoLight = await PdfGoogleFonts.robotoLight();
  final medail = await rootBundle.loadString('assets/icon/medail.svg');
  final swirls = await rootBundle.loadString('assets/icon/swirls.svg');
  final swirls1 = await rootBundle.loadString('assets/icon/swirls1.svg');
  final swirls2 = await rootBundle.loadString('assets/icon/swirls2.svg');
  final swirls3 = await rootBundle.loadString('assets/icon/swirls3.svg');
  final garland = await rootBundle.loadString('assets/icon/garland.svg');

  pdf.addPage(
    pw.Page(
      build: (context) => pw.Column(
        children: [
          pw.Spacer(flex: 2),
          pw.RichText(
            text: pw.TextSpan(
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 25,
                ),
                children: [
                  const pw.TextSpan(text: 'CERTIFICATE '),
                  pw.TextSpan(
                    text: 'of',
                    style: pw.TextStyle(
                      fontStyle: pw.FontStyle.italic,
                      fontWeight: pw.FontWeight.normal,
                    ),
                  ),
                  const pw.TextSpan(text: ' ACHIEVEMENT'),
                ]),
          ),
          pw.Spacer(),
          pw.Text(
            'THIS ACKNOWLEDGES THAT',
            style: pw.TextStyle(
              font: robotoLight,
              fontSize: 10,
              letterSpacing: 2,
              wordSpacing: 2,
            ),
          ),
          pw.SizedBox(
            width: 300,
            child: pw.Divider(color: PdfColors.grey, thickness: 1.5),
          ),
          pw.Text(
            data["name"]!,
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 20,
            ),
          ),
          pw.SizedBox(
            width: 300,
            child: pw.Divider(color: PdfColors.grey, thickness: 1.5),
          ),
          pw.Text(
            'HAS SUCCESSFULLY COMPLETED THE',
            style: pw.TextStyle(
              font: robotoLight,
              fontSize: 10,
              letterSpacing: 2,
              wordSpacing: 2,
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.SvgImage(
                svg: swirls,
                height: 10,
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                child: pw.Text(
                  data["course"]!,
                  style: const pw.TextStyle(
                    fontSize: 10,
                  ),
                ),
              ),
              pw.Transform(
                transform: Matrix4.diagonal3Values(-1, 1, 1),
                adjustLayout: true,
                child: pw.SvgImage(
                  svg: swirls,
                  height: 10,
                ),
              ),
            ],
          ),
          pw.Spacer(),
          pw.SvgImage(
            svg: swirls2,
            width: 150,
          ),
          pw.Spacer(),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Flexible(
                child: pw.Text(
                  data["description"]!,
                  style: const pw.TextStyle(fontSize: 10),
                  // textAlign: pw.TextAlign.justify,
                ),
              ),
              pw.SizedBox(width: 100),
              pw.SvgImage(
                svg: medail,
                width: 100,
              ),
            ],
          ),
        ],
      ),
      pageTheme: pw.PageTheme(
        pageFormat: pageFormat,
        theme: pw.ThemeData.withFont(
          base: libreBaskerville,
          italic: libreBaskervilleItalic,
          bold: libreBaskervilleBold,
        ),
        buildBackground: (context) => pw.FullPage(
          ignoreMargins: true,
          child: pw.Container(
            margin: const pw.EdgeInsets.all(10),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(
                  color: const PdfColor.fromInt(0xffe435), width: 1),
            ),
            child: pw.Container(
              margin: const pw.EdgeInsets.all(5),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                    color: const PdfColor.fromInt(0xffe435), width: 5),
              ),
              width: double.infinity,
              height: double.infinity,
              child: pw.Stack(
                alignment: pw.Alignment.center,
                children: [
                  pw.Positioned(
                    top: 5,
                    child: pw.SvgImage(
                      svg: swirls1,
                      height: 60,
                    ),
                  ),
                  pw.Positioned(
                    bottom: 5,
                    child: pw.Transform(
                      transform: Matrix4.diagonal3Values(1, -1, 1),
                      adjustLayout: true,
                      child: pw.SvgImage(
                        svg: swirls1,
                        height: 60,
                      ),
                    ),
                  ),
                  pw.Positioned(
                    top: 5,
                    left: 5,
                    child: pw.SvgImage(
                      svg: swirls3,
                      height: 160,
                    ),
                  ),
                  pw.Positioned(
                    top: 5,
                    right: 5,
                    child: pw.Transform(
                      transform: Matrix4.diagonal3Values(-1, 1, 1),
                      adjustLayout: true,
                      child: pw.SvgImage(
                        svg: swirls3,
                        height: 160,
                      ),
                    ),
                  ),
                  pw.Positioned(
                    bottom: 5,
                    left: 5,
                    child: pw.Transform(
                      transform: Matrix4.diagonal3Values(1, -1, 1),
                      adjustLayout: true,
                      child: pw.SvgImage(
                        svg: swirls3,
                        height: 160,
                      ),
                    ),
                  ),
                  pw.Positioned(
                    bottom: 5,
                    right: 5,
                    child: pw.Transform(
                      transform: Matrix4.diagonal3Values(-1, -1, 1),
                      adjustLayout: true,
                      child: pw.SvgImage(
                        svg: swirls3,
                        height: 160,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(
                      top: 120,
                      left: 80,
                      right: 80,
                      bottom: 80,
                    ),
                    child: pw.SvgImage(
                      svg: garland,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );

  return pdf.save();
}
