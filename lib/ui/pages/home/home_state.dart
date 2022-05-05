import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/model/entities/category_stock.dart';
import 'package:sbsi/model/response/index_detail.dart';
import 'package:sbsi/model/response/stocke_response.dart';
import 'package:sbsi/model/stock_data/stock_data.dart';

class HomeState {
  static const CATEGORY_DEFAULT = "HSX30";

  final GlobalKey<ScaffoldState> key = GlobalKey();


  final listIndexDetail = <IndexDetail>[].obs;
  final categoryController = TextEditingController();
  var category_default = CategoryStock(title: CATEGORY_DEFAULT, stocks: []);
  final listStock = <StockData>[].obs;
  final listShortStock = <StockDataShort>[].obs;

  Rx<CategoryStock> category =
      CategoryStock(title: CATEGORY_DEFAULT, stocks: []).obs;

  RxList<CategoryStock> listCategory = <CategoryStock>[].obs;
}
