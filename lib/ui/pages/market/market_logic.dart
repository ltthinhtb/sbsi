import 'package:get/get.dart';


import '../../../model/response/market_depth_response.dart';
import '../../../services/api/api_service.dart';
import '../../../utils/logger.dart';
import 'market_state.dart';

class MarketLogic extends GetxController {
  final MarketState state = MarketState();
  final ApiService apiService = Get.find();

  void changeViewForkType(int type) {
    state.viewForkType.value = type;
  }

  Future<void> getStockBranch() async {
    try {
      state.listBranch.value = (await apiService.getStockBranch()).data ?? [];
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> getDetailStockBranch() async {
    try {
      state.listStockBranch.value = await apiService.getDetailStockBranch();
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> getMarketDepth() async {
    try {
      List<MarketDepth> rs = [];
      var data = await apiService.getMarketDepth();
      var sumNegativeInteger = 0;
      var sumInteger = 0;
      for (var e in TypeMarketDepth().negativeInteger) {
        for (var i in data) {
          if (i.tYPE == e) {
            rs.add(i);
            sumNegativeInteger += i.sL ?? 0;
          }
        }
      }
      for (var i in data) {
        if (i.tYPE == TypeMarketDepth().zero) {
          rs.add(i);
          state.marketDepthZero.value = i.sL ?? 0;
        }
      }
      for (var e in TypeMarketDepth().integer) {
        for (var i in data) {
          if (i.tYPE == e) {
            rs.add(i);
            sumInteger += i.sL ?? 0;
          }
        }
      }
      for (var i in data) {
        if (i.tYPE == TypeMarketDepth().total) {
          state.marketDepthTotal.value = i.sL ?? 0;
        }
      }
      state.marketDepth.value = rs;
      state.marketDepthInteger.value = sumInteger;
      state.marketDepthNegativeInteger.value = sumNegativeInteger;
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getMarketDepth();
    getDetailStockBranch();
  }
}
