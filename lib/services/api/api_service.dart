import 'package:sbsi/model/entities/index.dart';
import 'package:sbsi/model/entities/transfer_history.dart';
import 'package:sbsi/model/order_data/inday_order.dart';
import 'package:sbsi/model/params/index.dart';
import 'package:sbsi/model/response/account_info.dart';
import 'package:sbsi/model/response/account_status.dart';
import 'package:sbsi/model/response/index_detail.dart';
import 'package:sbsi/model/response/list_account_response.dart';
import 'package:sbsi/model/response/portfolio.dart';
import 'package:sbsi/model/response/stocke_response.dart';
import 'package:sbsi/model/response/transaction_new.dart';
import 'package:sbsi/model/stock_company_data/stock_company_data.dart';
import 'package:sbsi/model/stock_data/cash_balance.dart';
import 'package:sbsi/model/stock_data/list_news_stock.dart';
import 'package:sbsi/model/stock_data/news_detail.dart';
import 'package:sbsi/model/stock_data/share_balance.dart';
import 'package:sbsi/model/stock_data/stock_data.dart';
import 'package:sbsi/model/stock_data/stock_info.dart';
import 'package:sbsi/model/stock_data/stock_trade_list.dart';
import 'package:sbsi/networks/api_client.dart';
import 'package:sbsi/networks/api_util.dart';
import 'package:get/get.dart';

import '../../model/entities/bank.dart';
import '../../model/entities/beneficiary_account.dart';
import '../../model/entities/cash_account.dart';
import '../../model/entities/economy.dart';
import '../../model/entities/order_history.dart';
import '../../model/entities/share_transaction.dart';
import '../../model/entities/share_transfer.dart';
import '../../model/response/branch_response.dart';
import '../../model/response/index_chart.dart';
import '../../model/response/market_depth_response.dart';
import '../../model/response/stock_follow_branch_response.dart';
import '../../model/response/stock_report.dart';
import '../../model/response/totalAssets.dart';
import '../../ui/pages/sign_up/enum/enums.dart';

part 'auth_api.dart';

part 'wallet_api.dart';

part 'user_api.dart';

part 'stock_order_api.dart';

part 'index_api.dart';

part 'sign_up_api.dart';

class ApiService extends GetxService {
  late ApiClient _apiClient;

  Future<ApiService> init() async {
    _apiClient = ApiUtil.getApiClient();
    return this;
  }
}
