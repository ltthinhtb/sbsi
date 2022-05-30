import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sbsi/model/entities/cash_can_adv.dart';
import 'package:sbsi/model/entities/fee_withdraw.dart';

import '../../../model/response/list_account_response.dart';

class CashCanAdvState {
  final account = Account().obs;

  final pinController = TextEditingController();

  final listCashCan = <CashCanAdv>[].obs;

  final feeWithDraw = FeeAdvanceWithdraw().obs;

  final formPin = GlobalKey<FormState>();

  CashCanAdvState() {
    ///Initialize variables
  }
}
