// ignore_for_file: non_constant_identifier_names

import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mhealth/model/questionnaire_form_model.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/utils/translation_keys.dart';
import 'package:mhealth/viewModel/language_view_model.dart';
import 'package:mhealth/views/questionair/view/signature_screen.dart';
import 'package:mhealth/widgets/custom_check_box.dart';
import 'package:mhealth/widgets/custom_signature_widget.dart';
import 'package:mhealth/widgets/custom_textfield.dart';
import 'package:mhealth/widgets/space_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class VerificationQuestionnaireScreen extends StatefulWidget {
  final VerificationFormQuestionnaire questioner;
  const VerificationQuestionnaireScreen({super.key, required this.questioner});

  @override
  State<VerificationQuestionnaireScreen> createState() => _VerificationQuestionnaireScreenState();
}

class _VerificationQuestionnaireScreenState extends State<VerificationQuestionnaireScreen> {
  final String CONSENT_TEXT = 'I have reviewed all the Case Report Forms for the above participant and agree that they are accurate and complete.';

  final String KEY_CHECKBOX_CONSENT = "key_checkbox_consent";
  final String KEY_FIELD_SAMPLE_COLLECTED_BY = "key_textfield_participant_id";
  final String KEY_HEADING_SAMPLE_COLLECTED_BY = "key_title_participant_id";
  final String KEY_CHECKBOX = "key_checkbox";
  final String KEY_BUTTON_CONSENT = "key_button_consent";

  final String ADD_INVESTIGATORS_TITLE = "Add Investigator's signature";
  final String PARTICIPANT_TITLE = "Sample collected by";
  final String ERROR_CONSENT = "Please sign consent";

  final ValueNotifier<bool> _hasCaptured = ValueNotifier<bool>(false);
  final GlobalKey<FormFieldState> _captureState = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _signatureState = GlobalKey<FormFieldState>();
  final ValueNotifier<Uint8List?> _signatureData = ValueNotifier<Uint8List?>(null);
  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bindData();
    });
  }

  bindData() async {
    try {
      _isLoading.value = true;
      if (widget.questioner.signature.value != null) {
        _signatureData.value = Uint8List.fromList(await CommonFunctions().readFileInIsolate(widget.questioner.signature.value?.filePath ?? ""));
      }
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> getSignature() async {
    Uint8List? result = await Navigator.push(context, MaterialPageRoute(builder: (_) => const SignatureScreen(appBarTitle: AppConstant.SIGNATURE_SCREEN_APP_BAR_TITLE)));
    if (result != null) {
      _isLoading.value = true;
      try {
        /// Pass extension in .format ex: .png .jpg .pdf etc
        RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
        String filePath = await CommonFunctions().writeFileInIsolate(result.toList(), ".png", rootIsolateToken);
        _signatureData.value = result;
        String fileName = filePath.split("/").last;
        widget.questioner.signature.value = AttachmentModel(fileName: fileName, filePath: filePath);
        _signatureState.currentState?.didChange(result);
      } finally {
        _isLoading.value = false;
      }
    }
  }

  onRemoveSignature() async {
    try {
      _isLoading.value = true;
      String? filePath = widget.questioner.signature.value?.filePath;
      _signatureData.value = null;
      widget.questioner.signature.value = null;
      _signatureState.currentState?.didChange(null);
      if (filePath != null) {
        await CommonFunctions().deleteFile(filePath);
      }
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: widget.questioner.sampleCollectedByController,
          widgetKey: Key(KEY_FIELD_SAMPLE_COLLECTED_BY),
          hintText: TranslationKeys.enterHere.translate(context),
          heading: PARTICIPANT_TITLE,
          headingKey: Key(KEY_HEADING_SAMPLE_COLLECTED_BY),
        ),
        const SpaceWidget(height: 15),
        ValueListenableBuilder(
            valueListenable: _hasCaptured,
            builder: (context, _, __) {
              return FormField<bool?>(
                key: _captureState,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value == false) {
                    return "This field is required.";
                  }
                  return null;
                },
                builder: (formState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ValueListenableBuilder(
                        valueListenable: _hasCaptured,
                        builder: (context, value, child) => CustomCheckBox(
                          widgetKey: Key(KEY_CHECKBOX),
                          value: _hasCaptured.value,
                          onChanged: (p0) {
                            _hasCaptured.value = p0;
                            formState.didChange(p0);
                          },
                          children: [TextSpan(text: CONSENT_TEXT)],
                        ),
                      ),
                      if (formState.hasError) ...[Text(formState.errorText ?? "", style: AppStyles.errorStyle)]
                    ],
                  );
                },
              );
            }),
        const SpaceWidget(height: 15),
        ValueListenableBuilder(
            valueListenable: _isLoading,
            builder: (context, _, __) {
              return _isLoading.value
                  ? Skeletonizer(
                      enabled: true,
                      ignoreContainers: false,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: double.infinity,
                          height: 160,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ValueListenableBuilder<Uint8List?>(
                      valueListenable: _signatureData,
                      builder: (context, _, __) {
                        return CustomSignatureWidget(
                          onButtonClick: getSignature,
                          formFieldState: _signatureState,
                          signatureData: _signatureData.value,
                          buttonText: ADD_INVESTIGATORS_TITLE,
                          buttonKey: KEY_BUTTON_CONSENT,
                          errorText: ERROR_CONSENT,
                          onRemoveClick: onRemoveSignature,
                        );
                      },
                    );
            }),
      ],
    );
  }
}
