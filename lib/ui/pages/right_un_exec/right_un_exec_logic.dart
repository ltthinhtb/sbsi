import 'package:get/get.dart';

import '../../../model/params/data_params.dart';
import '../../../model/params/request_params.dart';
import '../../../networks/error_exception.dart';
import '../../../services/index.dart';
import '../../commons/app_snackbar.dart';
import 'right_un_exec_state.dart';

class RightUnExecLogic extends GetxController {
  final Right_un_execState state = Right_un_execState();
  final ApiService apiService = Get.find();
  final AuthService authService = Get.find();

  // switch tài khoản 1-6
  void changeAccount() {
    var index = authService.listAccount.indexWhere(
        (element) => state.account.value.accCode != element.accCode);
    if (index >= 0) {
      state.account.value = authService.listAccount[index];
      // load tài sản
      getAccountStatus();
      // load danh sách quyền
      getListRight();

      getListRightHistory();

    }
  }

  void loadAccount() {
    var _tokenEntity = authService.token.value;
    var index = authService.listAccount.indexWhere(
        (element) => _tokenEntity?.data?.defaultAcc == element.accCode);
    if (index >= 0) {
      state.account.value = authService.listAccount[index];
      // load tài sản
      getAccountStatus();
      // load danh sách quyền
      getListRight();

      getListRightHistory();

    }
  }

  // tài sản theo account
  Future<void> getAccountStatus() async {
    var _tokenEntity = authService.token.value;
    final RequestParams _requestParams = RequestParams(group: "Q");
    _requestParams.session = _tokenEntity?.data?.sid ?? "";
    _requestParams.user = _tokenEntity?.data?.user ?? "";
    ParamsObject _object = ParamsObject();
    _object.type = "string";
    _object.cmd = "Web.Portfolio.AccountStatus";
    _object.p1 = state.account.value.accCode ?? "";

    _requestParams.data = _object;
    try {
      var response = await apiService.getAccountStatus(_requestParams);
      state.assets.value = response!.data!;
    } on ErrorException catch (error) {
      AppSnackBar.showError(message: error.message);
    }
  }

  // danh sách quyền
  Future<void> getListRight() async {
    var _tokenEntity = authService.token.value;
    final RequestParams _requestParams = RequestParams(group: "B");
    _requestParams.session = _tokenEntity?.data?.sid ?? "";
    _requestParams.user = _tokenEntity?.data?.user ?? "";
    ParamsObject _object = ParamsObject();
    _object.type = "cursor";
    _object.cmd = "ListRightUnExec";
    _object.p1 = state.account.value.accCode ?? "";
    _requestParams.data = _object;
    try {
      var response = await apiService.getListRightExc(_requestParams);
      state.listRightExt.value = response;
    } on ErrorException catch (error) {
      AppSnackBar.showError(message: error.message);
    }
  }

  // danh sách lịch sử hưởng quyền
  Future<void> getListRightHistory() async {
    var _tokenEntity = authService.token.value;
    final RequestParams _requestParams = RequestParams(group: "B");
    _requestParams.session = _tokenEntity?.data?.sid ?? "";
    _requestParams.user = _tokenEntity?.data?.user ?? "";
    ParamsObject _object = ParamsObject();
    _object.type = "cursor";
    _object.cmd = "ListRightHistory";
    _object.p1 = state.account.value.accCode ?? "";
    _object.p2 = "";
    _object.p3 = state.startDateController.text;
    _object.p4 = state.endDateController.text;
    _object.p5 = "";
    _object.p6 = "1";
    _object.p7 = "30";

    _requestParams.data = _object;
    try {
      var response = await apiService.getListRightHistory(_requestParams);
      state.listRightHistory.value = response;
    } on ErrorException catch (error) {
      AppSnackBar.showError(message: error.message);
    }
  }

  // chuyển chứng khoán
  Future<void> updateShareTransferIn(
      {required String pkRight, required String amount}) async {
    var _tokenEntity = authService.token.value;
    final RequestParams _requestParams = RequestParams(group: "B");
    _requestParams.session = _tokenEntity?.data?.sid ?? "";
    _requestParams.user = _tokenEntity?.data?.user ?? "";
    ParamsObject _object = ParamsObject();
    _object.type = "string";
    _object.cmd = "UpdateRightRegister";
    _object.p1 = state.account.value.accCode ?? "";
    _object.p2 = pkRight;
    _object.p3 = amount;
    _object.p4 = state.account.value.accCode ?? "";
    _object.p5 = "";
    _object.p6 = state.pinController.text;
    _requestParams.data = _object;
    try {
      await apiService.updateShareTransferIn(_requestParams);
      // load tài sản
      await getAccountStatus();
      // load danh sách quyền
      await getListRight();

      Get.back();
      AppSnackBar.showSuccess(message: "Thực hiện quyền thành công");
    } on ErrorException catch (error) {
      AppSnackBar.showError(message: error.message);
    } catch (e) {
      //logger.e(e.toString());
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
