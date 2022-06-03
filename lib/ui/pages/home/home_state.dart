import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/model/entities/app_banner.dart';
import 'package:sbsi/model/response/stocke_response.dart';
import 'package:sbsi/model/stock_data/stock_data.dart';

class HomeState {
  final GlobalKey<ScaffoldState> key = GlobalKey();

  final listStock = <StockData>[].obs;
  final listShortStock = <StockDataShort>[].obs;

  final listBanner = <AppBanner>[].obs;
}
