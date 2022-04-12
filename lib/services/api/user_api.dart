part of 'api_service.dart';

extension UserApiService on ApiService {
  Future<List<Account>?> getListAccount(RequestParams requestParams) async {
    return await _apiClient.getListAccount(requestParams);
  }

  Future<void> changePassword(RequestParams requestParams) async {
    return await _apiClient.changePassword(requestParams);
  }

  Future sendToken(Map<String, dynamic> json) async {
    return await _apiClient.sendToken(json);
  }
}
