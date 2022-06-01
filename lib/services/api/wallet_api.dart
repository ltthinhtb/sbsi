part of 'api_service.dart';

extension WaletService on ApiService {
  Future<AccountInfo> getAccountInfo(RequestParams requestParams) async {
    return await _apiClient.getAccountInfo(requestParams);
  }

  Future<GetAccountInfo> loadAccountInfo(RequestParams requestParams) async {
    return await _apiClient.loadAccountInfo(requestParams);
  }
  Future<TotalAssets> getTotalAssets(RequestParams requestParams) async {
    return await _apiClient.getTotalAssets(requestParams);
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

  Future<List<HistoryTransfer>> getTransfersHistory(RequestParams requestParams) async {
    return await _apiClient.getTransfersHistory(requestParams);
  }

  Future<List<OrderHistory>> getListOrder(RequestParams requestParams) async {
    return await _apiClient.getListOrder(requestParams);
  }

  Future<TransactionNew> getListTransactionNew(RequestParams requestParams) async {
    return await _apiClient.getListTransactionNew(requestParams);
  }

  Future<List<ShareTransaction>> getListShareTransaction(RequestParams requestParams) async {
    return await _apiClient.getListShareTransaction(requestParams);
  }

}
