import 'dart:convert';
import 'dart:developer';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mhealth/config/router/app_screens.dart';
import 'package:mhealth/config/theme/filled_button_theme_style.dart';
import 'package:mhealth/isar_db_schema/identity_proofs_schema.dart';
import 'package:mhealth/isar_db_schema/patient_registration_schema.dart';
import 'package:mhealth/model/id_text_model.dart';
import 'package:mhealth/services/directory_db_service.dart';
import 'package:mhealth/services/isar_db_service.dart';
import 'package:mhealth/services/shared_preference_service.dart';
import 'package:mhealth/utils/app_assets_path.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/custom_input_formatter.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/utils/extensions/string_extension.dart';
import 'package:mhealth/utils/helpers/app_validators.dart';
import 'package:mhealth/utils/helpers/mask_text_input_formatter.dart';
import 'package:mhealth/utils/translation_keys.dart';
import 'package:mhealth/viewModel/login_view_model.dart';
import 'package:mhealth/viewModel/offline_data_view_model.dart';
import 'package:mhealth/viewModel/patient_list_view_model.dart';
import 'package:mhealth/viewModel/language_view_model.dart';
import 'package:mhealth/viewModel/registration_view_model.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/custom_chip_widget.dart';
import 'package:mhealth/widgets/custom_dropdown.dart';
import 'package:mhealth/widgets/custom_textfield.dart';
import 'package:mhealth/widgets/primary_filled_button.dart';
import 'package:mhealth/widgets/space_widget.dart';
import 'package:provider/provider.dart';

import '../../config/theme/outlined_button_theme_style.dart';
import '../../widgets/primary_outlined_button.dart';

class RegistrationScreen extends StatefulWidget {
  static const String routerPath = "/registration";
  final String? patientId;
  final bool isEditable;

