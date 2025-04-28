import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/utils/enums.dart';
import 'dart:ui' as ui;

import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/primary_filled_button.dart';
import 'package:mhealth/widgets/space_widget.dart';

class SignatureScreen extends StatefulWidget {
  final String appBarTitle;
  static const routerPath = "/signatureScreen";

  const SignatureScreen({Key? key,required this.appBarTitle}) : super(key: key);

  @override
  State<SignatureScreen> createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {

  final String APP_BAR_TITLE = "Signature";

  final String KEY_BUTTON_CLEAR = "key_button_clear";
  final String KEY_BUTTON_SAVE = "key_button_save";
  final String TITLE_BUTTON_CLEAR = "Clear";
  final String TITLE_BUTTON_SAVE = "Save";

  final _signKey = GlobalKey<SignatureState>();

  void clearSignaturePad() {
    _signKey.currentState!.clear();
  }

  Future<Uint8List?> getSignatureBytes() async {
    if (_signKey.currentState!.hasPoints) {
      final ui.Image image = await _signKey.currentState!.getData();
      final ByteData? data = await image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List imageBytes = data!.buffer.asUint8List();

      return imageBytes;
    } else {
      return null;
    }
  }

  void saveSignature() async {
    Uint8List? signBytes = await getSignatureBytes();
    if (context.mounted) {
      Navigator.pop(context, signBytes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarTitleType: CustomAppBarTitleType.TEXT,
        titleText: widget.appBarTitle,
        onLeadingClick: () {
          GoRouter.of(context).pop();
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppValues.kAppPadding),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  color: AppColorScheme.selectedBackgroundColor,
                  border: Border.all(color: AppColorScheme.selectedBackgroundColor, width: 2),
                ),
                child: Signature(
                  key: _signKey,
                  color: AppColorScheme.kPrimaryColor,
                  strokeWidth: 2,
                ),
              ),
            ),
            Material(
              color: Colors.white,
              child: InkWell(
                key: Key(KEY_BUTTON_CLEAR),
                onTap: clearSignaturePad,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    border: Border.all(color: AppColorScheme.selectedBackgroundColor, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      TITLE_BUTTON_CLEAR,
                      style: AppStyles.buttonStyle,
                    ),
                  ),
                ),
              ),
            ),
            const SpaceWidget(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              child: PrimaryFilledButton(
                buttonTitle: TITLE_BUTTON_SAVE,
                widgetKey: KEY_BUTTON_SAVE,
                onPressed: saveSignature,
              ),
            ),
            const SpaceWidget(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
