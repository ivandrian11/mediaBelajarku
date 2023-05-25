import 'package:flutter/material.dart';
import 'package:media_belajarku/common/certificate.dart';
import 'package:media_belajarku/common/styles.dart';
import 'package:printing/printing.dart';

class CertificateView extends StatelessWidget {
  final Map<String, String> data;

  const CertificateView(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data["course"]!),
        titleTextStyle: appBarStyle,
      ),
      body: PdfPreview(
        build: (format) => generateCertificate(format, data),
      ),
    );
  }
}
