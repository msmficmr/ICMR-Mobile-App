import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:mhealth/utils/app_color_scheme.dart';

class ImageViewWidget extends StatelessWidget {
  final List<int> imageList;
  const ImageViewWidget({super.key, required this.imageList});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: InteractiveViewer(
              child: Image.memory(
                Uint8List.fromList(imageList),
              ),
            ),
          ),
          Positioned(
            left: 16,
            top: 16,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: AppColorScheme.kPrimaryIconColor,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.close,
                color: AppColorScheme.kPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
