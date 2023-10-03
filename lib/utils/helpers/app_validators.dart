import 'package:intl/intl.dart';
import 'package:mhealth/utils/app_values.dart';

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


  static String? validateAlternateNumber(value) {
    const String kValidValidator = "Phone number is invalid";

    String pattern = r"^[6-9]\d{9}$";
    RegExp regExp = RegExp(pattern);

    if(value.toString().isNotEmpty) {
      if (!regExp.hasMatch(value)) {
        return kValidValidator;
      }
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
    String pattern = r"^([a-zA-Z0-9_\-\.\+]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$";
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return kValidValidator;
    }

    return null;
  }

  static String? requiredField(value) {
    const String kEmptyValidator = "This field is required.";

    if (value == null || value.isEmpty) {
      return kEmptyValidator;
    }

    return null;
  }

  static String? validateGender(value) {
    if (value == null || value.isEmpty) {
      return "Select Gender";
    }

    return null;
  }


  static String? validateDOB(value) {
    const String kDOBEmptyValidator = "DOB can't be empty.";
    const String kDOBFutureValidator = "DOB can't be a future date.";
    const String kValidDOBValidator = "Enter Valid DOB.";

    if (value == null || value.isEmpty) {
      return null;
    }

    final formattedDateNow = DateFormat('dd/MM/yyyy').format(DateTime.now());

    String pattern = r"^([0-2][0-9]|(3)[0-1])(\/)(((0)[0-9])|((1)[0-2]))(\/)\d{4}$";
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return kValidDOBValidator;
    } else {
      try {
        DateTime inputDate = DateFormat(AppValues.dobDateFormat).parse(value);
        DateTime todayDate = DateTime.now();
        if (inputDate.compareTo(todayDate) == 1) {
          return kDOBFutureValidator;
        }
      } catch (e) {
        return kValidDOBValidator;
      }
    }

    if (formattedDateNow == value.toString()) {
      return kDOBFutureValidator;
    }

    return null;
  }

  static String? validateDate(value) {
    const String kDOVEmptyValidator = "Date Of Visit can't be empty.";
    const String kDOVFutureValidator = "Date Of Visit can't be a future date.";
    const String kValidDOVValidator = "Enter Valid Date Of Visit.";
    if (value == null || value.isEmpty) {
      return kDOVEmptyValidator;
    }

    String pattern = r"^([0-2][0-9]|(3)[0-1])(\/)(((0)[0-9])|((1)[0-2]))(\/)\d{4}$";
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return kValidDOVValidator;
    } else {
      try {
        DateTime inputDate = DateFormat(AppValues.dobDateFormat).parse(value);
        DateTime todayDate = DateTime.now();
        if (inputDate.compareTo(todayDate) == 1) {
          return kDOVFutureValidator;
        }
      } catch (e) {
        return kValidDOVValidator;
      }
    }

    return null;
  }

  static String? validateAge(String? value) {
    const String kAgeEmptyValidator = "Age can't be empty.";
    const String kValidAgeValidator = "Enter Valid Age.";

    if (value == null || value.isEmpty) {
      return kAgeEmptyValidator;
    }

    try {
      int age = int.parse(value);
      if (age > 150 || age <= 0) {
        return kValidAgeValidator;
      }
    } catch (e) {
      return kValidAgeValidator;
    }

    return null;
  }

  static String? validateAadhar(value) {
    const String kEmptyValidator = "Enter Valid Aadhar number.";
    const String kValidValidator = "Aadhar must be of 12 digit.";
    if (value == null || value.isEmpty) {
      return null;
    }
    String pattern = r"^\d{12}$";
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return kValidValidator;
    }

    return null;
  }

  static String? validateID(String? value) {
    const String kEmptyValidator = "Enter Valid Medical ID.";
    const String kValidValidator = "Enter a valid ID.";
    if (value == null || value.isEmpty) {
      return kEmptyValidator;
    }
    String pattern = r"^[a-zA-Z0-9]{5}$";
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return kValidValidator;
    }

    return null;
  }

  static String? validateBinaryQuestion(value) {
    if (value == null || value.isEmpty) {
      return "Select an option";
    }

    return null;
  }

  static String? validatePincode(value) {
    const String kValidValidator = "Pincode must be of 6 digit.";
    String pattern = r"^\d{6}$";
    RegExp regExp = RegExp(pattern);
    if (value.toString().isNotEmpty) {
      if (!regExp.hasMatch(value)) {
        return kValidValidator;
      }
    }

    return null;
  }

}