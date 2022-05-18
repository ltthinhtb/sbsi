import 'package:get/get.dart';
import 'package:sbsi/model/entities/economy.dart';
import 'package:sbsi/model/stock_data/stock_info.dart';
import 'package:sbsi/model/stock_data/stock_trade_list.dart';
import 'package:sbsi/ui/pages/stock_detail/enums/stock_detail_tab.dart';
import '../../../model/response/stock_report.dart';
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

  final stockTimeLine = StockTimeline.day.obs;

  final listEconomyRowH = <EconomyRow>[].obs;
  final listEconomyRowD = <EconomyRow>[].obs;

  final headList = <Head>[].obs;
  final contentList = <Content>[].obs;

  final tern = Tern.quarterly.obs;

  final listIncomeState = <ReportState>[].obs;

  StockDetailState(this.stockCode) {}
}
