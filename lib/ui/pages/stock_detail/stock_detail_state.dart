import 'package:get/get.dart';
import '../../../model/stock_company_data/stock_company_data.dart';
import '../../../model/stock_data/stock_info.dart';

class StockDetailState {
  final String stockCode;

  var selectedStockInfo = StockInfo().obs;

  List<StockCompanyData> allStockCompanyData = <StockCompanyData>[];
  var selectedStock = StockCompanyData().obs;

  StockDetailState(this.stockCode) {}
}
