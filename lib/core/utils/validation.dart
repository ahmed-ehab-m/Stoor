import 'package:email_validator/email_validator.dart';

class FormValidation {
  static String? validateName(String value) {
    if (value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  /////////////////////////////
  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  /////////////////////////////
  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    }
    // final regex = RegExp(kPattern);
    if (EmailValidator.validate(value) == false) {
      return 'Please enter a valid email address';
    }
    return null;
  }
}
