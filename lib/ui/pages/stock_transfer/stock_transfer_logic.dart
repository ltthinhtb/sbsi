import 'package:get/get.dart';
import 'package:sbsi/model/entities/share_transfer.dart';
import 'package:sbsi/model/response/portfolio.dart';
import 'package:sbsi/ui/commons/app_dialog.dart';

import '../../../model/entities/token_entity.dart';
import '../../../model/params/data_params.dart';
import '../../../model/params/request_params.dart';
import '../../../model/response/list_account_response.dart';
import '../../../networks/error_exception.dart';
import '../../../services/index.dart';
import '../../../utils/logger.dart';
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

  // thay đổi tài khoản
  void changeAccount(Account account) {
    state.account.value = account;

    state.accountReceiver.value = authService.listAccount.firstWhere(
        (element) => element.accCode != (state.account.value.accCode ?? ""),
        orElse: () => Account());

    state.userReceiverController.text =
        state.accountReceiver.value.accCode ?? "";
    // xóa mã đang chọn
    state.portfolio.value = PortfolioStatus();

    // xóa giá trị khả dụng
    state.shareTransfer.value = ShareTransfer();

    // lấy list mã ck theo tài khoản
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

  void changePortfolio(PortfolioStatus portfolioStatus) {
    state.portfolio.value = portfolioStatus;
    getShareTransfer();
  }

  // lấy số lượng mã chứng khoán khả dụng
  Future<void> getShareTransfer() async {
    final RequestParams _requestParams = RequestParams(group: "Q");
    _requestParams.session = tokenEntity?.data?.sid ?? "";
    _requestParams.user = tokenEntity?.data?.user ?? "";
    ParamsObject _object = ParamsObject();
    _object.type = "string";
    _object.cmd = "FO.GETSHARETRANSFER";
    _object.p1 = state.account.value.accCode ?? "";
    _object.p2 = state.portfolio.value.symbol ?? "";
    _requestParams.data = _object;
    try {
      state.shareTransfer.value =
          await apiService.getShareTransfer(_requestParams);
    } on ErrorException catch (error) {
      AppSnackBar.showError(message: error.message);
    } catch (e) {}
  }

  // chuyển chứng khoán
  Future<void> updateShareTransferIn() async {
    final RequestParams _requestParams = RequestParams(group: "B");
    _requestParams.session = tokenEntity?.data?.sid ?? "";
    _requestParams.user = tokenEntity?.data?.user ?? "";
    ParamsObject _object = ParamsObject();
    _object.type = "string";
    _object.cmd = "UpdateShareTransferIn";
    _object.p1 = state.account.value.accCode ?? "";
    _object.p2 = state.accountReceiver.value.accCode ?? "";
    _object.p3 = state.portfolio.value.symbol ?? "";
    _object.p4 = state.amountController.text;
    _object.p5 = "Chuyen chung khoan";
    _object.p6 = state.pinController.text;
    _object.p7 = state.otpController.text;
    _requestParams.data = _object;
    try {
      await apiService.updateShareTransferIn(_requestParams);
      await getShareTransfer();
      Get.back();
      AppSnackBar.showSuccess(message: "Đặt lệnh thành công!");
    } on ErrorException catch (error) {
      AppSnackBar.showError(message: error.message);
    } catch (e) {
      //logger.e(e.toString());
    }
  }

  // lịch sử chuyển chứng khoán
  Future<void> getListShareTransfer() async {
    final RequestParams _requestParams = RequestParams(group: "B");
    _requestParams.session = tokenEntity?.data?.sid ?? "";
    _requestParams.user = tokenEntity?.data?.user ?? "";
    ParamsObject _object = ParamsObject();
    _object.type = "cursor";
    _object.cmd = "ListShareTransfer";
    _object.p1 = state.account.value.accCode ?? "";
    _object.p2 = state.startDateController.text;
    _object.p3 = state.endDateController.text;
    _object.p4 = "";
    _object.p5 = "";
    _object.p6 = "1";
    _object.p7 = "20";
    _requestParams.data = _object;
    try {
      state.listShareHistory.value =
          await apiService.getListShareTransfer(_requestParams);
    } on ErrorException catch (error) {
      AppSnackBar.showError(message: error.message);
    } catch (e) {
      logger.e(e.toString());
    }
  }

  @override
  void onReady() {
    loadAccount();
    getListShareTransfer();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
