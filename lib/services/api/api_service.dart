import 'package:sbsi/model/entities/index.dart';
import 'package:sbsi/model/order_data/inday_order.dart';
import 'package:sbsi/model/params/index.dart';
import 'package:sbsi/model/response/account_info.dart';
import 'package:sbsi/model/response/account_status.dart';
import 'package:sbsi/model/response/index_detail.dart';
import 'package:sbsi/model/response/list_account_response.dart';
import 'package:sbsi/model/response/portfolio.dart';
import 'package:sbsi/model/response/portfolio_account_status.dart';
import 'package:sbsi/model/response/stocke_response.dart';
import 'package:sbsi/model/stock_company_data/stock_company_data.dart';
import 'package:sbsi/model/stock_data/cash_balance.dart';
import 'package:sbsi/model/stock_data/share_balance.dart';
import 'package:sbsi/model/stock_data/stock_data.dart';
import 'package:sbsi/model/stock_data/stock_info.dart';
import 'package:sbsi/networks/api_client.dart';
import 'package:sbsi/networks/api_util.dart';
import 'package:get/get.dart';

part 'auth_api.dart';

part 'wallet_api.dart';

part 'user_api.dart';

part 'stock_order_api.dart';

part 'index_api.dart';

class ApiService extends GetxService {
  late ApiClient _apiClient;

  Future<ApiService> init() async {
    _apiClient = ApiUtil.getApiClient();
    return this;
  }
}
