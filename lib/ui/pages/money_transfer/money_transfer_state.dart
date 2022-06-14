import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sbsi/model/entities/beneficiary_account.dart';
import 'package:sbsi/model/entities/cash_account.dart';
import 'package:sbsi/model/entities/transfer_history.dart';
import 'package:sbsi/model/response/list_account_response.dart';
import 'package:sbsi/utils/date_utils.dart';

import '../../../model/entities/bank.dart';
import '../../commons/money_text_controller.dart';
import 'enums/transfer_type.dart';

class MoneyTransferState {
  TransfersType type = TransfersType.bank;

  final account = Account().obs;

  final accountReceiver = Account().obs;

  final cashAccount = CashAccount().obs;

  var listBank = <Bank>[];

  final bank = Bank().obs;

  final listHistory = <HistoryTransfer>[].obs;

  MoneyTransferState() {}

  var listBeneficiary = <BeneficiaryAccount>[];

  final beneficiary = BeneficiaryAccount().obs;

  final userAccountController = TextEditingController();
  final userAccountKey = GlobalKey<FormState>();
  final userAccountFocus = FocusNode();

  final userReceiverController = TextEditingController();
  final userReceiverKey = GlobalKey<FormState>();
  final userReceiverFocus = FocusNode();

  final userNameController = TextEditingController();
  final userNameKey = GlobalKey<FormState>();
  final userNameFocus = FocusNode();

  final moneyController = MoneyMaskedTextController(
    thousandSeparator: ',',
    rightSymbol: "",
    decimalSeparator: "",
    precision: 0,
  );
  final userMoneyKey = GlobalKey<FormState>();
  final userMoneyFocus = FocusNode();

  final transferContentController = TextEditingController();
  final transferContentKey = GlobalKey<FormState>();
  final transferContentFocus = FocusNode();

  final otpController = TextEditingController();
  final pinController = TextEditingController();
  final pinKey = GlobalKey<FormState>();

  final startDateController = TextEditingController(
      text: DateTimeUtils.toDateString(
          DateTime.now().subtract(const Duration(days: 90)),
          format: "dd/MM/yyyy"));
  final endDateController = TextEditingController(
      text: DateTimeUtils.toDateString(DateTime.now(), format: "dd/MM/yyyy"));

  final Rx<num> cFeeOnline = 0.0.obs;
}
