import 'package:sbsi/database/secure_storage_helper.dart';
import 'package:sbsi/model/entities/index.dart';
import 'package:get/get.dart';
import 'package:sbsi/model/response/list_account_response.dart';
import 'package:sbsi/services/api/api_service.dart';
import 'package:sbsi/utils/logger.dart';

import '../model/params/data_params.dart';
import '../model/params/request_params.dart';
import '../networks/error_exception.dart';
import '../ui/commons/app_snackbar.dart';

class AuthService extends GetxService {
  Rxn<TokenEntity> token = Rxn<TokenEntity>();

  var listAccount = <Account>[];

  Future<AuthService> init() async {
    await getToken();
    return this;
  }

  Future<void> getListAccount() async {
    ParamsObject _object = ParamsObject();
    _object.type = "cursor";
    _object.cmd = "ListAccount";
    final RequestParams _requestParams = RequestParams(group: "B");
    var _tokenEntity = token.value!;
    _requestParams.user = _tokenEntity.data?.user;
    _requestParams.session = _tokenEntity.data?.sid;
    _requestParams.data = _object;
    try {
      var response = await Get.find<ApiService>().getListAccount(_requestParams);
      if (response!.isNotEmpty) {
        listAccount = response;
      }
    } on ErrorException catch (error) {
      AppSnackBar.showError(message: error.message);
    }
  }

  /// Handle save/remove Token
  void saveToken(TokenEntity tokenEntity) {
    try {
      token.value = tokenEntity;
      return SecureStorageHelper.getInstance().saveToken(tokenEntity);
    } catch (e) {
      logger.e(e.toString());
      throw Exception();
    }
  }

  Future<TokenEntity?> getToken() async {
    try {
      final currentToken = await SecureStorageHelper.getInstance().getToken();
      token.value = currentToken;
      return token.value;
    } catch (e) {
      return null;
    }
  }

  void removeToken() {
    token.value = null;
    return SecureStorageHelper.getInstance().removeToken();
  }

  /// SignOut
  void signOut() async {
    removeToken();
  }
}