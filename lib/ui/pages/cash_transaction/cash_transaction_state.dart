import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/model/entities/share_transaction.dart';
import 'package:sbsi/model/response/transaction_new.dart';

import '../../../model/response/list_account_response.dart';
import '../../../utils/date_utils.dart';

class CashTransactionState {
  final account = Account().obs;

  final content = Content().obs;
  final listTransaction = <Transaction>[].obs;

  final listShare = <ShareTransaction>[].obs;

  final startDateController = TextEditingController(
      text: DateTimeUtils.toDateString(
          DateTime.now().subtract(const Duration(days: 90)),
          format: "dd/MM/yyyy"));
  final endDateController = TextEditingController(
      text: DateTimeUtils.toDateString(DateTime.now(), format: "dd/MM/yyyy"));

  final startDateController1 = TextEditingController(
      text: DateTimeUtils.toDateString(
          DateTime.now().subtract(const Duration(days: 90)),
          format: "dd/MM/yyyy"));
  final endDateController1 = TextEditingController(
      text: DateTimeUtils.toDateString(DateTime.now(), format: "dd/MM/yyyy"));

  CashTransactionState() {
    ///Initialize variables
  }
}
