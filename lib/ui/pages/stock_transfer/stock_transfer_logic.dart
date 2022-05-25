import 'package:get/get.dart';

import '../../../model/entities/token_entity.dart';
import '../../../model/params/data_params.dart';
import '../../../model/params/request_params.dart';
import '../../../model/response/list_account_response.dart';
import '../../../networks/error_exception.dart';
import '../../../services/index.dart';
import '../../commons/app_snackbar.dart';
import 'stock_transfer_state.dart';

class StockTransferLogic extends GetxController {
  final StockTransferState state = StockTransferState();
  final ApiService apiService = Get.find();
  final AuthService authService = Get.find();

  TokenEntity? get tokenEntity => authService.token.value;

  // lấy thông tin tài khoản mặc định
  void loadAccount() {
    state.account.value = authService.listAccount.firstWhere(
        (element) => element.accCode == (tokenEntity?.data?.defaultAcc ?? ""),
        orElse: () => Account());

    state.accountReceiver.value = authService.listAccount.firstWhere(
        (element) => element.accCode != (state.account.value.accCode ?? ""),
        orElse: () => Account());

    state.userReceiverController.text =
        state.accountReceiver.value.accCode ?? "";

    getPortfolio();
  }

  void changeAccount(Account account) {
    state.account.value = account;

    state.accountReceiver.value = authService.listAccount.firstWhere(
        (element) => element.accCode != (state.account.value.accCode ?? ""),
        orElse: () => Account());

    state.userReceiverController.text =
        state.accountReceiver.value.accCode ?? "";

    getPortfolio();
  }

  Future<void> getPortfolio() async {
    final RequestParams _requestParams = RequestParams(group: "Q");
    _requestParams.session = tokenEntity?.data?.sid ?? "";
    _requestParams.user = tokenEntity?.data?.user ?? "";
    ParamsObject _object = ParamsObject();
    _object.type = "string";
    _object.cmd = "Web.Portfolio.PortfolioStatus";
    _object.p1 = state.account.value.accCode ?? "";
    _requestParams.data = _object;
    try {
      var response = await apiService.getPortfolio(_requestParams);
      if (response!.data!.isNotEmpty) {
        if (response.data!.length > 1) {
          state.portfolioList.value = response.data!;
          state.portfolioList.remove(state.portfolioList.first);
        }
      }
    } on ErrorException catch (error) {
      AppSnackBar.showError(message: error.message);
    }
  }

  @override
  void onReady() {
    loadAccount();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
