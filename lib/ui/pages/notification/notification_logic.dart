import 'package:get/get.dart';
import 'package:sbsi/model/params/notify_request.dart';
import 'package:sbsi/networks/error_exception.dart';
import 'package:sbsi/ui/commons/app_snackbar.dart';

import '../../../services/index.dart';
import '../../../utils/logger.dart';
import 'notification_state.dart';

class NotificationLogic extends GetxController {
  final NotificationState state = NotificationState();

  final ApiService apiService = Get.find();
  final AuthService authService = Get.find();

  // load tin tức notification
  Future<void> loadListNotifyAll() async {
    try {
      NotifyRequest request = NotifyRequest('monitor/notification',
          cmd: "listAll",
          page: 1,
          records: 50,
          isPush: "done",
          type: "public",
          account: authService.token.value?.data?.user ?? "");
      state.listNotifyAll.value = await apiService.getListNotify(request);
    } on ErrorException catch (e) {
      AppSnackBar.showError(message: e.message);
    } catch (e) {
      logger.e(e.toString());
    }
  }

  // load notify cá nhân
  Future<void> loadListNotifyAccount() async {
    try {
      NotifyRequest request = NotifyRequest("listNotification",
          sid: authService.token.value?.data?.sid ?? "",
          account: authService.token.value?.data?.user ?? "");
      state.listNotifyAccount.value = await apiService.getListNotify(request);
    } on ErrorException catch (e) {
      AppSnackBar.showError(message: e.message);
    } catch (e) {
      logger.e(e.toString());
    }
  }

  // đánh dấu đọc tin nhắn
  Future<void> makerRead(String idNotify) async {
    try {
      NotifyRequest request = NotifyRequest("markRead",
          idNoti: idNotify, account: authService.token.value?.data?.user ?? "");
      await apiService.makerReader(request);
      // load lại api
      refresh();
    } on ErrorException catch (e) {
      AppSnackBar.showError(message: e.message);
    } catch (e) {
      logger.e(e.toString());
    }
  }

  void refresh(){
    loadListNotifyAll();
    loadListNotifyAccount();
  }

  @override
  void onReady() {
    loadListNotifyAll();
    loadListNotifyAccount();
    super.onReady();
  }
}
