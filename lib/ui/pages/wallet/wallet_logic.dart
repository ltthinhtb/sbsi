import 'package:get/get.dart';
import 'package:sbsi/model/entities/index.dart';
import 'package:sbsi/model/params/data_params.dart';
import 'package:sbsi/model/params/index.dart';
import 'package:sbsi/networks/error_exception.dart';
import 'package:sbsi/services/index.dart';
import 'package:sbsi/ui/commons/app_snackbar.dart';
import 'wallet_state.dart';

class WalletLogic extends GetxController {
  final WalletState state = WalletState();
  final ApiService apiService = Get.find();
  final AuthService authService = Get.find();

  late TokenEntity _tokenEntity;

  String get defAcc => _tokenEntity.data!.defaultAcc ?? "";

  final RequestParams _requestParams = RequestParams(group: "Q");

  void getTokenUser() {
    if (authService.token.value != null) {
      _tokenEntity = (authService.token.value)!;
      _requestParams.user = _tokenEntity.data?.user;
      _requestParams.session = _tokenEntity.data?.sid;
      getAccountStatus();
      getPortfolio();
    }
  }

  void loadAccount() {
    var _tokenEntity = authService.token.value;
    var index = authService.listAccount.indexWhere(
            (element) => _tokenEntity?.data?.defaultAcc == element.accCode);
    if (index >= 0) {
      state.account.value = authService.listAccount[index];
    }
  }

  Future<void> getAccountStatus({String? account}) async {
    ParamsObject _object = ParamsObject();
    _object.type = "string";
    _object.cmd = "Web.Portfolio.AccountStatus";
    _object.p1 = account ?? defAcc;
    _requestParams.data = _object;
    try {
      var response = await apiService.getAccountStatus(_requestParams);
      state.assets.value = response!.data!;
    } on ErrorException catch (error) {
      AppSnackBar.showError(message: error.message);
    }
  }

  Future<void> getPortfolio({String? account}) async {
    ParamsObject _object = ParamsObject();
    _object.type = "string";
    _object.cmd = "Web.Portfolio.PortfolioStatus";
    _object.p1 = account ?? defAcc;
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
    getTokenUser();
    loadAccount();
    super.onReady();
  }
}
