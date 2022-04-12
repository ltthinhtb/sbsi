import 'package:get/get.dart';
import 'package:sbsi/model/params/data_params.dart';
import 'package:sbsi/model/params/index.dart';
import 'package:sbsi/services/index.dart';
import 'package:sbsi/ui/pages/menu/panel/cust_info/cust_info_state.dart';

class CustomInfoLogic extends GetxController {
  CustomInfoState state = CustomInfoState();
  final ApiService _apiService = Get.find();
  final AuthService _authService = Get.find();


  Future<void> getCustomInfo() async {
    var _tokenEntity = _authService.token.value;
    try {
      final RequestParams _requestParams = RequestParams(
        group: "B",
        session: _tokenEntity?.data?.sid,
        user: _tokenEntity?.data?.user,
        data: ParamsObject(
          type: "object",
          cmd: "APP.GET_CURRENT_ACCOUNT",
          p: AccountCodeObject(accountCode: _tokenEntity?.data?.user),
        ),
      );
      state.accountInfo = await _apiService.getAccountInfo(_requestParams);
    } catch (e) {
      rethrow;
    }
  }

  @override
  void onInit() async {
    await getCustomInfo();
    // TODO: implement onInit
    super.onInit();
  }
}
