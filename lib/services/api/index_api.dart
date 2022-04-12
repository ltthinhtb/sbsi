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
}
