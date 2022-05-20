import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/model/entities/share_transaction.dart';
import 'package:sbsi/model/response/transaction_new.dart';

import '../../../model/response/list_account_response.dart';

class CashTransactionState {
  final account = Account().obs;

  final content = Content().obs;
  final listTransaction = <Transaction>[].obs;

  final listShare = <ShareTransaction>[].obs;

  final startDateController = TextEditingController(text: "12/01/2021");
  final endDateController = TextEditingController(text: "28/02/2021");

  final startDateController1 = TextEditingController(text: "12/01/2021");
  final endDateController1 = TextEditingController(text: "28/02/2021");

  CashTransactionState() {
    ///Initialize variables
  }
}
