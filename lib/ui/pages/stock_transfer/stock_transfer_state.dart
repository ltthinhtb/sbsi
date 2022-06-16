import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/model/entities/share_transfer.dart';
import 'package:sbsi/model/entities/share_transfer_history.dart';

import '../../../model/response/list_account_response.dart';
import '../../../model/response/portfolio.dart';
import '../../../utils/date_utils.dart';

class StockTransferState {
  final account = Account().obs;
  final accountReceiver = Account().obs;

  final userReceiverController = TextEditingController();
  final userReceiverKey = GlobalKey<FormState>();
  final userReceiverFocus = FocusNode();

  final portfolioList = <PortfolioStatus>[].obs;
  final portfolio = PortfolioStatus().obs;

  final shareTransfer = ShareTransfer().obs;

  final amountController = TextEditingController();
  final pinController = TextEditingController();
  final otpController = TextEditingController(text: "123456");

  final formKey = GlobalKey<FormState>();

  final startDateController = TextEditingController(

      text: DateTimeUtils.toDateString(
          DateTime.now().subtract(const Duration(days: 90)),
          format: "dd/MM/yyyy")
  );
  final endDateController = TextEditingController(

      text: DateTimeUtils.toDateString(
          DateTime.now(),
          format: "dd/MM/yyyy")
  );

  final listShareHistory = <ShareTransferHistory>[].obs;

  StockTransferState() {
    ///Initialize variables
  }
}
