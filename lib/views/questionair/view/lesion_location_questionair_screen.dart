// ignore_for_file: non_constant_identifier_names

import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mhealth/config/theme/filled_button_theme_style.dart';
import 'package:mhealth/model/id_text_model.dart';
import 'package:mhealth/model/questionnaire_form_model.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/utils/helpers/app_validators.dart';
import 'package:mhealth/utils/translation_keys.dart';
import 'package:mhealth/viewModel/language_view_model.dart';
import 'package:mhealth/views/questionair/view/gallery_view.dart';
import 'package:mhealth/widgets/circular_avatar_widget.dart';
import 'package:mhealth/widgets/custom_check_box.dart';
import 'package:mhealth/widgets/custom_dropdown.dart';
import 'package:mhealth/widgets/custom_textfield.dart';
import 'package:mhealth/widgets/primary_filled_button.dart';
import 'package:mhealth/widgets/space_widget.dart';
import 'package:probeintegration/services/probe_provider.dart';
import 'package:probeintegration/utils/exceptions.dart';
import 'package:provider/provider.dart';

class LesionLocationQuestionnaireScreen extends StatefulWidget {
  final LesionLocationQuestionnaire questioner;
  const LesionLocationQuestionnaireScreen({super.key, required this.questioner});

  @override
  State<LesionLocationQuestionnaireScreen> createState() => _LesionLocationQuestionnaireScreenState();
}

class _LesionLocationQuestionnaireScreenState extends State<LesionLocationQuestionnaireScreen> {
  final ValueNotifier<IdTextModel?> _site = ValueNotifier<IdTextModel?>(null);
  final ValueNotifier<IdTextModel?> _location = ValueNotifier<IdTextModel?>(null);
  final ValueNotifier<bool> _hasCaptured = ValueNotifier(false);
  final GlobalKey<FormFieldState> _captureState = GlobalKey<FormFieldState>();
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final String KEY_FIELD_SITE = "key_textfield_site";
  final String KEY_FIELD_LOCATION = "key_textfield_location";
  final String KEY_HEADING_SITE = "key_title_site";
  final String KEY_HEADING_LOCATION = "key_title_location";
  final String KEY_BUTTON_CAPTURE_IMAGE = "key_button_capture_image";
  final String KEY_FIELD_LENGTH = "key_textfield_length";
  final String KEY_FIELD_BREADTH = "key_textfield_breadth";
  final String KEY_HEADING_LENGTH = "key_heading_length";
  final String KEY_HEADING_BREADTH = "key_heading_breadth";
  final String KEY_FIELD_PROVISIONAL_DIAGNOSIS = "key_textfield_provisional_diagnosis";
  final String KEY_HEADING_PROVISIONAL_DIAGNOSIS = "key_heading_provisional_diagnosis";
  final String KEY_FIELD_OTHER_IMPRESSION = "key_textfield_other_impression";
  final String KEY_HEADING_OTHER_IMPRESSION = "key_heading_other_impression";
  final String KEY_CHECKBOX = "key_checkbox";

  final String SITE_TITLE = "Site";
  final String LOCATION_TITLE = "Location";
  final String CAPTURE_IMAGE_TITLE = "Capture Image";
  final String LENGTH_TITLE = "Length (mm)*";
  final String BREADTH_TITLE = "Breadth (mm)*";
  final String PROVISIONAL_DIAGNOSIS_TITLE = "Diagnosis*";
  final String OTHER_CLINICAL_TITLE = "Other";
  final String EMPTY_IMAGES_TITLE = "No oral lesion (mucosal\\benign tumors)";
  final String CAPTURED_IMAGES_TITLE = "I have capture  all the images of lesions";

