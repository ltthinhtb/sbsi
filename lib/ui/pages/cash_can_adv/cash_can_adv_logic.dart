import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_images.dart';
import 'package:sbsi/ui/widgets/button/button_filled.dart';

import '../../../common/app_colors.dart';
import '../../../generated/l10n.dart';
import '../../../model/params/data_params.dart';
import '../../../model/params/request_params.dart';
import '../../../networks/error_exception.dart';
import '../../../services/index.dart';
import '../../commons/app_snackbar.dart';
import 'cash_can_adv_state.dart';

class CashCanAdvLogic extends GetxController {
  final CashCanAdvState state = CashCanAdvState();

  final ApiService apiService = Get.find();
  final AuthService authService = Get.find();

  // switch tài khoản 1-6
  void changeAccount() {
    var index = authService.listAccount.indexWhere(
        (element) => state.account.value.accCode != element.accCode);
    if (index >= 0) {
      state.account.value = authService.listAccount[index];
      // load danh sách quyền
      getListCash();
      // lịch sử ứng
      getListCashHistory();
    }
  }

  void loadAccount() {
    var _tokenEntity = authService.token.value;
    var index = authService.listAccount.indexWhere(
        (element) => _tokenEntity?.data?.defaultAcc == element.accCode);
    if (index >= 0) {
      state.account.value = authService.listAccount[index];
      // load danh sách quyền
      getListCash();
      // lịch sử ứng
      getListCashHistory();
    }
  }

  // danh sách quyền
  Future<void> getListCash() async {
    var _tokenEntity = authService.token.value;
    final RequestParams _requestParams = RequestParams(group: "B");
    _requestParams.session = _tokenEntity?.data?.sid ?? "";
    _requestParams.user = _tokenEntity?.data?.user ?? "";
    ParamsObject _object = ParamsObject();
    _object.type = "cursor";
    _object.cmd = "ListCashCanAdv";
    _object.p1 = state.account.value.accCode ?? "";
    _requestParams.data = _object;
    try {
      var response = await apiService.getListCashCanAdv(_requestParams);
      state.listCashCan.value = response;
    } on ErrorException catch (error) {
      AppSnackBar.showError(message: error.message);
    }
  }

  // danh sách quyền
  Future<void> getFeeWithDraw(
      {required String sellDate,
      required String dueDate,
      required String money}) async {
    var _tokenEntity = authService.token.value;
    final RequestParams _requestParams = RequestParams(group: "B");
    _requestParams.session = _tokenEntity?.data?.sid ?? "";
    _requestParams.user = _tokenEntity?.data?.user ?? "";
    ParamsObject _object = ParamsObject();
    _object.type = "cursor";
    _object.cmd = "ListFeeAdvanceWithdraw";
    _object.p1 = state.account.value.accCode ?? "";
    _object.p2 = sellDate;
    _object.p3 = dueDate;
    _object.p4 = money;
    _requestParams.data = _object;
    try {
      var response = await apiService.getFeeAdvanceWithdraw(_requestParams);
      state.feeWithDraw.value = response;
    } on ErrorException catch (error) {
      AppSnackBar.showError(message: error.message);
    }
  }

  // lịch sử ứng
  Future<void> getListCashHistory() async {
    var _tokenEntity = authService.token.value;
    final RequestParams _requestParams = RequestParams(group: "B");
    _requestParams.session = _tokenEntity?.data?.sid ?? "";
    _requestParams.user = _tokenEntity?.data?.user ?? "";
    ParamsObject _object = ParamsObject();
    _object.type = "cursor";
    _object.cmd = "ListAdvanceWithdraw";
    _object.p1 = state.account.value.accCode ?? "";
    _object.p2 = state.startDateController.text;
    _object.p3 = state.endDateController.text;
    _object.p4 = "";
    _object.p5 = "1";
    _object.p6 = "30";
    _requestParams.data = _object;
    try {
      var response = await apiService.getListAdvanceWithdraw(_requestParams);
      state.listAdvance.value = response;
    } on ErrorException catch (error) {
      AppSnackBar.showError(message: error.message);
    }
  }

  // ứng tiền
  Future<void> updateShareTransferIn(
      {required String sellDtate,
      required String dueDate,
      required String money}) async {
    var _tokenEntity = authService.token.value;
    final RequestParams _requestParams = RequestParams(group: "B");
    _requestParams.session = _tokenEntity?.data?.sid ?? "";
    _requestParams.user = _tokenEntity?.data?.user ?? "";
    ParamsObject _object = ParamsObject();
    _object.type = "string";
    _object.cmd = "UpdateAdvanceWithdraw";
    _object.p1 = state.account.value.accCode ?? "";
    _object.p2 = sellDtate;
    _object.p3 = dueDate;
    _object.p4 = money;
    _object.p6 = state.pinController.text;
    _requestParams.data = _object;
    try {
      await apiService.updateShareTransferIn(_requestParams);
      // load danh sách quyền
      await getListCash();
      Get.back();
      await showDialog();
    } on ErrorException catch (error) {
      AppSnackBar.showError(message: error.message);
    } catch (e) {
      //logger.e(e.toString());
    }
  }

  Future<void> showDialog() async {
    await Get.dialog(Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: Builder(builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Text(
                "Ứng tiền thành công",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 24),
              Center(
                child: SvgPicture.asset(AppImages.check1),
              ),
              const SizedBox(height: 32),
              ButtonFill(
                  voidCallback: () {
                    Get.back();
                  },
                  title: S.current.confirm),
              const SizedBox(height: 24),
            ],
          ),
        );
      }),
    )).then((value) {
      Get.back();
    });
  }

  @override
  void onReady() {
    loadAccount();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
