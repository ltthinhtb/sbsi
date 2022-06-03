import 'package:sbsi/ui/pages/cash_can_adv/cash_can_adv_view.dart';
import 'package:sbsi/ui/pages/cash_transaction/cash_transaction_view.dart';
import 'package:sbsi/ui/pages/get_account_info/get_account_info_view.dart';
import 'package:sbsi/ui/pages/home/home_logic.dart';
import 'package:sbsi/ui/pages/main/main_logic.dart';
import 'package:sbsi/ui/pages/main/main_view.dart';
import 'package:sbsi/ui/pages/menu/panel/setting/setting_page/setting_page.dart';
import 'package:sbsi/ui/pages/money_transfer/money_transfer_view.dart';
import 'package:sbsi/ui/pages/notification/notification_logic.dart';
import 'package:sbsi/ui/pages/notification/notification_view.dart';
import 'package:sbsi/ui/pages/order_list/order_list_logic.dart';
import 'package:sbsi/ui/pages/order_list/order_list_view.dart';
import 'package:sbsi/ui/pages/right_un_exec/right_un_exec_view.dart';
import 'package:sbsi/ui/pages/search/search_logic.dart';
import 'package:sbsi/ui/pages/search/search_view.dart';
import 'package:sbsi/ui/pages/sign_in/sign_in_view.dart';
import 'package:get/get.dart';
import 'package:sbsi/ui/pages/sign_up/sign_up_view.dart';
import 'package:sbsi/ui/pages/stock_detail/stock_detail_view.dart';
import 'package:sbsi/ui/pages/stock_order/stock_order_logic.dart';
import 'package:sbsi/ui/pages/stock_transfer/stock_transfer_view.dart';
import 'package:sbsi/ui/pages/wallet/wallet_logic.dart';

import '../ui/pages/market/market_logic.dart';

class RouteConfig {
  ///main page
  static const String main = "/main";
  static const String login = "/login";
  static const String sign_up = "/sign_up";
  static const String invest = "/invest";
  static const String invest_confirm = '/invest_confirm';
  static const String search = "/search";
  static const String order_list = "/order_list";
  static const String order_detail = "/order_detail";
  static const String notification = "/notification";
  static const String stockDetail = "/stockDetail";
  static const String settings = '/settings';
  static const String money_transfer = '/money_transfer';
  static const String cash_transaction = '/cash_transaction';
  static const String stock_transfer = '/stock_transfer';
  static const String right_un_exec = '/right_un_exec';
  static const String cash_can = '/cash_can';
  static const String get_account_info = '/get_account_info';

  ///Alias ​​mapping page
  static final List<GetPage> getPages = [
    GetPage(name: main, page: () => MainPage(), binding: MainBinding()),
    GetPage(name: login, page: () => const SignInPage()),
    GetPage(name: sign_up, page: () => const SignUpPage()),
    GetPage(name: invest, page: () => MainPage()),
    GetPage(name: invest_confirm, page: () => MainPage()),
    GetPage(name: search, page: () => const SearchPage()),
    GetPage(name: order_list, page: () => const OrderListPage()),
    GetPage(name: notification, page: () => NotificationPage()),
    GetPage(name: stockDetail, page: () => const StockDetailPage()),
    GetPage(name: settings, page: () => const SettingPage()),
    GetPage(name: money_transfer, page: () => const MoneyTransferPage()),
    GetPage(name: cash_transaction, page: () => const CashTransactionPage()),
    GetPage(name: stock_transfer, page: () => const StockTransferPage()),
    GetPage(name: right_un_exec, page: () => const RightUnExecPage()),
    GetPage(name: cash_can, page: () => const CashCanAdvPage()),
    GetPage(name: get_account_info, page: () => const GetAccountInfoPage()),
  ];
}

class MainBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => MainLogic());
    Get.lazyPut(() => SearchLogic());
    Get.lazyPut(() => MarketLogic());
    Get.lazyPut(() => WalletLogic());
    Get.lazyPut(() => HomeLogic());
    Get.lazyPut(() => OrderListLogic());
    Get.lazyPut(() => StockOrderLogic());
    Get.lazyPut(() => NotificationLogic());
  }
}
