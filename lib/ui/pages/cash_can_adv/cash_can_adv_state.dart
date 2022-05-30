import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sbsi/model/entities/advance_withdraw.dart';
import 'package:sbsi/model/entities/cash_can_adv.dart';
import 'package:sbsi/model/entities/fee_withdraw.dart';

import '../../../model/response/list_account_response.dart';

class CashCanAdvState {
  final account = Account().obs;

  final pinController = TextEditingController();

  final listCashCan = <CashCanAdv>[].obs;

  final feeWithDraw = FeeAdvanceWithdraw().obs;

  final listAdvance = <AdvanceWithdraw>[].obs;


  final formPin = GlobalKey<FormState>();

  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  CashCanAdvState() {
    ///Initialize variables
  }
}
