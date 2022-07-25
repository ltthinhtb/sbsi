import 'package:get/get.dart';
import 'package:sbsi/model/enums/gender_type.dart';
import '../../../model/entities/bank.dart';
import '../../../model/params/open_account_request.dart';
import '../../../model/params/request_params.dart';
import '../../../networks/error_exception.dart';
import '../../../services/index.dart';
import '../../../utils/logger.dart';
import '../../commons/app_loading.dart';
import '../../commons/app_snackbar.dart';
import 'enum/enums.dart';
import 'page/otp_page.dart';
import 'page/success_page.dart';
import 'sign_up_state.dart';

class SignUpLogic extends GetxController {
  final SignUpState state = SignUpState();
  final apiService = Get.find<ApiService>();
  final authService = Get.find<AuthService>();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> getListBank() async {
    final RequestParams _requestParams =
        RequestParams(user: "back", cmd: "LIST_BANK", session: "", param: {});
    try {
      state.listBank = await apiService.getListBankSignUp(_requestParams);
    } on ErrorException catch (e) {
      AppSnackBar.showError(message: e.message);
    }
  }

  List<Bank> searchBank(String stockCode) {
    List<Bank> searchResult = state.listBank
        .where(
          (element) => element.cBANKCODE!.toLowerCase().startsWith(
                stockCode.toLowerCase(),
              ),
        )
        .toList();
    return searchResult;
  }

  Future<void> getSaleID() async {
    final RequestParams _requestParams = RequestParams(
        user: "back",
        cmd: "GET_SALEID",
        param: {"C_SALE_ID": state.referralController.text});
    try {
      if (state.referralController.text.isEmpty) {
        // nếu mã ID bỏ trống
        state.errorText.value = null;
        state.referralNameController.clear();
        return;
      }
      var response = await apiService.getSaleID(_requestParams);
      // không có lỗi
      state.errorText.value = null;
      // lấy tên người giới thiệu
      state.referralNameController.text = response;
    } on ErrorException catch (e) {
      // lỗi không có saleID
      state.errorText.value = e.message;
      // xóa tên người giới thiệu
      state.referralNameController.clear();
      // AppSnackBar.showError(message: e.message);
    }
  }

  Future<void> checkPhone() async {
    final RequestParams _requestParams = RequestParams(
        user: "back",
        cmd: "CHECK_OPENACC",
        enPoint: "verifyPhoneEmail",
        param: {
          "C_MOBILE": state.phoneController.text,
          "C_EMAIL": state.emailController.text
        });
    try {
      await apiService.checkAccount(_requestParams);
      // check thành công sẽ đến mà otp
      Get.to(const OtpValidate());
    } on ErrorException catch (e) {
      AppSnackBar.showError(message: e.message);
    }
  }

  // check cmt cmnd
  Future<void> checkIdentity() async {
    final RequestParams _requestParams =
        RequestParams(user: "back", cmd: "CHECK_CARDID", param: {
      "C_CARD_ID": state.orcResponse?.id ?? "",
      "C_ISSUE_DATE": state.orcResponse?.issueDate ?? "",
    });
    try {
      await apiService.checkAccount(_requestParams);
    } on ErrorException catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  /// upload IdentityCard
  Future<void> uploadUrlImage(
      {required List<int> frontIDByte,
      required List<int> backIDByte,
      required List<int> faceByte}) async {
    try {
      /// upload ảnh mặt trước và ảnh mặt sau
      var listResponse = await apiService.uploadMultipleFile([
        EKYCImage(EKYC_image.frontCard, frontIDByte),
        EKYCImage(EKYC_image.backCard, backIDByte),
        EKYCImage(EKYC_image.face1, faceByte),
      ]);

      /// response là dạng map nên parse để lấy url image
      state.cardFrontUrl = listResponse[EKYC_image.frontCard.value];
      state.cardBackUrl = listResponse[EKYC_image.backCard.value];
      state.faceUrl = listResponse[EKYC_image.face1.value];
    } on ErrorException {
      rethrow;
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    } finally {
      AppLoading.disMissLoading();
    }
  }

  /// uploadSignature Image
  Future<void> uploadSignatureImage({required List<int> signNatureFile}) async {
    try {
      AppLoading.showLoading();

      /// upload ảnh mặt trước và ảnh mặt sau
      var listResponse = await apiService.uploadMultipleFile([
        EKYCImage(EKYC_image.signature, signNatureFile),
      ]);

      /// response là dạng map nên parse để lấy url image
      state.signatureUrl = listResponse[EKYC_image.signature.value];
    } catch (e) {
      logger.e(e.toString());
    } finally {
      AppLoading.disMissLoading();
    }
  }

  Future openAccount() async {
    AppLoading.showLoading();
    final RequestParams _requestParams = RequestParams(
        enPoint: "openAccount",
        user: "back",
        cmd: "OPEN_INDI_ACCOUNT",
        param: OpenAccountRequest(
                cCARDID: state.orcResponse?.id ?? "",
                // cmt
                cFULLNAME: state.orcResponse?.name ?? "",
                cCUSTBIRTHDAY: state.orcResponse?.birthDay ?? "",
                cISSUEDATE: state.orcResponse?.issueDate ?? "",
                cISSUEEXPIRE: state.orcResponse?.validDate ?? "",
                cADDRESS:
                    state.orcResponse?.recentLocation?.replaceAll("\n", ", ") ??
                        "",
                cANHCHANDUNG: state.faceUrl,
                cANHCHUKY: state.signatureUrl,
                cANHMATSAU: state.cardBackUrl,
                cANHMATTRUOC: state.cardFrontUrl,
                cBANKCODE: state.bankController.text,
                cCONTACTADDRESS:
                    state.orcResponse?.recentLocation?.replaceAll("\n", ", ") ??
                        "",
                cEMAIL: state.emailController.text,
                cGENDER: state.orcResponse?.gender == GenderType.male.vnText
                    ? "M"
                    : "F",
                cISSUEPLACE: state.orcResponse?.issuePlace ?? "",
                cMOBILE: state.phoneController.text,
                cMOBILETRADINGPASSWORD: state.passPinController.text,
                cOPENMARGIN: state.isOpenMargin ? "1" : "0",
                cPASSWORD: state.passController.text,
                cPROVINCE: state.orcResponse?.postCode?.first.city?[1] ?? "",
                cSALEID: state.referralController.text,
                cRECEIVEBANKACCOUNT: state.bankAccountController.text,
                C_ADVANCE_WITHDRAW: state.C_ADVANCE_WITHDRAW.toString(),
                C_RECEIVE_EMAIL: state.C_RECEIVE_EMAIL.toString(),
                C_FOLLOW_TRADING: state.C_FOLLOW_TRADING.toString(),
                C_SUB_BRANCH_BANK: state.bankBranhController.text,
            C_CONTACT_ADDRESS: state.addressController.text,
                C_ONLINE_TRADING: state.C_ONLINE_TRADING.toString())
            .toJson());
    try {
      var response = await apiService.checkAccount(_requestParams);
      state.accountCode = response['SOTK'];
      Get.to(const SuccessPage());
    } on ErrorException catch (e) {
      AppSnackBar.showError(message: e.message);
    } finally {
      AppLoading.disMissLoading();
    }
  }
}
