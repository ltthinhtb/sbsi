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
    if (value.trim().isEmpty) {
      return S.current.please_input_password;
    } else if (!hasMinNumericChar(value, 0)) {
      return "Phải có ít nhất một ký tự số";
    } else if (!hasMinNormalChar(value, 0)) {
      return "Phải có ít nhất một ký tự chữ";
    } else if (value.trim().length < 6) {
      return S.current.pass_short_valid(6);
    } else {
      return null;
    }
  }


  String? checkNewPass(String value) {
    if (value.trim().isEmpty) {
      return S.current.please_input_password;
    } else if (!hasMinNumericChar(value, 1)) {
      return S.current.password_validate;
    } else if (!hasMinNormalChar(value, 1)) {
      return S.current.password_validate;
    } else if (value.trim().length < 8) {
      return S.current.password_validate;
    } else {
      return null;
    }
  }

  String? checkConfirmPass(String rePass, String pass) {
    if (rePass.isEmpty) {
      return S.current.please_input_password;
    } else if (rePass != pass) {
      return S.current.pass_not_match;
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

  String? checkAccount(String account) {
    if (account.isEmpty) {
      return S.current.please_input_account;
    } else {
      return null;
    }
  }

  String? checkAmount(num amount, num maxAmount) {
    if (amount <= 0) {
      return S.current.amount_not_valid;
    } else if (amount > maxAmount) {
      return S.current.amount_max_valid;
    } else {
      return null;
    }
  }

  String? checkMoney1(int amount, int maxAmount) {
    if (amount <= 0) {
      return S.current.please_input_money;
    } else if (amount > maxAmount) {
      return S.current.money_valid;
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

  String? checkMoney(String? money, int maxMoney) {
    if (money == null || money.isEmpty) return S.current.please_input_money;
    var value = double.parse(money);
    if (value <= 0) return S.current.money_valid;
    if (value > maxMoney) return S.current.not_enough_transfer;
    return null;
  }

  String? checkContent(String value) {
    if (value.isEmpty) {
      return S.current.please_input_content;
    } else {
      return null;
    }
  }

  String? checkIdentity(String identity) {
    if (identity.isEmpty) {
      return S.current.please_input_identity;
    } else {
      return null;
    }
  }

  String? checkPin(String pin) {
    if (pin.isEmpty) {
      return S.current.please_input_pin;
    } else if (pin.length < 6) {
      return S.current.pin_valid;
    } else {
      return null;
    }
  }

  // check nếu có ít nhất n số
  bool hasMinNumericChar(String password, int numericCount) {
    String pattern = '^(.*?[0-9]){' + numericCount.toString() + ',}';
    return password.contains(new RegExp(pattern));
  }

  // check nếu có ít nhất n ký tự
  bool hasMinNormalChar(String password, int normalCount) {
    String pattern = '^(.*?[A-Z]){' + normalCount.toString() + ',}';
    return password.toUpperCase().contains(new RegExp(pattern));
  }
}
