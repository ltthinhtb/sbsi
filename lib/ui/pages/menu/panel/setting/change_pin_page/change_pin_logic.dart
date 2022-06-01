import 'package:get/get.dart';
import 'package:sbsi/model/params/data_params.dart';
import 'package:sbsi/model/params/index.dart';
import 'package:sbsi/services/index.dart';
import 'change_pin_state.dart';

class ChangePinLogic extends GetxController {
  final ChangePinState state = ChangePinState();
  final ApiService apiService = Get.find();
  final AuthService authService = Get.find();

  Future<void> changePin() async {
    print(ChangePinModel(state.old_controller.text,
            state.new_controller.text, state.confirm_controller.text)
        .toJson());
    var _tokenEntity = authService.token.value;
    final RequestParams _requestParams = RequestParams(
      group: "B",
      session: _tokenEntity?.data?.sid,
      user: _tokenEntity?.data?.user,
       otp: "",
      data: ParamsObject(
        type: "string",
        cmd: "ChangePin",
        p1: state.old_controller.text,
        p2: state.new_controller.text
      ),
    );
    try {
      await apiService.changePassword(_requestParams);
    } catch (e) {
      rethrow;
    }
  }


  @override
  void onInit() async {
    super.onInit();
  }
}
