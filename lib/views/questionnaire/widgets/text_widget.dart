import 'package:flutter/material.dart';
import 'package:mhealth/utils/app_color_scheme.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight weight;

  const TextWidget({
    Key? key,
    required this.text,
    this.size = 14,
    this.color = AppColorScheme.kGrayColor,
    this.weight = FontWeight.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: weight,
      ),
    );
  }
}
