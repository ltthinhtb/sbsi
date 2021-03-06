import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/model/response/account_status.dart';
import 'package:sbsi/model/stock_company_data/stock_company_data.dart';
import 'package:sbsi/model/stock_data/cash_balance.dart';
import 'package:sbsi/model/stock_data/stock_info.dart';

import '../../../model/order_data/inday_order.dart';
import '../../../model/response/list_account_response.dart';
import '../../commons/money_text_controller.dart';
import 'enums.dart';

class StockOrderState {
  var priceController = TextEditingController();

  final FocusNode priceNode = FocusNode();

  bool get isSearch {
    return selectedStock.value.stockCode?.isEmpty ?? true;
  }

  /// lệnh giao dịch theo từng sàn
  final tradingOrderList = ['ATO', 'ATC', 'MP', "LO"].obs;

  /// lệnh giao dịch theo từng sàn
  final tradingOrder = "".obs;

  var stockFast = StockFast.waiting.obs;

  var volController = MoneyMaskedTextController(
    thousandSeparator: ',',
    rightSymbol: "",
    decimalSeparator: "",
    precision: 0,
  );

  // sổ lệnh nhanh
  var listOrder = <IndayOrder>[].obs;

  final TextEditingController stockController = TextEditingController();
  final FocusNode stockNode = FocusNode();
  final searchCKKey = GlobalKey<FormState>();
  List<StockCompanyData> allStockCompanyData = <StockCompanyData>[];

  final account = Account().obs;

  var loading = false.obs;

  var accountStatus = AccountMStatus().obs;
  var selectedStock = StockCompanyData().obs;
  var selectedStockInfo = StockInfo().obs;
  var selectedCashBalance = CashBalance().obs;

  var isBuy = true.obs;
  var priceType = "LO".obs;
  var vol = 0.obs;
  var pinController = TextEditingController();

  /// tổng kl 3 phiên gần nhất
  var sumBuyVol = 0.0.obs;
  var sumSellVol = 0.0.obs;
  var sumBSVol = 0.0.obs;

  StockOrderState() {}

  // tổng giá trị tính tạm thời
  ValueNotifier<num> total = ValueNotifier<num>(0);

  ScrollController scrollController = ScrollController();
}

enum StockExchange { HSX, HNX, UPCOM }

extension StockExchangeExt on StockExchange {
  List<String> get priceList {
    switch (this) {
      case StockExchange.HSX:
        return ['ATO', 'ATC', 'MP', "LO"];
      case StockExchange.HNX:
        return ['ATC', 'MTL', 'MOK', "MAK", "PLO", "LO"];
      case StockExchange.UPCOM:
        return ["LO"];
    }
  }

  String get name {
    switch (this) {
      case StockExchange.HSX:
        return 'HOSE';
      case StockExchange.HNX:
        return "HNX";
      case StockExchange.UPCOM:
        return "UPCOM";
    }
  }
}
