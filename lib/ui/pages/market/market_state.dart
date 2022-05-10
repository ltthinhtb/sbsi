import 'package:get/get.dart';

import '../../../model/response/index_detail.dart';
import '../../../model/response/market_depth_response.dart';
import '../../../model/response/stock_follow_branch_response.dart';
import '../enum/vnIndex.dart';


class MarketState {
  var viewForkType = 0.obs;
  var viewForkOverviewType = 0.obs;
  var listChart = <IndexDetail>[].obs;
  final listIndexDetail = <IndexDetail>[].obs;
  final Map<Index, List<double>> charts = <Index, List<double>>{}.obs;
  var marketDepth = <MarketDepth>[].obs;
  var marketDepthTotal = 0.obs;
  var marketDepthNegativeInteger = 0.obs;
  var marketDepthInteger = 0.obs;
  var marketDepthZero = 0.obs;
  var listBranch = <String>[].obs;
  var listStockBranch = <StockBranch>[].obs;
}
