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

  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  final startDateController1 = TextEditingController();
  final endDateController1 = TextEditingController();

  CashTransactionState() {
    ///Initialize variables
  }
}
