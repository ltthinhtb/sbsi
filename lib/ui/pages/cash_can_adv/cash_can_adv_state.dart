import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sbsi/model/entities/advance_withdraw.dart';
import 'package:sbsi/model/entities/cash_can_adv.dart';
import 'package:sbsi/model/entities/fee_withdraw.dart';

import '../../../model/response/list_account_response.dart';
import '../../../utils/date_utils.dart';

class CashCanAdvState {
  final account = Account().obs;

  final pinController = TextEditingController();

  final listCashCan = <CashCanAdv>[].obs;

  final feeWithDraw = FeeAdvanceWithdraw().obs;

  final listAdvance = <AdvanceWithdraw>[].obs;

  final formPin = GlobalKey<FormState>();

  final startDateController = TextEditingController(
      text: DateTimeUtils.toDateString(
          DateTime.now().subtract(const Duration(days: 90)),
          format: "dd/MM/yyyy"));
  final endDateController = TextEditingController(
      text: DateTimeUtils.toDateString(DateTime.now(), format: "dd/MM/yyyy"));

  CashCanAdvState() {
    ///Initialize variables
  }
}
