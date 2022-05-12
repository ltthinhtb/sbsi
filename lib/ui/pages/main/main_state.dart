import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/model/order_data/inday_order.dart';
import 'package:sbsi/router/route_config.dart';
import 'package:sbsi/ui/pages/home/home_view.dart';
import 'package:sbsi/ui/pages/order_list/order_list_view.dart';
import 'package:sbsi/ui/pages/order_list/page/order_detail.dart';
import 'package:sbsi/ui/pages/stock_order/stock_order_view.dart';
import 'package:sbsi/ui/pages/wallet/wallet_view.dart';

import '../market/market_view.dart';

final GlobalKey<NavigatorState> orderListKey = GlobalKey();

class MainState {
  late RxInt selectedIndex;

  ///PageView page
  late List<Widget> pageList;
  late PageController pageController;

  MainState() {
    //Initialize index
    selectedIndex = 0.obs;
    //PageView page
    pageList = [
      const HomePage(),
      const MarketPage(),
       StockOrderPage(),
      // OrderListPage(),
      Navigator(
        key: orderListKey,
        initialRoute: RouteConfig.order_list,
        onGenerateRoute: (settings) {
          if (settings.name == RouteConfig.order_list) {
            return GetPageRoute(
              settings: settings,
              page: () => const OrderListPage(),
            );
          }
          if (settings.name == RouteConfig.order_detail) {
            return GetPageRoute(
              settings: settings,
              page: () => OrderDetail(
                data: settings.arguments as IndayOrder,
              ),
            );
          } else {
            return null;
          }
        },
      ),
      const WalletPage(),
    ];
    //Page controller
    pageController = PageController();
  }
}
