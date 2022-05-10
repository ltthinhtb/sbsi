part of 'api_service.dart';

extension IndexService on ApiService {
  Future<List<IndexDetail>> getListIndexDetail(String list) async {
    return await _apiClient.getListIndexDetail(list);
  }

  Future<String> getListStockCode(String market) async {
    return await _apiClient.getListStockCode(market);
  }

  Future<List<StockDataShort>> getTopStock(int type) async {
    return await _apiClient.getTopStock(type);
  }

  Future<BranchResponse> getStockBranch() async {
    return await _apiClient.getStockBranch();
  }

  Future<List<StockBranch>> getDetailStockBranch() async {
    return await _apiClient.getDetailStockBranch();
  }

  Future<List<MarketDepth>> getMarketDepth() async {
    return await _apiClient.getMarketDepth();
  }

  Future<IndexChartResponse> getChartIndex(String code) async {
    return await _apiClient.getChartIndex(code);
  }
}
