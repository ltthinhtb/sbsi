import 'package:get/get.dart';
import 'package:sbsi/model/response/transaction_new.dart';

import '../../../model/params/data_params.dart';
import '../../../model/params/request_params.dart';
import '../../../services/api/api_service.dart';
import '../../../services/auth_service.dart';
import 'cash_transaction_state.dart';

class CashTransactionLogic extends GetxController {
  final CashTransactionState state = CashTransactionState();

  final ApiService apiService = Get.find();
  final AuthService authService = Get.find();

  void loadAccount() {
    var _tokenEntity = authService.token.value;
    var index = authService.listAccount.indexWhere(
        (element) => _tokenEntity?.data?.defaultAcc == element.accCode);
    if (index >= 0) {
      state.account.value = authService.listAccount[index];
    }
  }

  // load list transaction money
  void getOrderList() async {
    var _tokenEntity = authService.token.value;
    final RequestParams _requestParams = RequestParams(
      group: "B",
      session: _tokenEntity?.data?.sid,
      user: _tokenEntity?.data?.user,
      data: ParamsObject(
          type: "2cursor",
          cmd: "CashTransactionNew",
          p1: "0",
          p2: state.account.value.accCode,
          p3: state.startDateController.text,
          //p3: "12/01/2021",
          //p4: "28/02/2021",
          p4: state.endDateController.text,
          p5: "1",
          p6: "30"),
    );
    try {
      var response = await apiService.getListTransactionNew(_requestParams);
      state.content.value = response.data1?.first ?? Content();
      state.listTransaction.value = response.data2 ?? [];
    } catch (e) {
      print(e);
    }
  }

  // switch tài khoản 1-6
  void changeAccount() {
    var index = authService.listAccount.indexWhere(
        (element) => state.account.value.accCode != element.accCode);
    if (index >= 0) {
      state.account.value = authService.listAccount[index];
      getOrderList();
    }
  }

  @override
  void onReady() {
    loadAccount();
    getOrderList();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
