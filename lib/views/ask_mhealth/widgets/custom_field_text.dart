import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/views/ask_mhealth/widgets/send_widget.dart';

class CustomFieldText extends StatefulWidget {
  final VoidCallback onSubmit;
  final TextEditingController textEditingController;
  final bool showSubmit;
  final double screenWidth;

  const CustomFieldText({
    Key? key,
    required this.onSubmit,
    required this.textEditingController,
    this.showSubmit = true,
    required this.screenWidth,
  }) : super(key: key);

  @override
  State<CustomFieldText> createState() => _CustomFieldTextState();
}

class _CustomFieldTextState extends State<CustomFieldText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: widget.screenWidth * 0.6,
          child: TextField(
            controller: widget.textEditingController,
            cursorColor: AppColorScheme.kPrimaryColor,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-Z0-9,. ]'),
              ),
            ],
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              errorBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
            ),
          ),
        ),
        if (widget.showSubmit)
          SendWidget(
            onTap: () {
              widget.onSubmit();
            },
            bottom: 30.0,
          ),
      ],
    );
  }
}
