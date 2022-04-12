import 'package:get/get.dart';
import 'package:sbsi/services/index.dart';
import 'package:sbsi/ui/pages/menu/menu_state.dart';

class MenuLogic extends GetxController {
  final MenuState state = MenuState();
  final ApiService apiService = Get.find();
  final AuthService authService = Get.find();

  @override
  void onInit() {
    super.onInit();
  }
}
