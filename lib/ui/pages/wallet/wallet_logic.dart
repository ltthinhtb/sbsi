import 'package:get/get.dart';
import 'package:sbsi/model/params/data_params.dart';
import 'package:sbsi/model/params/index.dart';
import 'package:sbsi/networks/error_exception.dart';
import 'package:sbsi/services/index.dart';
import 'package:sbsi/ui/commons/app_snackbar.dart';
import 'wallet_state.dart';

class WalletLogic extends GetxController {
  final WalletState state = WalletState();
  final ApiService apiService = Get.find<ApiService>();
  final AuthService authService = Get.find<AuthService>();

  final RequestParams _requestParams = RequestParams(group: "Q");

  // load tài khoản mặc định
  void loadAccount() {
    var _tokenEntity = authService.token.value;
    var index = authService.listAccount.indexWhere(
        (element) => _tokenEntity?.data?.defaultAcc == element.accCode);
    if (index >= 0) {
      state.account.value = authService.listAccount[index];
    }
    _requestParams.session = _tokenEntity?.data?.sid ?? "";
    _requestParams.user = _tokenEntity?.data?.user ?? "";
  }

  // switch tài khoản 1-6
  void changeAccount() {
    var index = authService.listAccount.indexWhere(
        (element) => state.account.value.accCode != element.accCode);
    if (index >= 0) {
      state.account.value = authService.listAccount[index];
      getAccountStatus();
      getPortfolio();
    }
  }

  Future<void> getTotalAssets() async {
    var _tokenEntity = authService.token.value;

    final RequestParams _requestParams = RequestParams(
        group: "SU",
        user: _tokenEntity?.data?.user ?? "",
        session: _tokenEntity?.data?.sid ?? "",
        data: ParamsObject(cmd: "TotalAsset"));
    try {
      state.totalAssets.value = await apiService.getTotalAssets(_requestParams);
    } on ErrorException catch (error) {
      AppSnackBar.showError(message: error.message);
    }
  }

  Future<void> getAccountStatus() async {
    ParamsObject _object = ParamsObject();
    _object.type = "string";
    _object.cmd = "Web.Portfolio.AccountStatus";
    _object.p1 = state.account.value.accCode ?? "";

    _requestParams.data = _object;
    try {
      var response = await apiService.getAccountMStatus(_requestParams);
      state.assets.value = response;
    } on ErrorException catch (error) {
      AppSnackBar.showError(message: error.message);
    }
  }


  Future<void> getPortfolio() async {
    ParamsObject _object = ParamsObject();
    _object.type = "string";
    _object.cmd = "Web.Portfolio.PortfolioStatus";
    _object.p1 = state.account.value.accCode ?? "";
    _requestParams.data = _object;
    try {
      var response = await apiService.getPortfolio(_requestParams);
      if (response!.data!.isNotEmpty) {
        state.portfolioTotal.value = response.data!.first;
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
    getTotalAssets();
    getAccountStatus();
    getPortfolio();
    super.onReady();
  }
}
