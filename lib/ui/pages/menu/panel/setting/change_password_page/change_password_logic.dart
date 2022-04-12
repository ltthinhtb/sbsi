import 'package:get/get.dart';
import 'package:sbsi/model/params/data_params.dart';
import 'package:sbsi/model/params/index.dart';
import 'package:sbsi/services/index.dart';
import 'change_password_state.dart';

class ChangePasswordLogic extends GetxController {
  final ChangePasswordState state = ChangePasswordState();
  final ApiService apiService = Get.find();
  final AuthService authService = Get.find();

  Future<void> changePassword() async {
    print(ChangePasswordModel(state.old_controller.text,
            state.new_controller.text, state.confirm_controller.text)
        .toJson());
    var _tokenEntity = authService.token.value;
    final RequestParams _requestParams = RequestParams(
      group: "B",
      session: _tokenEntity?.data?.sid,
      user: _tokenEntity?.data?.user,
      data: ParamsObject(
        type: "object",
        cmd: "APP.CHANGE_PASSWORD",
        p: ChangePasswordModel(state.old_controller.text,
            state.new_controller.text, state.confirm_controller.text),
      ),
    );
    try {
      await apiService.changePassword(_requestParams);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changePasswordFirst() async {
    var _tokenEntity = authService.token.value;
    final RequestParams _requestParams = RequestParams(
      group: "L",
      session: _tokenEntity?.data?.sid,
      user: _tokenEntity?.data?.user,
      data: ParamsObject(
        type: "object",
        cmd: "ChangePassFirstLogin",
        p1: state.old_controller.text,
        p2: state.new_controller.text,
        // p: ChangePasswordModel(state.old_controller.text,
        //     state.new_controller.text, state.confirm_controller.text),
      ),
    );
    try {
      await apiService.changePassword(_requestParams);
      Get.back(result: state.new_controller.text);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> validateInfo() async {
    if (state.new_controller.text != state.confirm_controller.text) {
      throw "Xác nhận mật khẩu không khớp";
    } else {
      return;
    }
  }

  @override
  void onInit() async {
    super.onInit();
  }
}
