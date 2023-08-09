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

/// Enum to describe the current status of ServiceFlow
enum ServiceFlow { riskAssessment, none, registration, loginIntent, languageIntent }

/// Enum to describe the current EncounterId
enum EncounterIds { RISK_ASSESSMENT }

/// Enum to describe the current status of Payment
enum PhaseStatus { PAYMENT_SUCCESS, RISK_SCORE_CALCULATED, INPROGRESS, COMPLETED }