import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/model/order_data/inday_order.dart';

import '../../../model/response/list_account_response.dart';
import 'enums/order_enums.dart';

class OrderListState {
  late TextEditingController stockCodeController;

  // List<StockCompanyData> allStockCompanyData = <StockCompanyData>[];

  var loading = false.obs;
  var selectedMode = false.obs;

  var selectedListOrder = <IndayOrder>[].obs;

  var listOrderStorage = <IndayOrder>[].obs;
  var listOrder = <IndayOrder>[].obs;

  SingingCharacter singingCharacter = SingingCharacter.all;

  final account = Account().obs;


  var newDataArrived = false.obs;

  OrderListState() {
    stockCodeController = TextEditingController();
  }
}
