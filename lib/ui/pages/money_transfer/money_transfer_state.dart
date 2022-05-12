import 'package:get/get.dart';
import 'package:sbsi/model/entities/cash_account.dart';
import 'package:sbsi/model/response/list_account_response.dart';

class MoneyTransferState {
  final account = Account().obs;

  final accountReceiver = Account().obs;

  final cashAccount = CashAccount().obs;

  MoneyTransferState() {}
}
