import 'package:sbsi/model/response/account_info.dart';

class CustomInfoState {
  AccountInfo accountInfo = AccountInfo();
  CustomInfoState();
}

class AccountCodeObject {
  String? accountCode;

  AccountCodeObject({this.accountCode});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["ACCOUNT_CODE"] = accountCode;
    return data;
  }
}
