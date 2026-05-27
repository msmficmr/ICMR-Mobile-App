import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';

class PdfPreview extends StatelessWidget {
  final String fileName;
  final Uint8List bytes;

  const PdfPreview({
    super.key,
    required this.fileName,
    required this.bytes,
  });

  Future<String> _writeToFile(Uint8List data, String fileName) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(data, flush: true);
    return file.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: false,
        onLeadingClick: () => Navigator.of(context).pop(),
        titleText: fileName,
      ),
      body: FutureBuilder<String>(
        future: _writeToFile(bytes, fileName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Failed to load PDF: ${snapshot.error}"));
          } else {
            return PDFView(
              filePath: snapshot.data!,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: true,
              pageFling: true,
              onError: (error) {
                debugPrint('PDFView error: $error');
              },
              onPageError: (page, error) {
                debugPrint('Page error on page $page: $error');
              },
            );
          }
        },
      ),
    );
  }
}
