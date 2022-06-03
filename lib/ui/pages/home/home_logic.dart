import 'package:get/get.dart';
import 'package:sbsi/model/stock_data/stock_socket.dart';
import 'package:sbsi/networks/error_exception.dart';
import 'package:sbsi/services/index.dart';
import 'package:sbsi/services/socket/socket.dart';
import 'package:sbsi/ui/commons/app_snackbar.dart';

import 'home_state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();

  final ApiService apiService = Get.find();
  final AuthService authService = Get.find();

  final Socket _socket = Socket();

  Future<void> getTopStockData(int type) async {
    try {
      // xóa các mã cũ ở socket
      for (var element in state.listShortStock) {
        _socket.removeStockSocket(element.stockCode ?? "");
      }
      state.listShortStock.value = await apiService.getTopStock(type);

      // thêm các mã vào socket
      for (var element in state.listShortStock) {
        _socket.addStockSocket(element.stockCode ?? "");
      }
    } on ErrorException catch (e) {
      AppSnackBar.showError(message: e.message);
    } catch (e) {
      AppSnackBar.showError(message: e.toString());
    }
  }

  // tạo socket lắng nghe
  void startSocket() {
    _socket.socket.on('public', (data) {
      if (data != null) {
        try {
          // lắng nghe theo từng mã chứng khoán
          if (data['data']['id'] == 3220) {
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

  //listBanner
  Future<void> getBanner() async {
    try {
      state.listBanner.value = await apiService.getBanner();
    } on ErrorException catch (e) {
      AppSnackBar.showError(message: e.message);
    } catch (e) {
      AppSnackBar.showError(message: e.toString());
    }
  }

  void disConnectSocket() {
    _socket.disconnectSocket();
  }

  @override
  void onReady() {
    startSocket();
    getTopStockData(0);
    getBanner();
    super.onReady();
  }

  @override
  void onClose() {
    disConnectSocket();
    _socket.dispose();
    super.onClose();
  }
}
