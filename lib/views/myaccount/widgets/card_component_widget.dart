import 'package:flutter/material.dart';

class AccountCard extends StatelessWidget {
  final Widget? leftIcon;
  final String text;
  final Widget? rightIcon;
  final Function() onTap;
  final TextStyle? textStyle;
  final Color? cardColor;
  final EdgeInsetsGeometry? padding;
  final double? iconSize;
  final double? width;
  final double? height;

  const AccountCard({
    super.key,
    this.leftIcon,
    required this.text,
    this.rightIcon,
    required this.onTap,
    this.textStyle,
    this.cardColor,
    this.padding,
    this.iconSize,
    this.width, // Add width as a parameter
    this.height, // Add height as a parameter
  });

  @override
  Widget build(BuildContext context) {
    const defaultTextStyle = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
    );

    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: cardColor,
        child: SizedBox(
          width: width,
          height: height,
          child: Padding(
            padding: padding ?? const EdgeInsets.all(16.0),
            child: Row(
              children: [
                if (leftIcon != null) SizedBox(child: leftIcon),
                if (leftIcon != null) const SizedBox(width: 16.0),
                Expanded(
                  child: Text(
                    text,
                    style: textStyle ?? defaultTextStyle,
                  ),
                ),
                if (rightIcon != null) const SizedBox(width: 16.0),
                if (rightIcon != null) SizedBox(child: rightIcon),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
