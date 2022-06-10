import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sbsi/model/entities/right_exc.dart';
import 'package:sbsi/model/entities/right_history.dart';

import '../../../model/response/account_status.dart';
import '../../../model/response/list_account_response.dart';

class Right_un_execState {
  final account = Account().obs;

  final assets = AccountAssets().obs;

  final listRightExt = <RightExc>[].obs;

  final listRightHistory = <RightHistory>[].obs;


  final pinController = TextEditingController();

  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  Right_un_execState() {
    ///Initialize variables
  }
}
