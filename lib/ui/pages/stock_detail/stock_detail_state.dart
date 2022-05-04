import 'package:get/get.dart';
import 'package:sbsi/model/stock_data/stock_info.dart';
import 'package:sbsi/model/stock_data/stock_trade_list.dart';
import '../../../model/stock_company_data/stock_company_data.dart';
import '../../../model/stock_data/list_news_stock.dart';

class StockDetailState {
  final String stockCode;

  var selectedStockInfo = StockInfo().obs;

  List<StockCompanyData> allStockCompanyData = <StockCompanyData>[];
  var selectedStock = StockCompanyData().obs;

  final listStockTrade = <StockTrade>[].obs;
  final listStockCollection = <StockTrade>[].obs;
  final listStockNews = <NewsStock>[].obs;



  StockDetailState(this.stockCode) {}
}
