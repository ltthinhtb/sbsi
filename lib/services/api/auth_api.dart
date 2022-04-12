part of 'api_service.dart';

extension AuthApiService on ApiService {
  Future<TokenEntity?> signIn(RequestParams requestParams) async {
    return await _apiClient.authLogin(requestParams);
  }
}
