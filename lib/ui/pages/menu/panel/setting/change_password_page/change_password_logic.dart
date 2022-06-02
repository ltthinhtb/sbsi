import 'package:get/get.dart';
import 'package:sbsi/model/params/data_params.dart';
import 'package:sbsi/model/params/index.dart';
import 'package:sbsi/services/index.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../widgets/dialog/custom_dialog.dart';
import 'change_password_state.dart';

class ChangePasswordLogic extends GetxController {
  final ChangePasswordState state = ChangePasswordState();
  final ApiService apiService = Get.find();
  final AuthService authService = Get.find();

  Future<void> changePassword() async {
    var _tokenEntity = authService.token.value;
    final RequestParams _requestParams = RequestParams(
      group: "B",
      session: _tokenEntity?.data?.sid,
      user: _tokenEntity?.data?.user,
      otp: "",
      data: ParamsObject(
          type: "string",
          cmd: "ChangePass",
          p1: state.old_controller.text,
          p2: state.new_controller.text),
    );
    try {
      await apiService.changePassword(_requestParams);
      updatePass();
      CustomDialog.showDialogSuccess(S.current.change_password_success)
          .then((value) {
        Get.back();
      });
    } catch (e) {
      rethrow;
    }
  }

  void updatePass() {
    var token = Get.find<AuthService>().token.value;
    token?.data?.pass = state.new_controller.text;
    Get.find<AuthService>().saveToken(token!);
  }

  Future<void> changePasswordFirst() async {
    var _tokenEntity = authService.token.value;
    final RequestParams _requestParams = RequestParams(
      group: "B",
      session: _tokenEntity?.data?.sid,
      channel: "W",
      user: _tokenEntity?.data?.user,
      data: ParamsObject(
          type: "string",
          cmd: "ChangePassFirstLogin",
          p1: state.old_controller.text,
          p2: state.new_controller.text,
          p3: state.oldPinController.text,
          p4: state.newPinController.text
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
