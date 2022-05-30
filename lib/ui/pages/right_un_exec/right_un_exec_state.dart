import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sbsi/model/entities/right_exc.dart';

import '../../../model/response/account_status.dart';
import '../../../model/response/list_account_response.dart';

class Right_un_execState {
  final account = Account().obs;

  final assets = AccountAssets().obs;

  final listRightExt = <RightExc>[].obs;

  final pinController = TextEditingController();


  Right_un_execState() {
    ///Initialize variables
  }
}
