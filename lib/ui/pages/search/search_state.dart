import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/model/stock_company_data/stock_company_data.dart';

class SearchState {
  late TextEditingController stockCodeController;
  List<StockCompanyData> allStockCompanyData = <StockCompanyData>[];
  var foundStock = <StockCompanyData>[].obs;

  SearchState({String? stockCode}) {
    stockCodeController = TextEditingController(text: stockCode ?? 'APS');
  }
}
