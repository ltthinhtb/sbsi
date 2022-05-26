part of 'api_service.dart';

extension SignUpApiService on ApiService {
  Future<List<Bank>> getListBankSignUp(RequestParams requestParams) async {
    return await _apiClient.getLisBankSignUp(requestParams);
  }

  Future<String> getSaleID(RequestParams requestParams) async {
    return await _apiClient.getSaleID(requestParams);
  }

  // kiểm tra số điện thoại, phone, email
  Future checkAccount(RequestParams requestParams) async {
    return await _apiClient.checkAccount(requestParams);
  }

  Future uploadMultipleFile(List<EKYCImage> data) async {
    return await _apiClient.uploadMultipleFile(data);
  }
}
