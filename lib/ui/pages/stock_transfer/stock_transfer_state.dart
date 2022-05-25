import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/response/list_account_response.dart';
import '../../../model/response/portfolio.dart';

class StockTransferState {
  final account = Account().obs;
  final accountReceiver = Account().obs;

  final userReceiverController = TextEditingController();
  final userReceiverKey = GlobalKey<FormState>();
  final userReceiverFocus = FocusNode();

  final portfolioList = <PortfolioStatus>[].obs;

  StockTransferState() {
    ///Initialize variables
  }
}
