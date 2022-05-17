part of 'api_service.dart';

extension StockOrderService on ApiService {
  Future<List<StockCompanyData>> getAllStockCompanyData() async {
    return await _apiClient.getAllStockCompanyData();
  }

  Future<AccountMStatus> getAccountMStatus(RequestParams requestParams) async {
    return await _apiClient.getAccountMStatus(requestParams);
  }

  Future<List<StockData>> getStockData(String stockCode) async {
    return await _apiClient.getStockData(stockCode);
  }

  Future<ListStockTrade> getListStockTrade(
      String stockCode, String type) async {
    return await _apiClient.getListStockTrade(stockCode, type);
  }

  Future<List<NewsStock>> getListStockNews(String stockCode) async {
    return await _apiClient.getListStockNews(stockCode);
  }

  Future<NewsDetail> getNewsDetail(int ID) async {
    return await _apiClient.getNewsDetail(ID);
  }

  Future<StockInfo> getStockInfo(RequestParams requestParams) async {
    return await _apiClient.getStockInfo(requestParams);
  }

  Future<CashBalance> getCashBalance(RequestParams requestParams) async {
    return await _apiClient.getCashBalance(requestParams);
  }

  Future<ShareBalance> getShareBalance(RequestParams requestParams) async {
    return await _apiClient.getShareBalance(requestParams);
  }

  Future newOrderRequest(RequestParams requestParams) async {
    return await _apiClient.newOrderRequest(requestParams);
  }

  Future<void> cancleOrder(RequestParams requestParams) async {
    return await _apiClient.cancleOrder(requestParams);
  }

  Future<void> changeOrder(RequestParams requestParams) async {
    return await _apiClient.changeOrder(requestParams);
  }

  Future<List<IndayOrder>> getIndayOrder(RequestParams requestParams) async {
    return await _apiClient.getIndayOrder(requestParams);
  }

  Future<List<EconomyRow>> getListEconomyRow(String stock, String timeLine) async {
    return await _apiClient.getListEconomyRow(stock, timeLine);
  }
}
