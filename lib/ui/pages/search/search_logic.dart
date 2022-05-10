//
import 'package:get/get.dart';
import 'package:sbsi/model/stock_company_data/stock_company_data.dart';
import 'package:sbsi/services/api/api_service.dart';
import 'package:sbsi/ui/pages/search/search_state.dart';
import 'package:sbsi/ui/pages/stock_order/stock_order_logic.dart';

class SearchLogic extends GetxController {
  final SearchState state = SearchState();
  ApiService apiService = Get.find();
  final parentState = Get.find<StockOrderLogic>().state;

  void searchStock(String stockCode) {
    if (stockCode != '') {
      List<StockCompanyData> searchResult = state.allStockCompanyData
          .where(
            (element) => element.stockCode!.toLowerCase().startsWith(
                  stockCode.toLowerCase(),
                ),
          )
          .toList();
      // if (searchResult.length > 10) {
      //   searchResult = searchResult.sublist(0, 10);
      // }
      state.foundStock.value = searchResult;
    } else {
      state.foundStock.value = [];
    }
  }

  List<StockCompanyData> searchStockCompany(String stockCode) {
    if (stockCode != '') {
      List<StockCompanyData> searchResult = state.allStockCompanyData
          .where(
            (element) => element.stockCode!.toLowerCase().startsWith(
          stockCode.toLowerCase(),
        ),
      )
          .toList();
      if (searchResult.length > 10) {
        searchResult = searchResult.sublist(0, 10);
      }
      return searchResult;
    } else {
      return [];
    }
  }

  void getAllStockCompanyData() {
    state.allStockCompanyData = parentState.allStockCompanyData;
    state.foundStock.value = state.allStockCompanyData;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllStockCompanyData();
  }
}