  List<IdTextModel> siteMap = [
    IdTextModel(id: "upper_labial_mucosa", name: "Upper Labial mucosa"),
    IdTextModel(id: "lower_labial_mucosa", name: "Lower Labial mucosa"),
    IdTextModel(id: "buccal_mucosa", name: "Buccal mucosa"),
    IdTextModel(id: "tongue_lateral", name: "Tongue lateral"),
    IdTextModel(id: "tongue_dorsum", name: "Tongue dorsum"),
    IdTextModel(id: "tongue_ventral", name: "Tongue ventral"),
    IdTextModel(id: "base_of_the_tongue", name: "Base of the tongue"),
    IdTextModel(id: "palate", name: "Palate"),
    IdTextModel(id: "upper_vestibule", name: "Upper vestibule"),
    IdTextModel(id: "lower_vestibule", name: "Lower vestibule"),
    IdTextModel(id: "retromolar_trigone", name: "Retromolar trigone"),
    IdTextModel(id: "upper_gingiva", name: "Upper Gingiva"),
    IdTextModel(id: "lower_gingiva", name: "Lower Gingiva"),
    IdTextModel(id: "floor_of_the_mouth", name: "Floor of the mouth"),
  ];

  List<IdTextModel> provisionalDiagnosisList = [
    IdTextModel(id: "normal", name: "Normal"),
    IdTextModel(id: "benign", name: "Benign"),
    IdTextModel(id: "tobacco_pouch_keratosis", name: "Tobacco pouch keratosis"),
    IdTextModel(id: "homogenous_leukoplakia", name: "Homogenous leukoplakia"),
    IdTextModel(id: "non_homogenous_leukoplakia", name: "Non Homogenous Leukoplakia"),
    IdTextModel(id: "verrucous_leukoplakia", name: "Verrucous Leukoplakia"),
    IdTextModel(id: "oral_lichen_planus", name: "Oral Lichen Planus"),
    IdTextModel(id: "osmf", name: "OSMF"),
    IdTextModel(id: "malignancy", name: "Malignancy"),
    IdTextModel(id: "other", name: "Other"),
  ];

  List<IdTextModel> siteLocation = [IdTextModel(id: "left", name: "Left"), IdTextModel(id: "right", name: "Right")];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void onProbeError(String message, Object e) {
    switch (e.runtimeType) {
      case BluetoothPermanentlyPermissionException:
        CommonFunctions.openDialog(
          context: context,
          action: (context) {
            CommonFunctions.openAppSettings();
            Navigator.pop(context);
          },
          subtitle: "We require bluetooth permission to use this feature. Please grant bluetooth permissions in your app settings.",
          buttonText: "Grant permission",
        );
        break;
      case CameraPermanentlyPermissionException:
        CommonFunctions.openDialog(
          context: context,
          action: (context) {
            CommonFunctions.openAppSettings();
            Navigator.pop(context);
          },
          subtitle: "We require camera permission to use this feature. Please grant camera permissions in your app settings.",
          buttonText: "Grant permission",
        );
        break;
      case StoragePermanentlyPermissionException:
        CommonFunctions.openDialog(
          context: context,
          action: (context) {
            CommonFunctions.openAppSettings();
            Navigator.pop(context);
          },
          subtitle: "We require storage permission to use this feature. Please grant storage permissions in your app settings.",
          buttonText: "Grant permission",
        );
        break;
    }
  }

  _captureProbeImage(Map<String, Uint8List> data) async {
    try {
      isLoading.value = true;
      List<AttachmentModel> modelList = [];
      for (String key in data.keys) {
        Uint8List? bytes = data[key];
        if (bytes != null) {
          String extension = ".png";

          /// Pass extension in .format ex: .png .jpg .pdf etc
          ///
          RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
          String filePath = await CommonFunctions().writeFileInIsolate(bytes.toList(), ".$extension", rootIsolateToken);
          String fileName = filePath.split("/").last;
          AttachmentModel model = AttachmentModel(fileName: fileName, filePath: filePath);
          modelList.add(model);
        }
      }
      String questionId = "${_location.value?.id ?? ""}_${_site.value?.id ?? ""}".trim();
      LesionLocationQuestion question = LesionLocationQuestion(
        versionNumber: widget.questioner.versionNumber,
        questionId: questionId,
        timeAsked: DateTime.now(),
      );

      question.locationId = _location.value?.id ?? "";
      question.siteId = _site.value?.id ?? "";
      for (var model in modelList) {
        widget.questioner.addNewQuestion(question, model);
      }

      _site.value = null;
      _location.value = null;

      ///ADDED FAKE DELAY SO THAT FORM CAN RESET
      await Future.delayed(const Duration(milliseconds: 100));
      _formKey.currentState?.reset();
      CommonFunctions.toastMessage("Image Captured Successfully");
    } catch (e) {
      CommonFunctions.toastMessage(AppConstant.ERROR_SOMETHING_WENT_WRONG);
    } finally {
      isLoading.value = false;
    }
  }