  const RegistrationScreen({Key? key, this.patientId, this.isEditable = false}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  AttachmentModel? _selectedAttachment;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> consentKey = GlobalKey<FormFieldState>();
  TextInputFormatter _dateOfVisitFormatter = MaskTextInputFormatter(mask: '##/##/####', type: MaskAutoCompletionType.eager);
  TextInputFormatter _consentDateFormatter = MaskTextInputFormatter(mask: '##/##/####', type: MaskAutoCompletionType.eager);
  TextInputFormatter _idInputFormatter = MaskTextInputFormatter(
    mask: 'AA-AA-##########',
    filter: {
      "#": RegExp(r'[0-9]'),
      "A": RegExp(r'[a-zA-Z]'),
    },
    type: MaskAutoCompletionType.eager,
  );

  List<String> documentIds = [];
  List<String> documentNames = [];
  List<String> occupationIds = [];
  List<String> occupationNames = [];
  List<String> institutionIds = [];
  List<String> institutionNames = [];
  List<String> studyIds = [];
  List<String> studyNames = [];
  List<String> signedConsentIds = [];
  List<String> signedConsentNames = [];

  AttachmentModel? consent;

  late TextEditingController _dateOfVisitController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _tempAddressController = TextEditingController();
  final TextEditingController _permanentAddressController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _mobileFieldController = TextEditingController();
  final TextEditingController _alternateNumberFieldController = TextEditingController();
  final TextEditingController _medicalRecordNumberController = TextEditingController();
  final TextEditingController _documentTypeController = TextEditingController();
  late TextEditingController _consentDateController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _visitMonthController = TextEditingController();
  final TextEditingController _primaryIdController = TextEditingController();
  final TextEditingController _secondaryIdController = TextEditingController();

  //Widget Keys
  final String KEY_BUTTON_YES_CONSENT = "key_button_yes_consent";
  final String KEY_BUTTON_NO_CONSENT = "key_button_no_consent";
  final String KEY_FIELD_DATE_OF_VISIT = "key_textfield_date_of_visit";
  final String KEY_FIELD_INSTITUTION_CODE = "key_textfield_institution_code";
  final String KEY_FIELD_STUDY_PH = "key_textfield_study_ph";
  final String KEY_FIELD_FIRST_NAME = "key_textfield_firstName";
  final String KEY_FIELD_LAST_NAME = "key_textfield_lastName";
  final String KEY_FIELD_AGE = "key_textfield_age";
  final String KEY_FIELD_TEMP_ADDRESS = "key_textfield_temp_address";
  final String KEY_FIELD_PERMANENT_ADDRESS = "key_textfield_permanent_address";
  final String KEY_FIELD_DISTRICT = "key_textfield_district";
  final String KEY_FIELD_STATE = "key_textfield_state";
  final String KEY_FIELD_PINCODE = "key_textfield_pincode";
  final String KEY_FIELD_OCCUPATION_TYPE = "key_textfield_occupation_type";
  final String KEY_FIELD_DOCUMENT_TYPE = "key_textfield_document_type";
  final String KEY_FIELD_MOBILE = "key_textfield_mobile";
  final String KEY_FIELD_ALTERNATE_NUMBER = "key_textfield_alternate_number";
  final String KEY_FIELD_MEDICAL_RECORD_NUMBER = "key_textfield_medical_record_number";
  final String KEY_FIELD_DOCUMENT_TYPE_ID = "key_textfield_aadhar_id";
  final String KEY_FIELD_SIGNED_CONSENT = "key_textfield_signed_consent";
  final String KEY_FIELD_SIGNED_CONSENT_NO = "key_textfield_signed_consent_no";
  final String KEY_HEADING_FIRST_NAME = "key_heading_firstName";
  final String KEY_HEADING_DOV = "key_heading_date_of_visit";
  final String KEY_HEADING_INSTITUTION_CODE = "key_title_institutution_code";
  final String KEY_HEADING_STUDY_PH = "key_title_study_ph";
  final String KEY_HEADING_LAST_NAME = "key_heading_lastName";
  final String KEY_HEADING_GENDER = "key_heading_gender";
  final String KEY_HEADING_AGE = "key_heading_age";
  final String KEY_HEADING_TEMP_ADDRESS = "key_heading_temp_address";
  final String KEY_HEADING_PERMANENT_ADDRESS = "key_heading_permanent_address";
  final String KEY_HEADING_DISTRICT = "key_title_district";
  final String KEY_HEADING_STATE = "key_title_state";
  final String KEY_HEADING_PINCODE = "key_title_pincode";
  final String KEY_HEADING_OCCUPATION_TYPE = "key_title_occupation_type";
  final String KEY_HEADING_DOCUMENT_TYPE = "key_title_document_type";
  final String KEY_HEADING_MOBILE = "key_title_mobile";
  final String KEY_HEADING_ALTERNATE_NUMBER = "key_title_alternate_number";
  final String KEY_HEADING_MEDICAL_RECORD_NUMBER = "key_heading_medical_record_number";
  final String KEY_HEADING_DOCUMENT_ID = "key_heading_aadhar_id";
  final String KEY_HEADING_SIGNED_CONSENT = "key_title_signed_consent";
  final String KEY_HEADING_SIGNED_CONSENT_NO = "key_title_signed_consent_no";
  final String KEY_BUTTON_CONTINUE = "key_button_continue";
  final String KEY_FIELD_VISIT_NUMBER = "key_textfield_visit_number";
  final String KEY_HEADING_VISIT_NUMBER = "key_title_visit_number";
  final String KEY_FIELD_VISIT_MONTH = "key_textfield_visit_month";
  final String KEY_HEADING_VISIT_MONTH = "key_title_visit_month";
  final String KEY_TEXTFIELD_PLACE = "key_textfield_place";
  final String KEY_HEADING_PLACE = "key_heading_place";

  final String KEY_FIELD_PRIMARY_ID = "key_textfield_primary_id";
  final String KEY_HEADING_PRIMARY_ID = "key_heading_primary_id";

  final String KEY_FIELD_SECONDARY_ID = "key_textfield_secondary_id";
  final String KEY_HEADING_SECONDARY_ID = "key_heading_secondary_id";

  final String MOB_FIELD_PREFIX_TEXT = "+91";

  final FocusNode _dovFocusNode = FocusNode();
  final FocusNode _ageFocusNode = FocusNode();

  ValueNotifier<List<IdTextModel>> _visitNumberList = ValueNotifier<List<IdTextModel>>([]);
  ValueNotifier<List<IdTextModel>> _visitMonthList = ValueNotifier<List<IdTextModel>>([]);

  late ValueNotifier<IdTextModel?> _visitNumber;
  late ValueNotifier<IdTextModel?> _visitMonth;
  late ValueNotifier<String?> _institutionCode;
  late ValueNotifier<String?> _studyCode;
  late ValueNotifier<String?> _gender;
  late ValueNotifier<String?> _occupation;
  late ValueNotifier<String?> _document;
  late ValueNotifier<bool?> _documentType;
  late ValueNotifier<String?> _signConsent;
  late ValueNotifier<bool> _signedConsentCopy;
  late ValueNotifier<String?> _signedConsentNoReason;
  late ValueNotifier<bool> _buttonEnabled;
  late ValueNotifier<bool> _isConsentYesButtonActiveNotifier;
  late ValueNotifier<bool> _isConsentNoButtonActiveNotifier;
  late ValueNotifier<String> _consentTextNotifier;
  late ValueNotifier<bool> _consentError;

  late RegistrationViewModel registrationViewModel;

  getOccupationTypes() {
    String occupationTypes = TranslationKeys.occupation.translate(context);
    occupationIds = CommonFunctions.convertStringToListOfIds(occupationTypes);
    occupationNames = CommonFunctions.convertStringToListOfNames(occupationTypes);
  }

  getInstitutionCodes() {
    String institutionData = TranslationKeys.institutionCodes.translate(context);
    institutionIds = CommonFunctions.convertStringToListOfIds(institutionData);
    institutionNames = CommonFunctions.convertStringToListOfNames(institutionData);
  }

  getStudyCodes() {
    String studyData = TranslationKeys.studyCodes.translate(context);
    studyIds = CommonFunctions.convertStringToListOfIds(studyData);
    studyNames = CommonFunctions.convertStringToListOfNames(studyData);
  }

  getDocuments() {
    String documentsData = TranslationKeys.documents.translate(context);
    documentIds = CommonFunctions.convertStringToListOfIds(documentsData);
    documentNames = CommonFunctions.convertStringToListOfNames(documentsData);
  }

  getSignedConsentReasonCodes() {
    String signedConsentData = TranslationKeys.signedConsentReasonCodes.translate(context);
    signedConsentIds = CommonFunctions.convertStringToListOfIds(signedConsentData);
    signedConsentNames = CommonFunctions.convertStringToListOfNames(signedConsentData);
  }

  @override
  void initState() {
    super.initState();
    _isConsentNoButtonActiveNotifier = ValueNotifier<bool>(false);
    _isConsentYesButtonActiveNotifier = ValueNotifier<bool>(false);
    _buttonEnabled = ValueNotifier<bool>(true);
    _dateOfVisitController = TextEditingController(text: CommonFunctions.currentDate());
    _dateOfVisitFormatter = MaskTextInputFormatter(mask: '##/##/####', type: MaskAutoCompletionType.eager, initialText: _dateOfVisitController.text);
    _consentDateFormatter = MaskTextInputFormatter(mask: '##/##/####', type: MaskAutoCompletionType.eager, initialText: _dateOfVisitController.text);
    _consentDateController = TextEditingController(text: CommonFunctions.currentDate());
    registrationViewModel = Provider.of<RegistrationViewModel>(context, listen: false);
    registrationViewModel.resetScreen();
    initializeField();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getVisitNumber();
      getVisitMonthList();
      if (widget.patientId != null) {
        _bindData();
      }
    });
  }

  _bindData() async {
    PatientRegistration? resp = context.read<PatientListViewModel>().getPatientByPatientId(widget.patientId ?? ""); //await IsarDbService.isarDbService.getPatientDetails(widget.patientId ?? "");
    if (resp != null) {
      _buttonEnabled.value = false;
      _visitNumber.value = IdTextModel(
        id: _visitNumberList.value.firstWhereOrNull((visit) => visit.id == resp.visitNo)?.id ?? '',
        name: _visitNumberList.value.firstWhereOrNull((visit) => visit.id == resp.visitNo)?.name ?? '',
      );
      _visitMonthController.text = resp.visitMonth ?? "";
      _gender.value = AppConstant.GENDER_LIST
          .firstWhereOrNull(
            (gender) => gender.data?.toUpperCase() == resp.gender?.toUpperCase(),
          )
          ?.data;
      _consentTextNotifier.value = resp.isConsent;
      _isConsentYesButtonActiveNotifier.value = resp.isConsent.toUpperCase() == "YES" ? true : false;
      if (resp.institutionCodeID.isNotEmpty) {
        _institutionCode.value = institutionNames[institutionIds.indexOf(resp.institutionCodeID)];
      }
      _studyCode.value = studyNames[studyIds.indexOf(resp.studyCode)];

      _occupation.value = occupationNames[occupationIds.indexOf(resp.occupation)];
      _pincodeController.text = resp.pincode ?? "";
      _signConsent.value = resp.signedConsent.toUpperCase() == "TRUE" ? AppConstant.BINARY_LIST.first.data : AppConstant.BINARY_LIST.last.data;
      if (resp.signedConsentNoReason.isNotEmpty) {
        _signedConsentCopy.value = true;
        _signedConsentNoReason.value = signedConsentNames[signedConsentIds.indexOf(resp.signedConsentNoReason)];
      }
      if (resp.identityProofs != null) {
        _documentType.value = true;
        _document.value = documentNames[documentIds.indexOf(resp.identityProofs?.identityType ?? "")];
        _documentTypeController.text = resp.identityProofs?.value ?? "";
      }

      _firstNameController.text = resp.firstName;
      _lastNameController.text = resp.lastName;
      _ageController.text = resp.age;
      _alternateNumberFieldController.text = resp.alternatePhoneNumber ?? "";
      _consentDateController.text = DateFormat('dd/MM/yyyy').format(resp.consentDate);
      _placeController.text = resp.place;
      _tempAddressController.text = resp.address ?? "";
      _districtController.text = resp.district ?? "";
      _stateController.text = resp.state ?? "";
      _permanentAddressController.text = resp.permanentAddress ?? "";
      _mobileFieldController.text = resp.phoneNumber;
      _primaryIdController.text = resp.primaryId;
      _secondaryIdController.text = resp.secondaryId;
      _medicalRecordNumberController.text = resp.medicalRecordNumber ?? "";
    }
  }

  initializeField() {
    _visitNumber = ValueNotifier<IdTextModel?>(null);
    _visitMonth = ValueNotifier<IdTextModel?>(null);
    _consentTextNotifier = ValueNotifier<String>('');
    _institutionCode = ValueNotifier<String?>(null);
    _studyCode = ValueNotifier<String?>(null);
    _gender = ValueNotifier<String?>(null);
    _occupation = ValueNotifier<String?>(null);
    _document = ValueNotifier<String?>(null);
    _documentType = ValueNotifier<bool>(false);
    _signedConsentNoReason = ValueNotifier<String?>(null);
    _signConsent = ValueNotifier<String?>(null);
    _signedConsentCopy = ValueNotifier<bool>(false);
    _consentError = ValueNotifier<bool>(false);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getOccupationTypes();
    getInstitutionCodes();
    getDocuments();
    getStudyCodes();
    getSignedConsentReasonCodes();
  }

  getVisitNumber() {
    String visitTypeData = TranslationKeys.visitTypes.translate(context);
    List<String> visitTypeIds = CommonFunctions.convertStringToListOfIds(visitTypeData);
    List<String> visitTypeNames = CommonFunctions.convertStringToListOfNames(visitTypeData);

    List<IdTextModel> map = [];
    for (int i = 0; i < visitTypeIds.length; i++) {
      map.add(IdTextModel(id: visitTypeIds[i], name: visitTypeNames[i]));
    }
    _visitNumberList.value = map;
  }

  getVisitMonthList() {
    String visitMonthData = TranslationKeys.visitMonthTypeList.translate(context);
    List<dynamic> list = jsonDecode(visitMonthData);
    _visitMonthList.value = list.map((e) => IdTextModel.fromJson(e)).toList();
  }

  String _generatePrimaryId() {
    if (_primaryIdController.text.isNotEmpty) {
      return _primaryIdController.text.trim();
    }

    // Format for generating primaryId as below
    // First two char of firstName
    // First two char of place
    // current dateTime in ddMMyyyyHHmmssSSS
    DateTime now = DateTime.now();
    String dateTime = DateFormat(AppValues.idDateTimeFormat).format(now);
    String firstName = _firstNameController.text.trim().substring(0, 2);
    String placeName = _placeController.text.trim().substring(0, 2);
    String id = "${firstName.toUpperCase()}-${placeName.toUpperCase()}-$dateTime";
    return id;
  }

  String _generateSecondaryId() {
    if (_secondaryIdController.text.isNotEmpty) {
      return _secondaryIdController.text.trim();
    }
    // Format for generating secondaryId as below
    // First two char of Doctor Name
    // First two char of place
    // current dateTime in ddMMyyyyHHmmssSSS
    DateTime now = DateTime.now();
    String dateTime = DateFormat(AppValues.idDateTimeFormat).format(now);

    String doctorName = SharedPreferencesService.sharedPreferencesService.readData(key: AppConstant.SHREAD_PREF_DOC_KEY) ?? "";
    doctorName = doctorName.trim().substring(0, 2);

    String placeName = _placeController.text.trim().substring(0, 2);
    String id = "${doctorName.toUpperCase()}-${placeName.toUpperCase()}-$dateTime";
    return id;
  }

  void onContinueClick() async {
    final form = formKey.currentState;
    if (form != null) {
      if (_consentTextNotifier.value.isEmpty || _consentTextNotifier.value.toUpperCase() == "NO") {
        _consentError.value = true;
        CommonFunctions.toastMessage(AppConstant.SELECT_FILE_BEFORE_SUBMITTING);
      } else if (form.validate()) {
        registrationViewModel.isLoading = true;
        _consentError.value = false;
        String patientId = CommonFunctions.randomNumber(6);
        String userId = context.read<LoginViewModel>().userDetails?.userId ?? "";
        IdentityProofDb? identityProof;
        if (_documentTypeController.text.isNotEmpty) {
          identityProof = IdentityProofDb()
            ..identityType = _document.value != null ? documentIds[documentNames.indexOf(_document.value ?? "")] : ""
            ..value = _documentTypeController.text;
        }
        PatientRegistration registrationData = PatientRegistration()
          ..isConsent = _consentTextNotifier.value.toUpperCase()
          ..visitDate = CommonFunctions.textToDateTime(_dateOfVisitController.text)
          ..institutionCodeID = _institutionCode.value != null ? institutionIds[institutionNames.indexOf(_institutionCode.value ?? "")] : ""
          ..studyCode = studyIds[studyNames.indexOf(_studyCode.value ?? "")]
          ..firstName = _firstNameController.text.trim()
          ..lastName = _lastNameController.text.trim()
          ..age = _ageController.text
          ..gender = _gender.value?.toUpperCase()
          ..address = _tempAddressController.text
          ..district = _districtController.text
          ..state = _stateController.text
          ..pincode = _pincodeController.text
          ..permanentAddress = _permanentAddressController.text
          ..occupation = occupationIds[occupationNames.indexOf(_occupation.value ?? "")]
          ..phoneNumber = _mobileFieldController.text
          ..alternatePhoneNumber = _alternateNumberFieldController.text
          ..medicalRecordNumber = _medicalRecordNumberController.text
          ..identityProofs = identityProof
          ..consentDate = CommonFunctions.textToDateTime(_consentDateController.text)
          ..signedConsent = _signConsent.value?.toUpperCase() ?? ""
          ..signedConsentNoReason = _signedConsentNoReason.value != null ? signedConsentIds[signedConsentNames.indexOf(_signedConsentNoReason.value ?? "")] : ""
          ..patientId = patientId
          ..createdBy = userId
          ..place = _placeController.text.trim()
          ..visitNo = _visitNumber.value?.id
          ..visitMonth = _visitMonthController.text.trim()
          ..primaryId = _generatePrimaryId()
          ..secondaryId = _generateSecondaryId();

        bool isSaved = await context.read<PatientListViewModel>().registerPatient(registrationData);
        registrationViewModel.isLoading = false;
        if (isSaved) {
          //await IsarDbService.isarDbService.savePatient(registrationData);

          ///[COMMENTING BELOW LINE AS it may used in future]
          // await addConsentImages(patientId);
          await context.read<PatientListViewModel>().setCurrentUser(_firstNameController.text, _lastNameController.text);

          if (context.mounted) {
            GoRouter.of(context).replace(RegistrationSuccessFullScreen.routerPath, extra: {"patientId": patientId});
          }
        }
      }
    }
  }

  ///[COMMENTING code as this may need in future]
  // addConsentImages(String patientId) async {
  //   for (int i = 0; i < questionnaireViewModel.consentList.length; i++) {
  //     String? filePath = await CommonFunctions().saveFileToLocal(questionnaireViewModel.consentList[i]!.filePath);
  //     AttachmentDb attachment = AttachmentDb()
  //       ..fileName = questionnaireViewModel.consentList[i]!.fileName
  //       ..dataBytes = filePath;
  //     await IsarDbService.isarDbService.updatePatientRegistration(patientId: patientId, attachment: attachment);
  //   }
  //   questionnaireViewModel.consentList.clear();
  // }

  void onConsentYesClicked() async {
    _isConsentNoButtonActiveNotifier.value = false;
    _isConsentYesButtonActiveNotifier.value = true;
    _consentTextNotifier.value = 'YES';
    _consentError.value = false;
  }

  void onConsentNoClicked() async {
    _isConsentYesButtonActiveNotifier.value = false;
    _isConsentNoButtonActiveNotifier.value = true;
    _consentTextNotifier.value = 'No';
    _consentError.value = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        appBarTitleType: CustomAppBarTitleType.TEXT,
        titleText: TranslationKeys.registration.translate(context),
        centerTitle: false,
        onLeadingClick: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TranslationKeys.informedConsentObtained.translate(context),
                  style: AppStyles.bodyMedium,
                ),
                const SpaceWidget(height: 5),
                //CONSENT BUTTON
                Row(
                  children: [
                    ValueListenableBuilder<bool>(
                        valueListenable: _isConsentYesButtonActiveNotifier,
                        builder: (context, isButtonActive, child) {
                          return PrimaryOutlinedButton(
                            buttonThemeStyle: OutlinedButtonThemeStyle(
                                buttonPadding: const EdgeInsets.symmetric(horizontal: 50),
                                enabledTextColor: isButtonActive ? AppColorScheme.kEnabledButtonColor : AppColorScheme.kGrayColor.shade400,
                                enabledButtonColor: isButtonActive ? AppColorScheme.kSuccessStatusColor : AppColorScheme.kWhite,
                                enabledBorderColor: isButtonActive ? AppColorScheme.kSuccessStatusColor : AppColorScheme.kGrayColor.shade400),
                            buttonTitle: TranslationKeys.yes.translate(context),
                            widgetKey: KEY_BUTTON_YES_CONSENT,
                            onPressed: widget.isEditable ? onConsentYesClicked : () {},
                          );
                        }),
                    const SpaceWidget(width: 10.0),
                    ValueListenableBuilder<bool>(
                        valueListenable: _isConsentNoButtonActiveNotifier,
                        builder: (context, isButtonActive, child) {
                          return PrimaryOutlinedButton(
                            buttonThemeStyle: OutlinedButtonThemeStyle(
                                buttonPadding: const EdgeInsets.symmetric(horizontal: 50),
                                enabledTextColor: isButtonActive ? AppColorScheme.kEnabledButtonColor : AppColorScheme.kGrayColor.shade400,
                                enabledButtonColor: isButtonActive ? AppColorScheme.errorTextColor : AppColorScheme.kWhite,
                                enabledBorderColor: isButtonActive ? AppColorScheme.errorTextColor : AppColorScheme.kGrayColor.shade400),
                            buttonTitle: TranslationKeys.no.translate(context),
                            widgetKey: KEY_BUTTON_NO_CONSENT,
                            onPressed: widget.isEditable ? onConsentNoClicked : () {},
                          );
                        }),
                  ],
                ),
                ValueListenableBuilder(
                  valueListenable: _consentError,
                  builder: (context, isEmpty, __) {
                    if (isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            AppConstant.CONSENT_REQUIRED,
                            style: AppStyles.errorStyle,
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                const SpaceWidget(
                  height: 15,
                ),
                //DATE OF VISIT
                CustomTextField(
                  enabled: widget.isEditable ? true : false,
                  controller: _dateOfVisitController,
                  focusNode: _dovFocusNode,
                  widgetKey: Key(KEY_FIELD_DATE_OF_VISIT),
                  hintText: AppConstant.HINT_TEXT_DATE,
                  heading: TranslationKeys.dateOfVisit.translate(context),
                  headingKey: Key(KEY_HEADING_DOV),
                  hasPrefix: true,
                  prefixType: TextFieldPrefixSuffixType.SVG_ASSET,
                  prefixData: AppAssetsPath.icCalender,
                  inputFormatters: [
                    _dateOfVisitFormatter,
                  ],
                  validator: (value) => AppValidators.validateDate(
                      value: value, emptyErrorMessage: "Date can't be empty.", validErrorMessage: "Enter valid date.", futureDateErrorMessage: "Future date is not allowed."),
                  keyboardType: TextInputType.number,
                ),
                const SpaceWidget(
                  height: 15,
                ),
                //PLACE
                CustomTextField(
                  enabled: widget.isEditable ? true : false,
                  controller: _placeController,
                  widgetKey: Key(KEY_TEXTFIELD_PLACE),
                  hintText: TranslationKeys.enterHere.translate(context),
                  heading: "${TranslationKeys.place.translate(context)}*",
                  headingKey: Key(KEY_HEADING_PLACE),
                  validator: AppValidators.placeFieldValidator,
                  keyboardType: TextInputType.text,
                ),
                const SpaceWidget(
                  height: 15,
                ),
                //VISIT NO
                ValueListenableBuilder<List<IdTextModel>>(
                    valueListenable: _visitNumberList,
                    builder: (context, map, _) {
                      return ValueListenableBuilder<IdTextModel?>(
                        valueListenable: _visitNumber,
                        builder: (context, _, __) {
                          return CustomDropdown<IdTextModel>(
                            isEnabled: widget.isEditable ? true : false,
                            widgetKey: KEY_FIELD_VISIT_NUMBER,
                            heading: TranslationKeys.visitNumber.translate(context),
                            headingKey: Key(KEY_HEADING_VISIT_NUMBER),
                            hintText: TranslationKeys.select.translate(context),
                            onChanged: (val) {
                              _visitNumber.value = val;
                            },
                            selectedItem: _visitNumber.value,
                            compareFn: (p0, p1) => p0.id == p1.id,
                            items: map,
                          );
                        },
                      );
                    }),
                const SpaceWidget(
                  height: 15,
                ),
                CustomTextField(
                  enabled: widget.isEditable ? true : false,
                  controller: _visitMonthController,
                  widgetKey: Key(KEY_FIELD_VISIT_MONTH),
                  hintText: TranslationKeys.enterHere.translate(context),
                  heading: TranslationKeys.visitMonth.translate(context),
                  headingKey: Key(KEY_HEADING_VISIT_MONTH),
                  keyboardType: TextInputType.number,
                ),
                //VISIT MONTH
                // ValueListenableBuilder<List<IdTextModel>>(
                // valueListenable: _visitMonthList,
                // builder: (context, map, _) {
                // return ValueListenableBuilder<IdTextModel?>(
                // valueListenable: _visitMonth,
                // builder: (context, _, __) {
                // return CustomDropdown<IdTextModel>(
                // isEnabled: widget.isEditable ? true : false,
                // widgetKey: KEY_FIELD_VISIT_MONTH,
                // heading: TranslationKeys.visitMonth.translate(context),
                // headingKey: Key(KEY_HEADING_VISIT_MONTH),
                // hintText: TranslationKeys.select.translate(context),
                // onChanged: (val) {
                // _visitMonth.value = val;
                // },
                // selectedItem: _visitMonth.value,
                // compareFn: (p0, p1) => p0.id == p1.id,
                // items: map,
                // );
                // },
                // );
                // }),
                const SpaceWidget(
                  height: 15,
                ),
                //INSTITUTION CODE
                ValueListenableBuilder<String?>(
                    valueListenable: _institutionCode,
                    builder: (context, _, __) {
                      return CustomDropdown<String>(
                        isEnabled: widget.isEditable ? true : false,
                        widgetKey: KEY_FIELD_INSTITUTION_CODE,
                        heading: TranslationKeys.institutionCodeId.translate(context),
                        headingKey: Key(KEY_HEADING_INSTITUTION_CODE),
                        hintText: TranslationKeys.select.translate(context),
                        onChanged: (val) {
                          _institutionCode.value = val;
                        },
                        selectedItem: _institutionCode.value,
                        items: institutionNames,
                      );
                    }),
                const SpaceWidget(
                  height: 15,
                ),
                //STUDY
                ValueListenableBuilder<String?>(
                    valueListenable: _studyCode,
                    builder: (context, _, __) {
                      return CustomDropdown<String>(
                        isEnabled: widget.isEditable ? true : false,
                        widgetKey: KEY_FIELD_STUDY_PH,
                        heading: TranslationKeys.studyCode.translate(context),
                        headingKey: Key(KEY_HEADING_STUDY_PH),
                        hintText: TranslationKeys.select.translate(context),
                        onChanged: (val) {
                          _studyCode.value = val;
                        },
                        selectedItem: _studyCode.value,
                        items: studyNames,
                        validator: AppValidators.requiredField,
                        // validator: AppValidators.requiredField,
                      );
                    }),
                const SpaceWidget(
                  height: 15,
                ),
                //First Name Widget
                CustomTextField(
                  enabled: widget.isEditable ? true : false,
                  controller: _firstNameController,
                  widgetKey: Key(KEY_FIELD_FIRST_NAME),
                  hintText: TranslationKeys.enterHere.translate(context),
                  heading: "${TranslationKeys.firstName.translate(context)}*",
                  headingKey: Key(KEY_HEADING_FIRST_NAME),
                  validator: AppValidators.requiredMoreThanTwoCharField,
                  inputFormatters: [
                    AppValues.stringInputFormatter,
                  ],
                ),
                const SpaceWidget(
                  height: 15,
                ),
                //Last Name Widget
                CustomTextField(
                  enabled: widget.isEditable ? true : false,
                  controller: _lastNameController,
                  widgetKey: Key(KEY_FIELD_LAST_NAME),
                  hintText: TranslationKeys.enterHere.translate(context),
                  heading: "${TranslationKeys.lastName.translate(context)}*",
                  headingKey: Key(KEY_HEADING_LAST_NAME),
                  validator: AppValidators.requiredField,
                  inputFormatters: [
                    AppValues.stringInputFormatter,
                  ],
                ),
                const SpaceWidget(
                  height: 15,
                ),
                //AGE
                CustomTextField(
                  enabled: widget.isEditable ? true : false,
                  controller: _ageController,
                  focusNode: _ageFocusNode,
                  widgetKey: Key(KEY_FIELD_AGE),
                  hintText: TranslationKeys.enterHere.translate(context),
                  heading: "${TranslationKeys.age.translate(context)}*",
                  headingKey: Key(KEY_HEADING_AGE),
                  validator: AppValidators.validateAge,
                  keyboardType: TextInputType.number,
                ),
                const SpaceWidget(
                  height: 15,
                ),
                //Gender
                ValueListenableBuilder(
                  valueListenable: _gender,
                  builder: (context, _, __) {
                    return CustomChipWidget<String?>(
                      shouldTranslate: true,
                      chipList: AppConstant.GENDER_LIST,
                      onChanged: widget.isEditable
                          ? (value) {
                              _gender.value = value;
                            }
                          : (val) {},
                      validator: AppValidators.validateGender,
                      selectedItem: _gender.value,
                      heading: "${TranslationKeys.gender.translate(context)}*",
                      headingKey: Key(KEY_HEADING_GENDER),
                    );
                  },
                ),

                const SpaceWidget(
                  height: 15,
                ),
                //ADDRESS
                CustomTextField(
                  enabled: widget.isEditable ? true : false,
                  controller: _tempAddressController,
                  widgetKey: Key(KEY_FIELD_TEMP_ADDRESS),
                  hintText: TranslationKeys.enterHere.translate(context),
                  heading: TranslationKeys.address.translate(context),
                  headingKey: Key(KEY_HEADING_TEMP_ADDRESS),
                  maxLines: 3,
                  keyboardType: TextInputType.text,
                ),
                const SpaceWidget(
                  height: 15,
                ),
                //DISTRICT
                CustomTextField(
                  enabled: widget.isEditable ? true : false,
                  controller: _districtController,
                  widgetKey: Key(KEY_FIELD_DISTRICT),
                  hintText: TranslationKeys.enterHere.translate(context),
                  heading: TranslationKeys.district.translate(context),
                  headingKey: Key(KEY_HEADING_DISTRICT),
                  keyboardType: TextInputType.text,
                ),
                const SpaceWidget(
                  height: 15,
                ),
                //STATE
                CustomTextField(
                  enabled: widget.isEditable ? true : false,
                  controller: _stateController,
                  widgetKey: Key(KEY_FIELD_STATE),
                  hintText: TranslationKeys.enterHere.translate(context),
                  heading: TranslationKeys.state.translate(context),
                  headingKey: Key(KEY_HEADING_STATE),
                  keyboardType: TextInputType.text,
                ),
                const SpaceWidget(
                  height: 15,
                ),
                //PINCODE
                CustomTextField(
                  enabled: widget.isEditable ? true : false,
                  controller: _pincodeController,
                  widgetKey: Key(KEY_FIELD_PINCODE),
                  hintText: TranslationKeys.enterHere.translate(context),
                  heading: TranslationKeys.pincode.translate(context),
                  headingKey: Key(KEY_HEADING_PINCODE),
                  validator: AppValidators.validatePincode,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    MaskTextInputFormatter(mask: '######'),
                  ],
                ),
                const SpaceWidget(
                  height: 15,
                ),
                //PERMANENT ADDRESS
                CustomTextField(
                  enabled: widget.isEditable ? true : false,
                  controller: _permanentAddressController,
                  widgetKey: Key(KEY_FIELD_PERMANENT_ADDRESS),
                  hintText: TranslationKeys.enterHere.translate(context),
                  heading: TranslationKeys.permanentAddress.translate(context),
                  headingKey: Key(KEY_HEADING_PERMANENT_ADDRESS),
                  maxLines: 3,
                  keyboardType: TextInputType.text,
                ),
                const SpaceWidget(
                  height: 15,
                ),
                //OCCUPATION TYPE
                ValueListenableBuilder<String?>(
                    valueListenable: _occupation,
                    builder: (context, _, __) {
                      return CustomDropdown<String>(
                        isEnabled: widget.isEditable ? true : false,
                        widgetKey: KEY_FIELD_OCCUPATION_TYPE,
                        heading: TranslationKeys.occupationType.translate(context),
                        headingKey: Key(KEY_HEADING_OCCUPATION_TYPE),
                        hintText: TranslationKeys.select.translate(context),
                        onChanged: (val) {
                          _occupation.value = val;
                        },
                        selectedItem: _occupation.value,
                        items: occupationNames,
                        validator: AppValidators.requiredField,
                      );
                    }),
                const SpaceWidget(
                  height: 15,
                ),
                //MOBILE
                CustomTextField(
                  enabled: widget.isEditable ? true : false,
                  widgetKey: Key(KEY_FIELD_MOBILE),
                  controller: _mobileFieldController,
                  hasPrefix: true,
                  prefixType: TextFieldPrefixSuffixType.TEXT,
                  prefixData: MOB_FIELD_PREFIX_TEXT,
                  hintText: TranslationKeys.enterHere.translate(context),
                  heading: "${TranslationKeys.mobileNumber.translate(context)}*",
                  headingKey: Key(KEY_HEADING_MOBILE),
                  validator: AppValidators.validateMobile,
                  inputFormatters: [
                    MaskTextInputFormatter(mask: '##########'),
                  ],
                  keyboardType: TextInputType.number,
                ),
                const SpaceWidget(
                  height: 15,
                ),
                //ALTERNATE MOBILE NUMBER
                CustomTextField(
                  enabled: widget.isEditable ? true : false,
                  widgetKey: Key(KEY_FIELD_ALTERNATE_NUMBER),
                  controller: _alternateNumberFieldController,
                  hasPrefix: true,
                  prefixType: TextFieldPrefixSuffixType.TEXT,
                  prefixData: MOB_FIELD_PREFIX_TEXT,
                  hintText: TranslationKeys.enterHere.translate(context),
                  heading: TranslationKeys.alternatePhoneNumber.translate(context),
                  headingKey: Key(KEY_HEADING_ALTERNATE_NUMBER),
                  validator: AppValidators.validateAlternateNumber,
                  inputFormatters: [
                    MaskTextInputFormatter(mask: '##########'),
                  ],
                  keyboardType: TextInputType.number,
                ),
                const SpaceWidget(
                  height: 15,
                ),
                //PRIMARY ID
                CustomTextField(
                  enabled: widget.isEditable ? true : false,
                  widgetKey: Key(KEY_FIELD_PRIMARY_ID),
                  controller: _primaryIdController,
                  hintText: TranslationKeys.enterHere.translate(context),
                  heading: TranslationKeys.primaryId.translate(context),
                  headingKey: Key(KEY_HEADING_PRIMARY_ID),
                  keyboardType: TextInputType.text,
                  inputFormatters: [_idInputFormatter, UpperCaseTextFormatter()],
                  validator: (p0) {
                    if (_primaryIdController.text.trim().isEmpty && _secondaryIdController.text.trim().isNotEmpty) {
                      return AppConstant.FIELD_REQUIRED;
                    }
                    if (_primaryIdController.text.trim().isNotEmpty && _primaryIdController.text.trim().length != 16) {
                      return AppConstant.ERROR_INVALID_ID;
                    }
                    return null;
                  },
                ),
                const SpaceWidget(
                  height: 15,
                ),
                //SECONDARY ID
                CustomTextField(
                  enabled: widget.isEditable ? true : false,
                  widgetKey: Key(KEY_FIELD_SECONDARY_ID),
                  controller: _secondaryIdController,
                  hintText: TranslationKeys.enterHere.translate(context),
                  heading: TranslationKeys.secondaryId.translate(context),
                  headingKey: Key(KEY_HEADING_SECONDARY_ID),
                  keyboardType: TextInputType.text,
                  inputFormatters: [_idInputFormatter, UpperCaseTextFormatter()],
                  validator: (p0) {
                    if (_secondaryIdController.text.trim().isEmpty && _primaryIdController.text.trim().isNotEmpty) {
                      return AppConstant.FIELD_REQUIRED;
                    }
                    if (_secondaryIdController.text.trim().isNotEmpty && _secondaryIdController.text.trim().length != 16) {
                      return AppConstant.ERROR_INVALID_ID;
                    }
                    return null;
                  },
                ),
                const SpaceWidget(
                  height: 15,
                ),
                //MEDICAL RECORD NUMBER
                CustomTextField(
                  enabled: widget.isEditable ? true : false,
                  controller: _medicalRecordNumberController,
                  widgetKey: Key(KEY_FIELD_MEDICAL_RECORD_NUMBER),
                  hintText: TranslationKeys.enterHere.translate(context),
                  heading: TranslationKeys.medicalId.translate(context),
                  headingKey: Key(KEY_HEADING_MEDICAL_RECORD_NUMBER),
                  keyboardType: TextInputType.text,
                ),
                const SpaceWidget(
                  height: 15,
                ),
                //DOCUMENT
                ValueListenableBuilder<String?>(
                    valueListenable: _document,
                    builder: (context, _, __) {
                      return CustomDropdown<String>(
                        isEnabled: widget.isEditable ? true : false,
                        widgetKey: KEY_FIELD_DOCUMENT_TYPE,
                        heading: TranslationKeys.aadharVoterPan.translate(context),
                        headingKey: Key(KEY_HEADING_DOCUMENT_TYPE),
                        hintText: TranslationKeys.select.translate(context),
                        onChanged: (val) {
                          setState(() {
                            _document.value = val;
                            _documentType.value = true;
                            _documentTypeController.clear();
                          });
                        },
                        selectedItem: _document.value,
                        items: documentNames,
                      );
                    }),
                const SpaceWidget(
                  height: 15,
                ),
                ValueListenableBuilder(
                    valueListenable: _documentType,
                    builder: (context, value, __) {
                      if (value ?? false) {
                        return CustomTextField(
                          enabled: widget.isEditable ? true : false,
                          controller: _documentTypeController,
                          widgetKey: Key(KEY_FIELD_DOCUMENT_TYPE_ID),
                          hintText: TranslationKeys.enterHere.translate(context),
                          heading: "${_document.value}",
                          headingKey: Key(KEY_HEADING_DOCUMENT_ID),
                          validator: getDocumentWidget(),
                          keyboardType: getDocumentKeyboardType(),
                          inputFormatters: widget.isEditable ? getInputFormatter() : null,
                        );
                      } else {
                        return const SizedBox();
                      }
                    }),
                const SpaceWidget(
                  height: 15,
                ),
                //DATE OF CONSENT OBTAINED
                CustomTextField(
                  enabled: widget.isEditable ? true : false,
                  controller: _consentDateController,
                  widgetKey: Key(KEY_FIELD_DATE_OF_VISIT),
                  heading: TranslationKeys.informedConsentDate.translate(context),
                  headingKey: Key(KEY_HEADING_DOV),
                  hasPrefix: true,
                  prefixType: TextFieldPrefixSuffixType.SVG_ASSET,
                  prefixData: AppAssetsPath.icCalender,
                  inputFormatters: [
                    _consentDateFormatter,
                  ],
                  validator: (value) => AppValidators.validateDate(
                      value: value, emptyErrorMessage: "Date can't be empty.", validErrorMessage: "Enter valid date.", futureDateErrorMessage: "Future date is not allowed."),
                  keyboardType: TextInputType.number,
                ),
                const SpaceWidget(
                  height: 15,
                ),
                //SIGNED CONSENT
                ValueListenableBuilder(
                  valueListenable: _signConsent,
                  builder: (context, _, __) {
                    return CustomChipWidget<String?>(
                      shouldTranslate: true,
                      chipList: AppConstant.BINARY_LIST,
                      onChanged: widget.isEditable
                          ? (value) {
                              _signConsent.value = value;
                              if (value == 'no') {
                                _signedConsentCopy.value = true;
                              } else {
                                _signedConsentCopy.value = false;
                                _signedConsentNoReason.value = null;
                              }
                            }
                          : (val) {},
                      validator: AppValidators.validateBinaryQuestion,
                      selectedItem: _signConsent.value,
                      heading: TranslationKeys.copyOfSignedConsentHanded.translate(context),
                      headingKey: Key(KEY_FIELD_SIGNED_CONSENT),
                    );
                  },
                ),
                const SpaceWidget(
                  height: 15,
                ),
                //SIGNED CONSENT COPY REASON
                ValueListenableBuilder<bool>(
                    valueListenable: _signedConsentCopy,
                    builder: (context, isValid, _) {
                      return isValid
                          ? ValueListenableBuilder<String?>(
                              valueListenable: _signedConsentNoReason,
                              builder: (context, _, __) {
                                return CustomDropdown<String>(
                                  isEnabled: widget.isEditable ? true : false,
                                  widgetKey: KEY_FIELD_SIGNED_CONSENT_NO,
                                  heading: TranslationKeys.ifNoSpecify.translate(context),
                                  headingKey: Key(KEY_HEADING_SIGNED_CONSENT_NO),
                                  hintText: TranslationKeys.select.translate(context),
                                  onChanged: (val) {
                                    _signedConsentNoReason.value = val;
                                  },
                                  selectedItem: _signedConsentNoReason.value,
                                  items: signedConsentNames,
                                );
                              })
                          : const SizedBox.shrink();
                    }),
                const SpaceWidget(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Selector<RegistrationViewModel, bool>(
                    selector: (_, provider) => provider.isLoading,
                    builder: (context, isLoading, __) {
                      if (isLoading) {
                        return const SizedBox(
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else {
                        return ValueListenableBuilder<bool>(
                          valueListenable: _buttonEnabled,
                          builder: (context, isValid, _) {
                            return PrimaryFilledButton(
                              buttonThemeStyle: const FilledButtonThemeStyle(disabledTextColor: Colors.white),
                              buttonTitle: TranslationKeys.continueText.translate(context),
                              widgetKey: KEY_BUTTON_CONTINUE,
                              isLoading: false,
                              onPressed: widget.isEditable
                                  ? !isValid
                                      ? null
                                      : () {
                                          onContinueClick();
                                        }
                                  : null,
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getDocumentWidget() {
    if (_document.value == "Aadhar number") {
      return AppValidators.validateAadhar;
    } else if (_document.value == "PAN number") {
      return AppValidators.validatePAN;
    } else {
      return null;
    }
  }

  getDocumentKeyboardType() {
    if (_document.value == "Aadhar number") {
      return TextInputType.number;
    } else if (_document.value == "PAN number") {
      return TextInputType.name;
    } else {
      return TextInputType.text;
    }
  }

  getInputFormatter() {
    if (_document.value == "Aadhar number") {
      return <TextInputFormatter>[
        _CreditCardNumberFormatter(),
      ];
    } else {
      return <TextInputFormatter>[];
    }
  }
}

class _CreditCardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Filter out non-numeric characters
    String text = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Add hyphens at appropriate positions
    if (text.length >= 4 && text.length <= 8) {
      if (text.length == 4) {
        text = text.substring(0, 3);
      }
      text = '${text.substring(0, 4)}-${text.substring(4)}';
    } else if (text.length >= 9 && text.length <= 12) {
      text = '${text.substring(0, 4)}-${text.substring(4, 8)}-${text.substring(8)}';
    }

    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
