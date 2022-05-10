import 'package:get/get.dart';
import 'package:sbsi/model/entities/category_stock.dart';
import 'package:sbsi/model/response/index_detail.dart';
import 'package:sbsi/model/stock_data/stock_socket.dart';
import 'package:sbsi/services/index.dart';
import 'package:sbsi/services/socket/socket.dart';
import 'package:sbsi/ui/commons/app_snackbar.dart';
import 'package:sbsi/ui/pages/enum/vnIndex.dart';

import '../../../model/response/index_chart.dart';
import '../../../utils/logger.dart';
import 'home_state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();

  final ApiService apiService = Get.find();
  final AuthService authService = Get.find();
  final StoreService storeService = Get.find();

  final Socket _socket = Socket();

  Future<void> getTopStockData(int type) async {
    try {
      for (var element in state.listShortStock) {
        _socket.removeStockSocket(element.stockCode ?? "");
      }
      state.listShortStock.value = await apiService.getTopStock(type);
      for (var element in state.listShortStock) {
        _socket.addStockSocket(element.stockCode ?? "");
      }
    } catch (e) {
      AppSnackBar.showError(message: e.toString());
    }
  }

  Future<void> getListIndexDetail() async {
    String list = "";
    for (var e in Index.values) {
      if (e == Index.values.first) {
        list = e.code;
      } else {
        list += ',${e.code}';
      }
    }
    try {
      state.listIndexDetail.value = await apiService.getListIndexDetail(list);
      for (var element in state.listIndexDetail) {
        await getChartIndex(element.mc!, element.stockCode!);
      }
    } catch (e) {
      AppSnackBar.showError(message: e.toString());
    }
  }

  Future<void> getListStockCodeDefault() async {
    String market = HomeState.CATEGORY_DEFAULT;
    try {
      final response = await apiService.getListStockCode(market);
      state.category_default.stocks.addAll(response.split(","));
      state.listCategory = storeService.currentCategory;
      await selectCategory(state.category_default);
    } catch (e) {
      AppSnackBar.showError(message: e.toString());
    }
  }

  void socketListen() {
    _socket.socket.on('public', (data) {
      if (data != null) {
        try {
          int index = -1;
          if (data['data']['id'] == 1101) {
            IndexDetail stock = IndexDetail.fromJson(data['data']);
            index = state.listIndexDetail
                .indexWhere((element) => element.mc == stock.mc);
            if (index >= 0) {
              state.listIndexDetail.removeAt(index);
              state.listIndexDetail.insert(index, stock);
              // if (stock.mc != null) {
              //   getChartIndex(stock.mc!, stock.stockCode);
              // }
            }
          } else if (data['data']['id'] == 3220) {
            SocketStock stock = SocketStock.fromJson(data['data']);
            var index = state.listStock
                .indexWhere((element) => element.sym == stock.sym);
            if (index >= 0) {
              var stockIndex = state.listShortStock[index].copyWith(stock);
              state.listShortStock.removeAt(index);
              state.listShortStock.insert(index, stockIndex);
            }
          }
        } catch (e) {
          // logger.e(e);
        }
      }
    });
  }


  Future<void> addCategory() async {
    if (state.categoryController.text.isNotEmpty) {
      await storeService.addCategory(
          CategoryStock(title: state.categoryController.text, stocks: []));
      state.categoryController.clear();
      Get.back();
    }
  }

  Future<void> addStockDB(String stock) async {
    await storeService.addStock(state.category.value.title, stock);

    /// chọn lại category
    await selectCategory(state.category.value);
  }

  Future<void> deleteCategory(String title) async {
    await storeService.deleteCategory(title);
  }

  Future<void> editCategory(String title, String newTitle) async {
    await storeService.editCategory(title, newTitle);
    Get.back(); // đóng bottom sheet
  }

  Future<void> selectCategory(CategoryStock category) async {
    /// xóa stock socket cũ đi
    for (var element in state.category.value.stocks) {
      _socket.removeStockSocket(element);
    }
    state.category.value = category;
    state.listStock.value =
        await apiService.getStockData(state.category.value.stocks.join(","));

    /// cập nhật stock socket mới
    for (var element in state.category.value.stocks) {
      _socket.addStockSocket(element);
    }
    Get.back(); // đóng bottom sheet
  }

  Future<IndexChartResponse> getChartIndex(String code, Index index) async {
    try {
      var response = await apiService.getChartIndex(code);
      return response;
    } catch (e) {
      logger.e(e);
      AppSnackBar.showError(message: e.toString());
      rethrow;
    }
  }

  @override
  void onReady() {
    getListIndexDetail();
    getListStockCodeDefault();
    socketListen();
    getTopStockData(0);
    super.onReady();
  }
}
