part of 'api_service.dart';

extension WaletService on ApiService {
  Future<AccountInfo> getAccountInfo(RequestParams requestParams) async {
    return await _apiClient.getAccountInfo(requestParams);
  }

  Future<AccountStatus?> getAccountStatus(RequestParams requestParams) async {
    return await _apiClient.getAccountStatus(requestParams);
  }


  Future<Portfolio?> getPortfolio(RequestParams requestParams) async {
    return await _apiClient.getPortfolio(requestParams);
  }

  Future<CashAccount> getCashAccount(RequestParams requestParams) async {
    return await _apiClient.getCashAccount(requestParams);
  }

  Future<List<Bank>> getListBank(RequestParams requestParams) async {
    return await _apiClient.getLisBank(requestParams);
  }

  Future<List<BeneficiaryAccount>> getListBeneficiaryAccount(RequestParams requestParams) async {
    return await _apiClient.getListBeneficiaryAccount(requestParams);
  }

  Future updateCashTransferOnline(RequestParams requestParams) async {
    return await _apiClient.updateCashTransferOnline(requestParams);
  }

  Future checkPin(RequestParams requestParams) async {
    return await _apiClient.checkPin(requestParams);
  }
}
