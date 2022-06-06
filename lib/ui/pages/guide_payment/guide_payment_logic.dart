import 'package:get/get.dart';

import '../../../networks/error_exception.dart';
import '../../../services/index.dart';
import '../../../utils/logger.dart';
import '../../commons/app_snackbar.dart';
import 'guide_payment_state.dart';

class GuidePaymentLogic extends GetxController {
  final GuidePaymentState state = GuidePaymentState();
  final ApiService apiService = Get.find();
  final AuthService authService = Get.find();

  // danh sách quyền
  Future<void> getListBankAcc() async {
    try {
      var response = await apiService.getLisBankAcc();
      state.listBankAcc.value = response;
    } on ErrorException catch (error) {
      AppSnackBar.showError(message: error.message);
    } catch (e) {
      logger.e(e.toString());
    }
  }

  @override
  void onReady() {
    getListBankAcc();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
