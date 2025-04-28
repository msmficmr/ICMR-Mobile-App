enum CustomAppBarTitleType { TEXT, HORIZONTAL_APP_ICON, APP_ICON, WIDGET }

enum CustomAppBarTrailingType { NONE, SINGLE, MULTIPLE }

enum TextFieldPrefixSuffixType { TEXT, SVG_ASSET, IMAGE_ASSET }

enum MaskAutoCompletionType { lazy, eager }

/// These enums are used on login home to switch between mobile number and verification.
enum LoginScreenTypes { EMAIL, MOBILE_NUMBER, OTP_SCREEN }

enum NetworkStatus { online, offline }

enum CustomFloatingAssetTypes { SVG, ICON }

enum LocationPermissionStatus { SERVICE_DISABLED, GRANTED, WHILE_IN_USE, DENIED, FOREVER_DENIED }

enum CircularAvatarFieldChildType { TEXT, SVG_ASSET, IMAGE_ASSET }

enum ScreenNames { REGISTRATION_SCREEN, TAKE_CRA_SCREEN }

enum AuthType { mobile, email }

enum QuestionType { SINGLE_SELECT_CHIP }

enum LanguageCodes { en_US, hi }

enum QuestionnaireTemplateIds {
  community_risk_assessment_baseline_signs_or_symptoms,
  community_risk_assessment_details_of_habits,
  community_risk_assessment_investigation,
  community_risk_assessment_lesion_location,
  community_risk_assessment_measurement_lesions,
  community_risk_assessment_periodontal_status,
  community_risk_assessment_verification_form
}

enum ApiStatus {
  loading,
  success,
  error;
}
