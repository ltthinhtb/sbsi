import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/ui/pages/home/home_view.dart';
import 'package:sbsi/ui/pages/order_list/order_list_view.dart';
import 'package:sbsi/ui/pages/stock_order/stock_order_view.dart';
import 'package:sbsi/ui/pages/wallet/wallet_view.dart';

import '../market/market_view.dart';

class MainState {
  late RxInt selectedIndex;
  final GlobalKey<NavigatorState> orderListKey = GlobalKey();

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
      const StockOrderPage(),
      const OrderListPage(),
      const WalletPage(),
    ];
    //Page controller
    pageController = PageController();
  }
}
