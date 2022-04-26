import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/model/response/account_status.dart';
import 'package:sbsi/model/stock_company_data/stock_company_data.dart';
import 'package:sbsi/model/stock_data/cash_balance.dart';
import 'package:sbsi/model/stock_data/share_balance.dart';
import 'package:sbsi/model/stock_data/stock_data.dart';
import 'package:sbsi/model/stock_data/stock_info.dart';

import '../../../model/response/list_account_response.dart';

class StockOrderState {
  final TextEditingController priceController = TextEditingController();
  final TextEditingController volController = TextEditingController();

  final TextEditingController stockController = TextEditingController();
  final FocusNode stockNode = FocusNode();
  final searchCKKey = GlobalKey<FormState>();
  List<StockCompanyData> allStockCompanyData = <StockCompanyData>[];

  final account = Account().obs;

  final stockCompanyData = StockCompanyData().obs;

  var loading = false.obs;

  var foundStock = <StockCompanyData>[].obs;
  var accountStatus = AccountMStatus().obs;
  var selectedStock = StockCompanyData().obs;
  var selectedStockInfo = StockInfo().obs;
  var selectedStockData = StockData().obs;
  var selectedCashBalance = CashBalance().obs;
  var selectedShareBalance = ShareBalance().obs;

  var isBuy = true.obs;
  var stockExchange = StockExchange.HSX.obs;
  var priceType = "LO".obs;
  var price = "0.0".obs;
  var vol = 0.obs;
  var pin = "123456".obs;

  var sumBuyVol = 0.0.obs;
  var sumSellVol = 0.0.obs;
  var sumBSVol = 0.0.obs;

  StockOrderState() {}
}

enum StockExchange { HSX, HNX, UPCOM }
