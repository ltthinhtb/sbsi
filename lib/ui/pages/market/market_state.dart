import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sbsi/model/entities/foreign.dart';
import 'package:uuid/uuid.dart';
import '../../../model/entities/category_stock.dart';
import '../../../model/response/index_detail.dart';
import '../../../model/response/market_depth_response.dart';
import '../../../model/response/stock_follow_branch_response.dart';
import '../../../model/stock_data/stock_data.dart';
import '../enum/vnIndex.dart';

class MarketState {
  var viewForkType = 0.obs;
  final Map<Index, List<double>> charts = <Index, List<double>>{}.obs;
  var marketDepth = <MarketDepth>[].obs;
  var marketDepthTotal = 0.obs;
  var marketDepthNegativeInteger = 0.obs;
  var marketDepthInteger = 0.obs;
  var marketDepthZero = 0.obs;
  var listBranch = <String>[].obs;
  var listStockBranch = <StockBranch>[].obs;

  final listIndexDetail = <IndexDetail>[].obs;

  // list stock theo danh mục
  final listStock = <StockData>[].obs;

  final categoryController = TextEditingController();

  var category_default =
      CategoryStock(title: CATEGORY_DEFAULT, uuid: const Uuid().v1());

  List<String> defaultListStock = [];

  // danh mục String
  List<String> listStockMenu = [];

  // sàn chứng khoán mặc định
  static const CATEGORY_DEFAULT = "HSX30";

  Rx<CategoryStock> category =
      CategoryStock(title: CATEGORY_DEFAULT, uuid: const Uuid().v1()).obs;


  final topForeignTrade = <ForeignTrade>[].obs;
}
