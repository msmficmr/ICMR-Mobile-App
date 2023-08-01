import 'package:flutter/material.dart';
import 'package:mhealth/utils/app_color_scheme.dart';

class SendWidget extends StatelessWidget {
  final Function onTap;
  final double top, bottom, left, right;

  const SendWidget({
    Key? key,
    required this.onTap,
    this.left = 5,
    this.right = 0,
    this.top = 0,
    this.bottom = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        margin: EdgeInsets.fromLTRB(left, top, right, bottom),
        decoration: BoxDecoration(
          color: AppColorScheme.kPrimaryColor,
          border: Border.all(width: 1, color: AppColorScheme.kPrimaryColor),
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: const Icon(
          Icons.send,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }
}
