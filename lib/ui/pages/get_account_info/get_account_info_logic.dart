import 'package:get/get.dart';
import 'package:sbsi/services/api/api_service.dart';
import 'package:sbsi/services/auth_service.dart';

import '../../../model/params/data_params.dart';
import '../../../model/params/request_params.dart';
import '../../commons/app_snackbar.dart';
import 'get_account_info_state.dart';

class GetAccountInfoLogic extends GetxController {
  final GetAccountInfoState state = GetAccountInfoState();
  final ApiService apiService = Get.find<ApiService>();
  final AuthService authService = Get.find<AuthService>();

  @override
  void onReady() {
    getUserInfo();
    super.onReady();
  }

  Future<void> getUserInfo() async {
    try {
      var _tokenEntity = authService.token.value;
      final RequestParams _requestParams = RequestParams(
        group: "B",
        session: _tokenEntity?.data?.sid,
        user: _tokenEntity?.data?.user,
        data: ParamsObject(
          type: "cursor",
          cmd: "GetAccountInfo",
          p1: '${_tokenEntity?.data?.user}1',
        ),
      );
      state.accountInfo.value =
          await apiService.loadAccountInfo(_requestParams);
    } catch (error) {
      AppSnackBar.showError(message: error.toString());
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
