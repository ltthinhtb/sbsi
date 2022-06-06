import 'package:get/get.dart';
import 'package:sbsi/model/params/forgot_pass_request.dart';
import 'package:sbsi/networks/error_exception.dart';
import 'package:sbsi/ui/commons/app_snackbar.dart';

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

  Future<void> forgotPass() async {
    try {
      ForgotPassRequest request = ForgotPassRequest(
          username: state.accountController.text,
          step: state.step.value.toString(),
          ss: "",
          p1: state.identityController.text,
          otp: "",
          p2: state.phoneNumberController.text);
      await apiService.forgotPass(request);
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
