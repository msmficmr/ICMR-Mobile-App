import 'package:flutter/material.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/views/questionnaire/widgets/send_widget.dart';

class CustomFieldText extends StatefulWidget {
  final VoidCallback onSubmit;
  final TextEditingController textEditingController;
  final bool showSubmit;

  const CustomFieldText({
    Key? key,
    required this.onSubmit,
    required this.textEditingController,
    this.showSubmit = true,
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
          width: MediaQuery.of(context).size.width * 0.7,
          child: TextField(
            cursorColor: AppColorScheme.kPrimaryColor,
            controller: widget.textEditingController,
            decoration: const InputDecoration(
              errorBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
            ),
          ),
        ),
        if (widget.showSubmit)
          SendWidget(onTap: () {}, bottom: 30.0,),
      ],
    );
  }
}
