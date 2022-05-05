import 'package:get/get.dart';
import 'package:sbsi/services/index.dart';
import 'package:sbsi/ui/pages/menu/menu_state.dart';

class MenuLogic extends GetxController {
  final MenuState state = MenuState();
  final ApiService apiService = Get.find();
  final AuthService authService = Get.find();


  void loadAccount() {
    var _tokenEntity = authService.token.value;
    var index = authService.listAccount.indexWhere(
            (element) => _tokenEntity?.data?.defaultAcc == element.accCode);
    if (index >= 0) {
      state.account.value = authService.listAccount[index];
    }
  }

  @override
  void onInit() {
    loadAccount();
    super.onInit();
  }
}
