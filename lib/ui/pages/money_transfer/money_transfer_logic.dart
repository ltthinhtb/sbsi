import 'package:get/get.dart';
import 'package:sbsi/model/entities/index.dart';
import 'package:sbsi/networks/error_exception.dart';
import 'package:sbsi/services/api/api_service.dart';
import 'package:sbsi/services/auth_service.dart';
import 'package:sbsi/ui/commons/app_snackbar.dart';

import '../../../model/params/data_params.dart';
import '../../../model/params/request_params.dart';
import '../../../model/response/list_account_response.dart';
import 'money_transfer_state.dart';

class MoneyTransferLogic extends GetxController {
  final MoneyTransferState state = MoneyTransferState();

  final apiService = Get.find<ApiService>();

  final authService = Get.find<AuthService>();

  TokenEntity? get tokenEntity => authService.token.value;

  // lấy thông tin tài khoản mặc định
  void loadAccount() {
    state.account.value = authService.listAccount.firstWhere(
        (element) => element.accCode == (tokenEntity?.data?.defaultAcc ?? ""),
        orElse: () => Account());

    state.accountReceiver.value = authService.listAccount.firstWhere(
        (element) => element.accCode != (tokenEntity?.data?.defaultAcc ?? ""),
        orElse: () => Account());
  }

  Future<void> getCashAccountInfo() async {
    final RequestParams _requestParams = RequestParams(
        group: "B",
        user: tokenEntity?.data?.user ?? "",
        session: tokenEntity?.data?.sid ?? "",
        data: ParamsObject(
            type: 'cursor',
            cmd: "GetCashAccountInfo",
            p1: state.account.value.accCode));
    try {
      state.cashAccount.value = await apiService.getCashAccount(_requestParams);
    } on ErrorException catch (e) {
      AppSnackBar.showError(message: e.message);
    }
  }

  Future<void> getListBank() async {
    final RequestParams _requestParams = RequestParams(
        group: "B",
        user: tokenEntity?.data?.user ?? "",
        session: tokenEntity?.data?.sid ?? "",
        data: ParamsObject(type: 'cursor', cmd: "GetAllBankOnline"));
    try {
      state.cashAccount.value = await apiService.getCashAccount(_requestParams);
    } on ErrorException catch (e) {
      AppSnackBar.showError(message: e.message);
    }
  }

  @override
  void onReady() {
    loadAccount();
    getListBank();
    getCashAccountInfo();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
