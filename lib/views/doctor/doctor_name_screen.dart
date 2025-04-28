import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/config/theme/filled_button_theme_style.dart';
import 'package:mhealth/services/shared_preference_service.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/utils/helpers/app_validators.dart';
import 'package:mhealth/utils/translation_keys.dart';
import 'package:mhealth/views/dashboard/dashboard_screen.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/custom_textfield.dart';
import 'package:mhealth/widgets/primary_filled_button.dart';
import 'package:mhealth/widgets/space_widget.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';

class DoctorNameScreen extends StatefulWidget {
  static const String routerPath = "/doctorName";
  final bool shouldShowBackButton;
  const DoctorNameScreen({super.key, required this.shouldShowBackButton});

  @override
  State<DoctorNameScreen> createState() => _DoctorNameScreenState();
}

class _DoctorNameScreenState extends State<DoctorNameScreen> {
  final String TITLE = "Please enter your name";
  final String KEY_TITLE = "key_title";

  final String TEXTBOX_TITLE = "Doctor Name";
  final String TEXTBOX_TITLE_KEY = "doctor_name_key";
  final String TEXTBOX_HINT_TEXT = "Enter here";
  final String KEY_TEXTFIELD = "key_doctor";
  final String KEY_BUTTON_CONTINUE = "key_button_continue";

  final TextEditingController _nameFieldController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  Future<void> onContinueClick() async {
    if (_formKey.currentState?.validate() ?? false) {
      String doctorName = _nameFieldController.text.trim();
      await SharedPreferencesService.sharedPreferencesService.writeString(key: AppConstant.SHREAD_PREF_DOC_KEY, value: doctorName);
      if (widget.shouldShowBackButton) {
        if (mounted) {
          GoRouter.of(context).pop(true);
        }
      } else {
        if (mounted) {
          GoRouter.of(context).go(DashboardScreen.routerPath);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    bindDocDetails();
  }

  void bindDocDetails() async {
    bool containDocName = await SharedPreferencesService.sharedPreferencesService.hasKey(AppConstant.SHREAD_PREF_DOC_KEY);
    if (containDocName) {
      String? strDocName = await SharedPreferencesService.sharedPreferencesService.readData(key: AppConstant.SHREAD_PREF_DOC_KEY);
      if (strDocName != null) {
        _nameFieldController.text = strDocName;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarTitleType: CustomAppBarTitleType.HORIZONTAL_APP_ICON,
        hasLeading: widget.shouldShowBackButton,
        centerTitle: true,
        onLeadingClick: () {
          GoRouter.of(context).pop();
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppValues.kAppPadding),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SpaceWidget(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      TITLE,
                      key: Key(KEY_TITLE),
                      style: AppStyles.headlineMedium.copyWith(
                        color: AppColorScheme.kGrayColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SpaceWidget(
                height: 20,
              ),
              CustomTextField(
                widgetKey: Key(KEY_TEXTFIELD),
                controller: _nameFieldController,
                hintText: TEXTBOX_HINT_TEXT,
                heading: TranslationKeys.doctor_name.translate(context),
                headingKey: Key(TEXTBOX_TITLE_KEY),
                validator: AppValidators.requiredMoreThanTwoCharField,
                keyboardType: TextInputType.text,
                inputFormatters: [
                  AppValues.textWithDotInputFormatter,
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: PrimaryFilledButton(
                  buttonThemeStyle: const FilledButtonThemeStyle(disabledTextColor: Colors.white),
                  buttonTitle: widget.shouldShowBackButton ? AppConstant.UPDATE_BUTTON_TITLE : AppConstant.CONTINUE_BUTTON_TITLE,
                  widgetKey: KEY_BUTTON_CONTINUE,
                  isLoading: false,
                  onPressed: onContinueClick,
                ),
              ),
              const SpaceWidget(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