  _initProbe() async {
    try {
      await context.read<ProbeProvider>().initialize(context, onProbeError, _captureProbeImage);
    } catch (e) {
      log("ERROR");
    }
  }

  _captureImage() async {
    try {
      isLoading.value = true;
      XFile? file = await CommonFunctions.getImage(context: context, imageSource: Platform.isAndroid ? ImageSource.camera : ImageSource.gallery);
      if (file != null) {
        Uint8List bytes = await file.readAsBytes();

        String extension = file.name.split(".").last;

        /// Pass extension in .format ex: .png .jpg .pdf etc
        ///
        RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
        String filePath = await CommonFunctions().writeFileInIsolate(bytes.toList(), ".$extension", rootIsolateToken);
        String fileName = filePath.split("/").last;

        String questionId = "${_location.value?.id ?? ""}_${_site.value?.id ?? ""}".trim();
        AttachmentModel model = AttachmentModel(fileName: fileName, filePath: filePath);
        LesionLocationQuestion question = LesionLocationQuestion(
          versionNumber: widget.questioner.versionNumber,
          questionId: questionId,
          timeAsked: DateTime.now(),
        );

        question.locationId = _location.value?.id ?? "";
        question.siteId = _site.value?.id ?? "";

        widget.questioner.addNewQuestion(question, model);

        _site.value = null;
        _location.value = null;

        ///ADDED FAKE DELAY SO THAT FORM CAN RESET
        await Future.delayed(const Duration(milliseconds: 100));
        _formKey.currentState?.reset();
        CommonFunctions.toastMessage("Image Captured Successfully");
      }
    } catch (e) {
      CommonFunctions.toastMessage(AppConstant.ERROR_SOMETHING_WENT_WRONG);
    } finally {
      isLoading.value = false;
    }
  }

