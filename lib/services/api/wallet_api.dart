part of 'api_service.dart';

extension WaletService on ApiService {
  Future<AccountInfo> getAccountInfo(RequestParams requestParams) async {
    return await _apiClient.getAccountInfo(requestParams);
  }

  Future<AccountStatus?> getAccountStatus(RequestParams requestParams) async {
    return await _apiClient.getAccountStatus(requestParams);
  }

  Future<PortfolioAccountStatus?> getPortfolioAccountStatus(
      RequestParams requestParams) async {
    return await _apiClient.getPortfolioAccountStatus(requestParams);
  }

  Future<Portfolio?> getPortfolio(RequestParams requestParams) async {
    return await _apiClient.getPortfolio(requestParams);
  }
}
