import 'package:get/get.dart';
import 'package:sbsi/model/entities/beneficiary_account.dart';
import 'package:sbsi/model/entities/index.dart';
import 'package:sbsi/networks/error_exception.dart';
import 'package:sbsi/services/api/api_service.dart';
import 'package:sbsi/services/auth_service.dart';
import 'package:sbsi/ui/commons/app_snackbar.dart';
import 'package:sbsi/ui/pages/money_transfer/enums/transfer_type.dart';
import 'package:sbsi/utils/utils.dart';

import '../../../model/entities/bank.dart';
import '../../../model/params/data_params.dart';
import '../../../model/params/request_params.dart';
import '../../../model/response/list_account_response.dart';
import 'money_transfer_state.dart';
import 'pages/transfer_success.dart';

class MoneyTransferLogic extends GetxController {
  final MoneyTransferState state = MoneyTransferState();

  final apiService = Get.find<ApiService>();

  final authService = Get.find<AuthService>();

  TokenEntity? get tokenEntity => authService.token.value;

  String get contentDefault =>
      Utils.convertVNtoText('${tokenEntity?.data?.name ?? ""} chuyển tiền');

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
  }

  void changeAccount(Account account) {
    state.account.value = account;

    state.accountReceiver.value = authService.listAccount.firstWhere(
        (element) => element.accCode != (state.account.value.accCode ?? ""),
        orElse: () => Account());

    state.userReceiverController.text =
        state.accountReceiver.value.accCode ?? "";

    getCashAccountInfo();
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
      // cập nhật vailidate tiền
      state.userMoneyKey.currentState?.validate();
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
      // load bank then load list beneficiary
      getListBeneficiaryAccount();
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
        // choose first beneficiary
        changeBeneficiary(state.listBeneficiary.first);
      }
    } on ErrorException catch (e) {
      AppSnackBar.showError(message: e.message);
    }
  }

  // change beneficiary
  void changeBeneficiary(BeneficiaryAccount account) {
    state.beneficiary.value = account;
    // fill bank if bank exist
    var index = state.listBank
        .indexWhere((element) => element.cBANKCODE == account.cBANKCODE);

    state.userNameController.text =
        state.beneficiary.value.cBANKACCOUNTNAME ?? "";
    state.userAccountController.text =
        state.beneficiary.value.cBANKACCOUNTCODE ?? "";

    if (index >= 0) {
      state.bank.value = state.listBank[index];
    } else {
      state.bank.value = Bank();
    }
  }

  Future<void> updateCashTransferOnline() async {
    final RequestParams _requestParams = RequestParams(
      group: "B",
      user: tokenEntity?.data?.user ?? "",
      session: tokenEntity?.data?.sid ?? "",
      otp: state.otpController.text,
      data: ParamsObject(
        type: 'string',
        cmd: "UpdateCashTransferOnline",
        p1: state.account.value.accCode ?? "",
        // from account
        p2: "NAPAS",
        // transferType
        p3: "TOACCOUNT",
        p4: state.type.value(type: "BANK"),
        // internal , bank
        p5: state.beneficiary.value.cBANKCODE ?? "",
        // cBankCode,
        p6: state.userAccountController.text,
        // user account
        p7: state.userNameController.text,
        // user name,
        p8: "HA_NOI",
        // city
        p9: '01201001',
        // branchCode,
        p10: state.moneyController.numberValue.toStringAsFixed(0),
        // money,
        p11: "0",
        // cfee,
        p12: state.transferContentController.text,
        // content,
        p13: "1",
        // 1 save 0 no save ,
        p14: state.otpController.text,
        // otp ,
        p15: state.pinController.text,
        // pin ,
        pOther: "1", // pin ,
      ),
    );
    try {
      await apiService.updateCashTransferOnline(_requestParams);
      Get.back(); // pop dialog
      Get.to(const TransferSuccess());
    } on ErrorException catch (e) {
      AppSnackBar.showError(message: e.message);
    }
  }

  // transferInternal
  Future<void> updateCashTransferInternal() async {
    final RequestParams _requestParams = RequestParams(
      group: "B",
      user: tokenEntity?.data?.user ?? "",
      session: tokenEntity?.data?.sid ?? "",
      otp: state.otpController.text,
      data: ParamsObject(
        type: 'string',
        cmd: "UpdateCashTransferIn",
        p1: state.account.value.accCode ?? "",
        p2: state.accountReceiver.value.accCode ?? "",
        p3: state.moneyController.numberValue.toStringAsFixed(0),
        p4: state.transferContentController.text,
        p5: state.otpController.text,
        p6: state.pinController.text,
        p7: "1",
        p8: state.account.value.lastCharacter == 1 ? "1" : "0",
      ),
    );
    try {
      await apiService.updateCashTransferOnline(_requestParams);
      Get.back(); // pop dialog
      Get.to(const TransferSuccess());
    } on ErrorException catch (e) {
      AppSnackBar.showError(message: e.message);
    }
  }

  Future<void> getTransfersHistory() async {
    final RequestParams _requestParams = RequestParams(
        group: "B",
        user: tokenEntity?.data?.user ?? "",
        session: tokenEntity?.data?.sid ?? "",
        data: ParamsObject(
            type: 'cursor',
            cmd: "ListCashTransfer",
            p1: state.account.value.accCode ?? "",
            p2: state.startDateController.text,
            p3: state.endDateController.text,
            p6: "1",
            p7: "20"));
    try {
      state.listHistory.value =
          await apiService.getTransfersHistory(_requestParams);
      // load bank then load list beneficiary
    } on ErrorException catch (e) {
      AppSnackBar.showError(message: e.message);
    }
  }

  // getCFee
  Future<void> getCFeeOnline() async {
    final RequestParams _requestParams = RequestParams(
      group: "B",
      user: tokenEntity?.data?.user ?? "",
      session: tokenEntity?.data?.sid ?? "",
      data: ParamsObject(
        type: 'cursor',
        cmd: "GetFeeOnline",
        p1: "NAPAS",
        p2: state.bank.value.cBANKCODE,
        p3: state.moneyController.numberValue.toString(),
      ),
    );
    try {
      state.cFeeOnline.value = await apiService.getFeeOnline(_requestParams);
    } on ErrorException catch (e) {
      AppSnackBar.showError(message: e.message);
    } catch (e) {
      rethrow;
    }
  }

  // check pin
  Future<void> checkPin() async {
    final RequestParams _requestParams = RequestParams(
      group: "B",
      user: tokenEntity?.data?.user ?? "",
      session: tokenEntity?.data?.sid ?? "",
      data: ParamsObject(
        type: 'string',
        cmd: "CheckPin",
        p1: "",
        p2: state.pinController.text,
      ),
    );
    try {
      await apiService.checkPin(_requestParams);
    } catch (e) {
      rethrow;
    }
  }

  @override
  void onReady() {
    loadAccount();
    getCashAccountInfo();
    getListBank();
    getTransfersHistory();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
