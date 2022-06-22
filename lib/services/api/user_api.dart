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

  Future<List<AppBanner>> getBanner() async {
    return await _apiClient.loadBanner();
  }

  Future<List<AppNotification>> loadListNotificationAll() async {
    return await _apiClient.loadListNotificationAll();
  }

  Future forgotPass(ForgotPassRequest request) async {
    return await _apiClient.forgotPass(request);
  }

  Future<List<Notify>> getListNotify(NotifyRequest request) async {
    return await _apiClient.getListNotify(request);
  }

  Future<void> makerReader(NotifyRequest request) async {
    return await _apiClient.makerRead(request);
  }

  Future getOtp(RequestParams requestParams) async {
    return await _apiClient.getOtp(requestParams);
  }

  Future checkOtp(String phone,String otp) async {
    return await _apiClient.checkOtp(phone,otp);
  }
}
