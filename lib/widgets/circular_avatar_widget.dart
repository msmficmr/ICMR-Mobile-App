import 'package:flutter/material.dart';
import 'package:mhealth/utils/app_styles.dart';

class CircularAvatar extends StatelessWidget {

  /// [letter] is used as the initials of the first and last name for display if the profile pic isn't there
  final String letter;

  /// [backgroundColor] is being used to show in the background of the circle avatar widget
  /// [textColor] is used to show the color of the text/letters
  /// [borderColor] is used to show the color of the border of the circle
  final Color backgroundColor, textColor, borderColor;

  /// [radius] is being used to give the size of the circle
  /// [borderWidth] is being used to give the size of the border of the circle
  final double radius, borderWidth;

  const CircularAvatar({
    super.key,
    required this.letter,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.radius = 40.0,
    this.borderWidth = 2.0,
    this.borderColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor,
      radius: radius,
      child: Stack(
        children: [
          Center(
            child: Text(
              letter,
              style: AppStyles.bodyMedium.copyWith(color: textColor),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: borderWidth,
                  color: borderColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
