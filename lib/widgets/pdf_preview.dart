import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

class PdfPreview extends StatefulWidget {
  final String fileName;
  final Uint8List bytes;
  const PdfPreview({super.key,required this.fileName,required this.bytes});

  @override
  State<PdfPreview> createState() => _PdfPreviewState();
}

class _PdfPreviewState extends State<PdfPreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: false,
        onLeadingClick: () {
          Navigator.of(context).pop();
        },
        titleText:widget.fileName,
      ),
      body: PdfViewer.openData(widget.bytes)
    );
  }
}