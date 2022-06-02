import 'dart:io';

import 'package:get/get.dart';
import 'package:sbsi/model/stock_company_data/stock_company_data.dart';
import 'package:sbsi/networks/error_exception.dart';
import 'package:sbsi/services/index.dart';
import 'package:sbsi/services/notification_service.dart';
import 'package:sbsi/ui/commons/app_snackbar.dart';
import 'package:sbsi/ui/pages/order_list/order_list_logic.dart';
import 'package:sbsi/ui/pages/stock_order/stock_order_logic.dart';

import 'main_state.dart';

class MainLogic extends GetxController {
  final MainState state = MainState();
  final NotificationService notificationService =
      Get.find<NotificationService>();

  final ApiService apiService = Get.find();

  void switchTap(int index) {
    state.selectedIndex.value = index;
    // load sổ lệnh màn sổ lệnh
    if(index == 3) {
      Get.find<OrderListLogic>().getOrderList();
    }
    // load sổ lệnh màn đặt lệnh
    if(index == 2) {
      Get.find<StockOrderLogic>().getOrderList();
    }
  }

  void pushToOrderPage(StockCompanyData data, bool isBuy) {
    switchTap(2);
  }

  Future<void> sendToken() async {
    try {
     await apiService.sendToken({
        "cmd": "add",
        "account": Get.find<AuthService>().token.value!.data!.user,
        "token": Get.find<NotificationService>().token,
        "device": Platform.isAndroid ? "AND" : "IOS"
      });
    } on ErrorException catch (error) {
      AppSnackBar.showError(message: error.message);
    }
  }

  @override
  void onReady() {
    notificationService.fcmSubscribe("all");
    notificationService.fcmSubscribe("test");

    sendToken();
    super.onReady();
  }
}
