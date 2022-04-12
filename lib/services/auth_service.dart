import 'package:sbsi/database/secure_storage_helper.dart';
import 'package:sbsi/model/entities/index.dart';
import 'package:get/get.dart';
import 'package:sbsi/utils/logger.dart';

class AuthService extends GetxService {
  Rxn<TokenEntity> token = Rxn<TokenEntity>();

  Future<AuthService> init() async {
    await getToken();
    return this;
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
