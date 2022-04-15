import 'package:get/get.dart';
import 'package:sbsi/model/entities/user_stock.dart';
import 'package:sbsi/model/params/data_params.dart';
import 'package:sbsi/model/params/index.dart';
import 'package:sbsi/networks/error_exception.dart';
import 'package:sbsi/router/route_config.dart';
import 'package:sbsi/services/index.dart';
import 'package:sbsi/ui/commons/app_loading.dart';
import 'package:sbsi/ui/commons/app_snackbar.dart';
import 'package:sbsi/ui/pages/menu/panel/setting/change_password_page/change_password_view.dart';
import 'package:sbsi/utils/validator.dart';

import 'sign_in_state.dart';

class SignInLogic extends GetxController with Validator {
  final SignInState state = SignInState();

  ApiService apiService = Get.find();
  AuthService authService = Get.find();
  StoreService storeService = Get.find();

  final RequestParams _requestParams = RequestParams(
    group: "L",
    // session: "",
    channel: "channel",
  );

  void signIn() async {
    AppLoading.showLoading();
    final username = state.usernameTextController.text;
    final password = state.passwordTextController.text;
    bool validateUser = state.formKeyUser.currentState!.validate();
    bool validatePass = state.formKeyPass.currentState!.validate();
    bool validate = validateUser && validatePass;
    if (validate) {
      var dataParam = ParamsObject(
          cmd: 'Web.sCheckLogin',
          type: "string",
          p1: username,
          p2: password,
          p3: "M");
      _requestParams.user = username;
      _requestParams.data = dataParam;
      try {
        final result = await apiService.signIn(_requestParams);
        if (result != null) {
          result.data?.defaultAcc = '${result.data?.defaultAcc}1';
          authService.saveToken(result);
          AppLoading.disMissLoading();

          /// nếu cờ bằng 1 thì là đổi mật khẩu lần đầu
          if (result.data?.iFlag == 1) {
            return await Get.to(const ChangePasswordPage(isFirst: true))
                ?.then((value) {
              /// lấy lại mật khẩu mới
              if (value is String) {
                state.passwordTextController.text = value;

                /// đăng nhập lại
                signIn();
              }
            });
          }
          await storeService.addUser(UserStock(
              name: result.data!.name!,
              userID: result.data!.user!,
              category: []));
          await Get.offAllNamed(RouteConfig.main);
        } else {
          signIn();
        }
      } on ErrorException catch (error) {
        AppSnackBar.showError(message: error.message);
      } on Exception {
        signIn();
      }
    }
    AppLoading.disMissLoading();
  }
}
