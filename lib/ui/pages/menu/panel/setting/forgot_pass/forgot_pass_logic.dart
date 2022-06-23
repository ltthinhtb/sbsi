import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/model/params/forgot_pass_request.dart';
import 'package:sbsi/networks/error_exception.dart';
import 'package:sbsi/ui/commons/app_snackbar.dart';
import 'package:sbsi/ui/pages/otp/otp_page.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../../services/index.dart';
import '../../../../../../utils/logger.dart';
import 'forgot_pass_state.dart';

class ForgotPassLogic extends GetxController {
  final ForgotPassState state = ForgotPassState();
  final ApiService apiService = Get.find();
  final AuthService authService = Get.find();

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> forgotPass(BuildContext context) async {
    try {
      ForgotPassRequest request = ForgotPassRequest(
          username: state.accountController.text,
          step: state.step.value.toString(),
          ss: "",
          p1: state.identityController.text,
          otp: state.otpController.text,
          p2: state.phoneNumberController.text);
      await apiService.forgotPass(request);
      // đổi step
      if (state.step.value == 1) {
        state.step.value = 2;
        return Get.to(OtpPage(
            onRequest: () {
              forgotPass(context);
            },
            isGetOtp: false,
            getBackOtp: () async {
              await apiService.forgotPass(request);
            },
            pinPutController: state.otpController,
            phone: state.phoneNumberController.text));
      }
      if (state.step.value == 2) {
        // back lại màn hình chính
        Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
        AppSnackBar.showSuccess(message: S.current.reset_pass_success);
      }
    } on ErrorException catch (e) {
      AppSnackBar.showError(message: e.message);
    } catch (e) {
      logger.e(e.toString());
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
