class AppValidators {

  static String? validateMobile(value, {bool allowEmpty = false}) {
    const String kEmptyValidator = "Phone number cannot be empty";
    const String kValidValidator = "Phone number is invalid";

    if (value == null || value.isEmpty && !allowEmpty) {
      return kEmptyValidator;
    }

    if ((value == null || value.isEmpty) && allowEmpty) {
      return null;
    }

    String pattern = r"^[6-9]\d{9}$";
    RegExp regExp = RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return kValidValidator;
    }
    return null;
  }

  static String? validateOTP(value) {
    const String kEmptyValidator = "Enter Valid OTP.";
    const String kValidValidator = "OTP must be of 6 digit.";
    if (value == null || value.isEmpty) {
      return kEmptyValidator;
    }
    String pattern = r"^\d{6}$";
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return kValidValidator;
    }

    return null;
  }

  static String? validateEmail(value, {bool allowEmpty = false}) {
    const String kEmptyValidator = "Email can't be empty.";
    const String kValidValidator = "Email is invalid.";
    if (value == null || value.isEmpty && !allowEmpty) {
      return kEmptyValidator;
    }
    if ((value == null || value.isEmpty) && allowEmpty) {
      return null;
    }
    String pattern = r'^[a-zA-Z0-9-._@]*$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return kValidValidator;
    }

    return null;
  }


}