import 'package:get/get.dart';
import 'package:sbsi/ui/commons/app_loading.dart';
import 'package:uuid/uuid.dart';
import '../../../model/entities/category_stock.dart';
import '../../../model/response/index_chart.dart';
import '../../../model/response/index_detail.dart';
import '../../../model/response/market_depth_response.dart';
import '../../../model/stock_data/stock_socket.dart';
import '../../../networks/error_exception.dart';
import '../../../services/api/api_service.dart';
import '../../../services/socket/socket.dart';
import '../../../services/store/store_service.dart';
import '../../../utils/logger.dart';
import '../../commons/app_snackbar.dart';
import '../enum/vnIndex.dart';
import 'market_state.dart';

class MarketLogic extends GetxController {
  final MarketState state = MarketState();

  final ApiService apiService = Get.find();
  final StoreService storeService = Get.find();
  final Socket _socket = Socket();

  void changeViewForkType(int type) {
    state.viewForkType.value = type;
  }

  // lấy data các sàn chứng khoán
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
        await getChartIndex(element.mc!);
      }
    } on ErrorException catch (e) {
      logger.e(e.toString()); //AppSnackBar.showError(message: e.message);
    } catch (e) {
      //AppSnackBar.showError(message: e.toString());
    }
  }

  // lấy data chart theo sàn
  Future<IndexChartResponse> getChartIndex(String code) async {
    try {
      var response = await apiService.getChartIndex(code);
      return response;
    } catch (e) {
      logger.e(e);
      AppSnackBar.showError(message: e.toString());
      rethrow;
    }
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

  // độ sâu chứng khoán
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

  Future<void> getListStockCodeDefault() async {
    String market = MarketState.CATEGORY_DEFAULT;
    try {
      // lấy list các mã theo sàn
      final response = await apiService.getListStockCode(market);
      // thêm các mã chứng khoán vào vào danh mục mặc định
      state.defaultListStock.addAll(response.split(","));
      // khởi tạo là danh mục mặc định
      await selectCategory(state.category_default);
    } catch (e) {
      AppSnackBar.showError(message: e.toString());
    }
  }

  // thêm danh mục mới
  Future<void> addCategory() async {
    if (state.categoryController.text.isNotEmpty) {
      await storeService.addCategory(CategoryStock(
          title: state.categoryController.text, uuid: const Uuid().v1()));
      state.categoryController.clear();
      Get.back(); // đóng dialog
    }
  }

  Future<void> deleteCategory(String title) async {
    await storeService.deleteCategory(title);
  }

  Future<void> addStockDB(String stock) async {
    AppLoading.showLoading();
    await storeService.addStock(state.category.value, stock);
    await selectCategory(state.category.value);
    AppLoading.disMissLoading();

    // print(storeService.listStockFromCategory(state.category.value.uuid!).length);
  }

  Future<void> removeStockDB(String stock) async {
    AppLoading.showLoading();

    await storeService.removeStock(state.category.value, stock);
    await selectCategory(state.category.value);
    AppLoading.disMissLoading();
  }

  Future<void> editCategory(String title, String newTitle) async {
    await storeService.editCategory(title, newTitle);
    Get.back(); // đóng bottom sheet
  }

  Future<void> selectCategory(CategoryStock category) async {
    /// xóa stock socket cũ đi
    for (var element
        in state.listStock.map((element) => element.sym ?? "").toList()) {
      _socket.removeStockSocket(element);
    }
    state.category.value = category;

    String list = "";
    if (category == state.category_default) {
      list = state.defaultListStock.join(",");
    } else {
      list = storeService
          .listStockFromCategory(state.category.value.uuid)
          .join(",");
    }

    state.listStock.value = await apiService.getStockData(list);

    /// cập nhật stock socket mới
    for (var element
        in state.listStock.map((element) => element.sym ?? "").toList()) {
      _socket.addStockSocket(element);
    }
  }

  // tạo socket lắng nghe
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
              if (stock.mc != null) {
                try {
                  getChartIndex(stock.mc!);
                } catch (e) {}
              }
            }
          }
          if (data['data']['id'] == 3220) {
            SocketStock stock = SocketStock.fromJson(data['data']);
            var index = state.listStock
                .indexWhere((element) => element.sym == stock.sym);
            if (index >= 0) {
              var stockIndex = state.listStock[index].copyWith(stock);
              state.listStock.removeAt(index);
              state.listStock.insert(index, stockIndex);
            }
          }
        } catch (e) {
          // logger.e(e);
        }
      }
    });
  }

  // lấy top mua bán thế giới
  Future<void> getTopForeignTrade() async {
    try {
      var response = await apiService.getTopForeignTrade("10", "S");
      state.topForeignTrade.value = response;
    } on ErrorException catch (e) {
      AppSnackBar.showError(message: e.message);
    } catch (e) {
      AppSnackBar.showError(message: e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    socketListen();
    getListIndexDetail();
    getListStockCodeDefault();
    getMarketDepth();
    getDetailStockBranch();
    getTopForeignTrade();
  }

  @override
  void onClose() {
    _socket.dispose();
    super.onClose();
  }
}
