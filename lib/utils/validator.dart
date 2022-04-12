import 'package:sbsi/generated/l10n.dart';

class Validator {
  static final RegExp _phoneRegex = RegExp(r'(\+84|0)\d{9}$');

  //static final RegExp _otpRegex = RegExp(r'\d{6}$');

  static final RegExp _emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  String? checkUser(String value) {
    if (value.isEmpty) {
      return S.current.please_input_user;
    } else {
      return null;
    }
  }

  String? checkPass(String value) {
    if (value.isEmpty) {
      return S.current.please_input_password;
    } else {
      return null;
    }
  }

  String? checkFullName(String value) {
    if (value.isEmpty) {
      return S.current.please_input_full_name;
    } else {
      return null;
    }
  }

  String? checkPhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      return S.current.please_input_phone_number;
    } else if (!_phoneRegex.hasMatch(phoneNumber)) {
      return S.current.phone_not_valid;
    } else {
      return null;
    }
  }

  String? checkEmail(String email) {
    if (email.isEmpty) {
      return S.current.please_input_email;
    } else if (!_emailRegex.hasMatch(email)) {
      return S.current.email_not_valid;
    } else {
      return null;
    }
  }
}
