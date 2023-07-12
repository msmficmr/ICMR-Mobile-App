import 'package:flutter/material.dart';

class AccountCard extends StatelessWidget {
  final IconData? leftIcon;
  final String text;
  final IconData? rightIcon;
  final Function() onTap;
  final TextStyle? textStyle;
  final Color? cardColor;
  final EdgeInsetsGeometry? padding;
  final double? iconSize;

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
  });

  @override
  Widget build(BuildContext context) {
    const defaultTextStyle = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
    );

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: cardColor,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16.0),
          child: Row(
            children: [
              if (leftIcon != null) Icon(leftIcon, size: iconSize),
              if (leftIcon != null) const SizedBox(width: 16.0),
              Expanded(
                child: Text(
                  text,
                  style: textStyle ?? defaultTextStyle,
                ),
              ),
              if (rightIcon != null) const SizedBox(width: 16.0),
              if (rightIcon != null) Icon(rightIcon, size: iconSize),
            ],
          ),
        ),
      ),
    );
  }
}
