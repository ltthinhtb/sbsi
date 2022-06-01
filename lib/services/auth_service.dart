import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sbsi/database/secure_storage_helper.dart';
import 'package:sbsi/model/entities/index.dart';
import 'package:get/get.dart';
import 'package:sbsi/model/response/list_account_response.dart';
import 'package:sbsi/services/api/api_service.dart';
import 'package:sbsi/ui/pages/sign_in/sign_in_logic.dart';
import 'package:sbsi/utils/logger.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:shared_preferences/shared_preferences.dart';
import '../generated/l10n.dart';
import '../model/params/data_params.dart';
import '../model/params/request_params.dart';
import '../networks/error_exception.dart';
import '../ui/commons/app_snackbar.dart';

class AuthService extends GetxService {
  static const String IS_BIOMETRICS_SAVE = 'isBiometricsSave';
  Rxn<TokenEntity> token = Rxn<TokenEntity>();

  var listAccount = <Account>[];

  bool isBiometricsSave = false;

  final LocalAuthentication auth = LocalAuthentication();
  late bool canAuthenticateWithBiometrics;
  late bool canAuthenticate;
  late SharedPreferences prefs;

  Future<AuthService> init() async {
    await getToken();
    canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    logger.i("có thể đăng nhập bằng face/vân tay: ${canAuthenticate}");
    prefs = await SharedPreferences.getInstance();
    isBiometricsSave = prefs.getBool(IS_BIOMETRICS_SAVE) ?? false;
    return this;
  }

  // thay đổi trạng thái lưu vân tay khuôn mặt
  Future<void> changeIsBiometricsSave(bool _isBiometricsSave) async {
    isBiometricsSave = _isBiometricsSave;
    await prefs.setBool(IS_BIOMETRICS_SAVE, _isBiometricsSave);
  }

  Future<void> authenticate() async {
    try {
      // chưa đăng ký vân tay
      if (!canAuthenticate) {
        return AppSnackBar.showError(
            message: S.current.you_not_register);
      }
      if (!isBiometricsSave) {
        return AppSnackBar.showError(
            message: S.current.your_account_not_register);
      }
      bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Please authenticate to show account balance',
          options: const AuthenticationOptions(
              useErrorDialogs: true, stickyAuth: true, biometricOnly: true));
      // đăng nhập khuôn mặt vân tay thất bại
      if (!didAuthenticate) throw ErrorException(400, S.current.faceID_login_fail);
      // đăng nhập khuôn mặt vân tay thành công
      Get.find<SignInLogic>().signIn(isBiometrics: true);
    } on PlatformException catch (e) {
      if (e.code == auth_error.notEnrolled) {
        // Add handling of no hardware here.
      } else if (e.code == auth_error.lockedOut ||
          e.code == auth_error.permanentlyLockedOut) {
        AppSnackBar.showError(message: e.message);
      } else {
        logger.e(e.toString());
      }
    } on ErrorException catch (error) {
      AppSnackBar.showError(message: error.message);
    } catch (e) {
      logger.e(e.toString());
    }
  }

  // lấy thông tin tk gồm tài khoản thường và tài khoản margin
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
      var response =
          await Get.find<ApiService>().getListAccount(_requestParams);
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