  getTitle(String site, String location) {
    return "${siteLocation.firstWhere((element) => element.id == location).name} ${siteMap.firstWhere((element) => element.id == site).name}";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ValueListenableBuilder<IdTextModel?>(
                valueListenable: _site,
                builder: (context, _, __) {
                  return CustomDropdown<IdTextModel>(
                    widgetKey: KEY_FIELD_SITE,
                    heading: SITE_TITLE,
                    headingKey: Key(KEY_HEADING_SITE),
                    validator: AppValidators.requiredField,
                    hintText: TranslationKeys.select.translate(context),
                    onChanged: (IdTextModel? val) {
                      _site.value = val;
                    },
                    selectedItem: _site.value,
                    items: siteMap,
                    compareFn: (p0, p1) => p0.id == p1.id,
                  );
                },
              ),
              const SpaceWidget(
                height: 15,
              ),
              //LOCATION
              ValueListenableBuilder<IdTextModel?>(
                valueListenable: _location,
                builder: (context, _, __) {
                  return CustomDropdown<IdTextModel>(
                    widgetKey: KEY_FIELD_LOCATION,
                    heading: LOCATION_TITLE,
                    validator: AppValidators.requiredField,
                    headingKey: Key(KEY_HEADING_LOCATION),
                    hintText: TranslationKeys.select.translate(context),
                    onChanged: (val) {
                      _location.value = val;
                    },
                    selectedItem: _location.value,
                    items: siteLocation,
                    compareFn: (p0, p1) => p0.id == p1.id,
                  );
                },
              ),
              const SpaceWidget(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                child: ValueListenableBuilder(
                    valueListenable: isLoading,
                    builder: (context, _, __) {
                      return PrimaryFilledButton(
                        onPressed: () async{
                          if (_formKey.currentState!.validate()) {
                            // _initProbe();
                            String questionId = "${_location.value?.id ?? ""}_${_site.value?.id ?? ""}".trim();
                            AttachmentModel model = AttachmentModel(fileName: "fileName", filePath: "filePath");
                            LesionLocationQuestion question = LesionLocationQuestion(
                              versionNumber: widget.questioner.versionNumber,
                              questionId: questionId,
                              timeAsked: DateTime.now(),
                            );

                            question.locationId = _location.value?.id ?? "";
                            question.siteId = _site.value?.id ?? "";

                            widget.questioner.addNewQuestion(question, model);

                            _site.value = null;
                            _location.value = null;

                            ///ADDED FAKE DELAY SO THAT FORM CAN RESET
                            await Future.delayed(const Duration(milliseconds: 100));
                            _formKey.currentState?.reset();
                            CommonFunctions.toastMessage("Image Captured Successfully");
                          }
                        },
                        isLoading: isLoading.value,
                        buttonThemeStyle: const FilledButtonThemeStyle(
                          enabledTextColor: AppColorScheme.kEnabledButtonTextColor,
                          enabledButtonColor: AppColorScheme.kEnabledButtonColor,
                        ),
                        buttonTitle: CAPTURE_IMAGE_TITLE,
                        widgetKey: KEY_BUTTON_CAPTURE_IMAGE,
                      );
                    }),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        ValueListenableBuilder<List<LesionLocationQuestion>>(
          valueListenable: widget.questioner.questionsList,
          builder: (context, questionList, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(questionList.length, (index) {
                LesionLocationQuestion question = questionList[index];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ValueListenableBuilder(
                        valueListenable: question.expansionTileState,
                        builder: (context, isExpanded, _) {
                          return ExpansionTile(
                            tilePadding: const EdgeInsets.symmetric(horizontal: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color: AppColorScheme.kGrayColor.shade100,
                              ),
                            ),
                            collapsedShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color: AppColorScheme.kGrayColor.shade100,
                              ),
                            ),
                            backgroundColor: AppColorScheme.kGrayColor.shade100,
                            collapsedBackgroundColor: AppColorScheme.kGrayColor.shade100,
                            collapsedIconColor: AppColorScheme.kGrayColor.shade600,
                            collapsedTextColor: AppColorScheme.kGrayColor.shade600,
                            iconColor: AppColorScheme.kGrayColor.shade600,
                            textColor: AppColorScheme.kGrayColor.shade600,
                            expandedCrossAxisAlignment: CrossAxisAlignment.start,
                            expandedAlignment: Alignment.topLeft,
                            title: Text(
                              getTitle(question.siteId ?? "", question.locationId ?? ""),
                              style: AppStyles.titleMedium.copyWith(fontWeight: FontWeight.w600),
                            ),
                            controller: question.expansionTileController,
                            maintainState: true,
                            initiallyExpanded: isExpanded,
                            onExpansionChanged: (value) {
                              question.expansionTileState.value = value;
                            },
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                isExpanded ? const Icon(Icons.expand_less) : const Icon(Icons.expand_more),
                                const SizedBox(width: 2),
                                InkWell(
                                  onTap: () {
                                    widget.questioner.removeQuestion(question.questionId);
                                  },
                                  child: SvgPicture.asset(
                                    AppAssetsPath.icClose,
                                    height: 24,
                                    width: 24,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                ValueListenableBuilder(
                                  valueListenable: question.attachments,
                                  builder: (context, attachmentList, child) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => GalleryView(
                                              title: getTitle(question.siteId ?? "", question.locationId ?? ""),
                                              attachmentList: [...attachmentList],
                                              onRemoveClick: (fileName) {
                                                widget.questioner.removeAttachmentImage(question.questionId, fileName);
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                      child: SvgPicture.asset(
                                        attachmentList.length == 1 ? AppAssetsPath.icSingleImage : AppAssetsPath.icMultipleImage,
                                        width: 20,
                                        height: 20,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                                child: Column(
                                  children: [
                                    CustomTextField(
                                      controller: question.lengthController,
                                      keyboardType: TextInputType.number,
                                      widgetKey: Key("${KEY_FIELD_LENGTH}_$index"),
                                      hintText: TranslationKeys.enterHere.translate(context),
                                      heading: LENGTH_TITLE,
                                      headingKey: Key("${KEY_HEADING_LENGTH}_$index"),
                                      validator: AppValidators.requiredField,
                                    ),
                                    const SizedBox(height: 10),
                                    CustomTextField(
                                      controller: question.breadthController,
                                      keyboardType: TextInputType.number,
                                      widgetKey: Key("${KEY_FIELD_LENGTH}_$index"),
                                      hintText: TranslationKeys.enterHere.translate(context),
                                      heading: BREADTH_TITLE,
                                      headingKey: Key("${KEY_HEADING_BREADTH}_$index"),
                                      validator: AppValidators.requiredField,
                                    ),
                                    const SizedBox(height: 10),
                                    FormField<String?>(
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (question.diagnosys.value == null) {
                                          return "Please select a provisional diagnosis.";
                                        }
                                        return null;
                                      },
                                      builder: (formState) {
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ValueListenableBuilder<String?>(
                                              valueListenable: question.diagnosys,
                                              builder: (context, _, __) {
                                                return CustomDropdown<IdTextModel>(
                                                  widgetKey: "${KEY_FIELD_PROVISIONAL_DIAGNOSIS}_$index",
                                                  heading: PROVISIONAL_DIAGNOSIS_TITLE,
                                                  headingKey: Key("${KEY_HEADING_PROVISIONAL_DIAGNOSIS}_$index"),
                                                  hintText: TranslationKeys.select.translate(context),
                                                  onChanged: (val) {
                                                    question.diagnosys.value = val?.id;
                                                    formState.didChange(val?.id);
                                                  },
                                                  selectedItem: question.diagnosys.value == null
                                                      ? null
                                                      : provisionalDiagnosisList.firstWhereOrNull(
                                                          (element) => element.id == question.diagnosys.value,
                                                        ),
                                                  items: provisionalDiagnosisList,
                                                  compareFn: (p0, p1) => p0.id == p1.id,
                                                );
                                              },
                                            ),
                                            if (formState.hasError) ...[Text(formState.errorText ?? "", style: AppStyles.errorStyle)]
                                          ],
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    ValueListenableBuilder<String?>(
                                        valueListenable: question.diagnosys,
                                        builder: (context, provisionalDiagnosis, __) {
                                          if (provisionalDiagnosis == "other") {
                                            return CustomTextField(
                                              controller: question.diagnosysController,
                                              widgetKey: Key("${KEY_FIELD_OTHER_IMPRESSION}_$index"),
                                              hintText: TranslationKeys.enterHere.translate(context),
                                              heading: OTHER_CLINICAL_TITLE,
                                              headingKey: Key("${KEY_HEADING_OTHER_IMPRESSION}_$index"),
                                              // validator: AppValidators.requiredField,
                                            );
                                          } else {
                                            return const SizedBox();
                                          }
                                        }),
                                  ],
                                ),
                              )
                            ],
                          );
                        }),
                    const SizedBox(height: 10),
                  ],
                );
              }),
            );
          },
        ),
        ValueListenableBuilder<List<LesionLocationQuestion>>(
            valueListenable: widget.questioner.questionsList,
            builder: (context, questionList, child) {
              return ValueListenableBuilder<bool>(
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
                            CustomCheckBox(
                              widgetKey: Key(KEY_CHECKBOX),
                              value: _hasCaptured.value,
                              onChanged: (p0) {
                                _hasCaptured.value = p0;
                                formState.didChange(p0);
                              },
                              children: [
                                TextSpan(
                                  text: questionList.isEmpty ? EMPTY_IMAGES_TITLE : CAPTURED_IMAGES_TITLE,
                                ),
                              ],
                            ),
                            if (formState.hasError) ...[Text(formState.errorText ?? "", style: AppStyles.errorStyle)]
                          ],
                        );
                      },
                    );
                  });
            }),
      ],
    );
  }
}
