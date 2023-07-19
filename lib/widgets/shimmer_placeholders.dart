import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPlaceHolders extends StatelessWidget {
   final Widget child;
  const ShimmerPlaceHolders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade100,
      child: child,
    );
  }
}

class TitlePlaceholder extends StatelessWidget {
  final double width;
  final double height;

  const TitlePlaceholder({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width,
          height: height,
          color: Colors.white,
        ),
      ],
    );
  }
}