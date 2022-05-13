import 'package:get/get.dart';
import 'package:sbsi/model/entities/beneficiary_account.dart';
import 'package:sbsi/model/entities/index.dart';
import 'package:sbsi/networks/error_exception.dart';
import 'package:sbsi/services/api/api_service.dart';
import 'package:sbsi/services/auth_service.dart';
import 'package:sbsi/ui/commons/app_snackbar.dart';

import '../../../model/entities/bank.dart';
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
      state.listBank = await apiService.getListBank(_requestParams);
    } on ErrorException catch (e) {
      AppSnackBar.showError(message: e.message);
    }
  }

  Future<void> getListBeneficiaryAccount() async {
    final RequestParams _requestParams = RequestParams(
        group: "B",
        user: tokenEntity?.data?.user ?? "",
        session: tokenEntity?.data?.sid ?? "",
        data: ParamsObject(
            type: 'cursor',
            cmd: "ListBeneficiaryAccount",
            p1: tokenEntity?.data?.defaultAcc ?? ""));
    try {
      state.listBeneficiary =
          await apiService.getListBeneficiaryAccount(_requestParams);
      if (state.listBeneficiary.isNotEmpty) {
        state.beneficiary.value = state.listBeneficiary.first;
      }
    } on ErrorException catch (e) {
      AppSnackBar.showError(message: e.message);
    }
  }

  void changeBeneficiary(BeneficiaryAccount account) {
    state.beneficiary.value = account;
    var index = state.listBank
        .indexWhere((element) => element.cBANKCODE == account.cBANKCODE);
    if (index >= 0) {
      state.bank.value = state.listBank[index];
    }
    else {
      state.bank.value = Bank();
    }
  }

  @override
  void onReady() {
    loadAccount();
    getListBank();
    getCashAccountInfo();
    getListBeneficiaryAccount();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
