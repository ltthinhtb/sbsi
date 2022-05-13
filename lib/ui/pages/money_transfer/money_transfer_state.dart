import 'package:get/get.dart';
import 'package:sbsi/model/entities/beneficiary_account.dart';
import 'package:sbsi/model/entities/cash_account.dart';
import 'package:sbsi/model/response/list_account_response.dart';

import '../../../model/entities/bank.dart';

class MoneyTransferState {
  final account = Account().obs;

  final accountReceiver = Account().obs;

  final cashAccount = CashAccount().obs;

  var listBank = <Bank>[];

  final bank = Bank().obs;

  MoneyTransferState() {}

  var listBeneficiary = <BeneficiaryAccount>[];

  final beneficiary = BeneficiaryAccount().obs;
}
