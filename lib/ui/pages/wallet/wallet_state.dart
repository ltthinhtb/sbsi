import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:sbsi/model/entities/debt_acc.dart';
import 'package:sbsi/model/response/account_status.dart';
import 'package:sbsi/model/response/portfolio.dart';
import 'package:sbsi/model/response/totalAssets.dart';

import '../../../model/response/list_account_response.dart';

class WalletState {
  final assets = AccountMStatus().obs;

  final portfolioTotal = PortfolioStatus().obs;
  final portfolioList = <PortfolioStatus>[].obs;

  final totalAssets = TotalAssets().obs;

  final account = Account().obs;

  final debtList = <DebtAcc>[].obs;


  WalletState() {
    ///Initialize variables
  }
}
