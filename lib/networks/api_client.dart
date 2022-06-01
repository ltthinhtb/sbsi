import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' as get_x;
import 'package:sbsi/configs/app_configs.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/model/entities/advance_withdraw.dart';
import 'package:sbsi/model/entities/cash_account.dart';
import 'package:sbsi/model/entities/economy.dart';
import 'package:sbsi/model/entities/fee_withdraw.dart';
import 'package:sbsi/model/entities/index.dart';
import 'package:sbsi/model/entities/right_exc.dart';
import 'package:sbsi/model/entities/share_transfer.dart';
import 'package:sbsi/model/order_data/inday_order.dart';
import 'package:sbsi/model/params/index.dart';
import 'package:sbsi/model/response/account_info.dart';
import 'package:sbsi/model/response/account_status.dart';
import 'package:sbsi/model/response/index_detail.dart';
import 'package:sbsi/model/response/list_account_response.dart';
import 'package:sbsi/model/response/portfolio.dart';
import 'package:sbsi/model/response/stocke_response.dart';
import 'package:sbsi/model/stock_company_data/stock_company_data.dart';
import 'package:sbsi/model/stock_data/cash_balance.dart';
import 'package:sbsi/model/stock_data/list_news_stock.dart';
import 'package:sbsi/model/stock_data/news_detail.dart';
import 'package:sbsi/model/stock_data/share_balance.dart';
import 'package:sbsi/model/stock_data/stock_data.dart';
import 'package:sbsi/model/stock_data/stock_info.dart';
import 'package:sbsi/model/stock_data/stock_trade_list.dart';
import 'package:sbsi/router/route_config.dart';
import 'package:sbsi/ui/commons/app_dialog.dart';
import 'package:sbsi/ui/commons/app_loading.dart';
import 'package:sbsi/utils/error_message.dart';

import '../model/entities/bank.dart';
import '../model/entities/beneficiary_account.dart';
import '../model/entities/cash_can_adv.dart';
import '../model/entities/order_history.dart';
import '../model/entities/share_transaction.dart';
import '../model/entities/share_transfer_history.dart';
import '../model/entities/transfer_history.dart';
import '../model/response/branch_response.dart';
import '../model/response/index_chart.dart';
import '../model/response/market_depth_response.dart';
import '../model/response/stock_follow_branch_response.dart';
import '../model/response/stock_report.dart';
import '../model/response/totalAssets.dart';
import '../model/response/transaction_new.dart';
import '../ui/pages/sign_up/enum/enums.dart';
import 'error_exception.dart';

abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  Future<TokenEntity> authLogin(RequestParams requestParams);

  //Info
  Future<AccountInfo> getAccountInfo(RequestParams requestParams);

  //Asset
  Future<AccountStatus> getAccountStatus(RequestParams requestParams);

  Future<AccountMStatus> getAccountMStatus(RequestParams requestParams);

  Future<List<Account>?> getListAccount(RequestParams requestParams);

  Future<Portfolio> getPortfolio(RequestParams requestParams);

  //Stock Data
  Future<List<StockCompanyData>> getAllStockCompanyData();

  Future<StockInfo> getStockInfo(RequestParams requestParams);

  Future<List<StockData>> getStockData(String stockCode);

  Future<CashBalance> getCashBalance(RequestParams requestParams);

  Future<ShareBalance> getShareBalance(RequestParams requestParams);

  Future newOrderRequest(RequestParams requestParams);

  Future<void> cancleOrder(RequestParams requestParams);

  Future<void> changeOrder(RequestParams requestParams);

  Future<List<IndayOrder>> getIndayOrder(RequestParams requestParams);

  //home
  Future<List<IndexDetail>> getListIndexDetail(String listIndex);

  Future<String> getListStockCode(String market);

  Future<void> changePassword(RequestParams requestParams);

  Future sendToken(Map<String, dynamic> json);

  Future<List<StockDataShort>> getTopStock(int type);

  Future<ListStockTrade> getListStockTrade(String stock, String type);

  Future<List<NewsStock>> getListStockNews(String stock);

  Future<NewsDetail> getNewsDetail(int ID);

  Future<BranchResponse> getStockBranch();

  Future<List<StockBranch>> getDetailStockBranch();

  Future<List<MarketDepth>> getMarketDepth();

  Future<IndexChartResponse> getChartIndex(String indexCode);

  Future<CashAccount> getCashAccount(RequestParams requestParams);

  Future<List<Bank>> getLisBank(RequestParams requestParams);

  Future<List<Bank>> getLisBankSignUp(RequestParams requestParams);

  Future<List<BeneficiaryAccount>> getListBeneficiaryAccount(
      RequestParams requestParams);

  Future updateCashTransferOnline(RequestParams requestParams);

  Future checkPin(RequestParams requestParams);

  Future<List<HistoryTransfer>> getTransfersHistory(
      RequestParams requestParams);

  Future<List<EconomyRow>> getListEconomyRow(String stock, String timeLine);

  Future<ReportStockResponse> getStockReport(String stock, String ternType);

  Future<List<OrderHistory>> getListOrder(RequestParams requestParams);

  Future<TransactionNew> getListTransactionNew(RequestParams requestParams);

  Future<List<ShareTransaction>> getListShareTransaction(
      RequestParams requestParams);

  Future<TotalAssets> getTotalAssets(RequestParams requestParams);

  Future<String> getSaleID(RequestParams requestParams);

  Future checkAccount(RequestParams requestParams);

  Future uploadMultipleFile(List<EKYCImage> data);

  Future<ShareTransfer> getShareTransfer(RequestParams requestParams);

  Future<List<ShareTransferHistory>> getListShareTransfer(
      RequestParams requestParams);

  Future updateShareTransferIn(RequestParams requestParams);

  Future<List<RightExc>> getListRightExc(RequestParams requestParams);

  Future<List<CashCanAdv>> getListCashCanAdv(RequestParams requestParams);

  Future<FeeAdvanceWithdraw> getFeeAdvanceWithdraw(RequestParams requestParams);

  Future<List<AdvanceWithdraw>> getListAdvanceWithdraw(
      RequestParams requestParams);
}

class _ApiClient implements ApiClient {
  _ApiClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://vftrade.vn/';
  }

  final Dio _dio;

  String? baseUrl;

  Future<Response> _requestApi(Future<Response> request) async {
    try {
      var response = await request;

      var _mapData = _decodeMap(response.data!);

      var _rc = _mapData['rc'] ?? -999;
      var _rs = _mapData['rs'] ?? "FOException.InvalidSessionException";

      /// kiểm tra điều kiện thành công
      if (_rc == 1 || _rc == "1") {
        return response;
      }

      ///kiểm tra điều kiện logOut
      else if (_rc == -1 && _rs.toString().contains("FOException")) {
        await AppDiaLog.showNoticeDialog(
                middleText: "Phiên làm việc đã hết hạn")
            .then((value) async {
          await get_x.Get.offAllNamed(RouteConfig.login);
        });

        throw ErrorException(response.statusCode!, _mapData['rs']);
      } else {
        throw ErrorException(
            response.statusCode!, _mapData['rs'] ?? _mapData['sRs']);
      }
    } catch (error) {
      throw _handleError(error);
    }
  }

  Future<Response> _requestSignApi(Future<Response> request) async {
    try {
      var response = await request;

      var _mapData = _decodeMap(response.data!);

      var _rc = _mapData['iRs'] ?? -999;

      /// kiểm tra điều kiện thành công
      if (_rc == 1 || _rc == "1") {
        return response;
      } else {
        throw ErrorException(response.statusCode!, _mapData['sRs']);
      }
    } catch (error) {
      throw _handleError(error);
    }
  }

  Future<Response> _requestOrderApi(Future<Response> request) async {
    try {
      var response = await request;

      var _mapData = jsonDecode(response.data!);
      var _rc = _mapData['rc'] ?? -999;
      var _rs = _mapData['rs'] ?? "FOException.InvalidSessionException";

      /// kiểm tra điều kiện thành công
      if (_rc > 0) {
        return response;
      }

      ///kiểm tra điều kiện logOut
      else if (_rc == -1 && _rs == "FOException.InvalidSessionException") {
        AppLoading.disMissLoading();
        await AppDiaLog.showNoticeDialog(
                middleText: "Phiên làm việc đã hết hạn")
            .then((value) async {
          await get_x.Get.offAllNamed(RouteConfig.login);
        });
        throw ErrorException(response.statusCode!, _mapData['rs']);
      } else {
        throw ErrorException(response.statusCode!, _handleOrderError(_rc));
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<Response> _getApi(Future<Response> request) async {
    try {
      var response = await request;
      return response;
    } catch (error) {
      throw _handleError(error);
    }
  }

  ErrorException _handleError(dynamic error) {
    /// xử lý exception
    ErrorException exception = ErrorException(500, "");
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.sendTimeout:
          return exception..message = error.message;
        case DioErrorType.cancel:
          return exception..message = error.message;
        case DioErrorType.connectTimeout:
          return exception..message = error.message;
        case DioErrorType.other:
          return exception..message = S.current.network_error;
        case DioErrorType.receiveTimeout:
          return exception..message = error.message;
        case DioErrorType.response:
          exception.statusCode = error.response!.statusCode ?? 500;
          exception.message = error.response!.data;
          break;
        default:
          exception.message = error.response!.data;
      }
    } else if (error is ErrorException) {
      return error;
    } else {
      exception.message = S.current.error;
    }
    return exception;
  }

  String _handleOrderError(int error) {
    /// xử lý exception
    String exception = MessageOrder.mapError(error.toString());
    return exception;
  }

  Map<String, dynamic> _decodeMap(dynamic value) {
    if (value.runtimeType == String) {
      Map<String, dynamic> valueMap = json.decode(value);
      return valueMap;
    } else {
      return value;
    }
  }

  @override
  Future<TokenEntity> authLogin(RequestParams requestParams) async {
    Response _result = await _requestApi(
      _dio.post(
        AppConfigs.ENDPOINT_CORE,
        data: requestParams.toJson(),
      ),
    );
    var _mapData = _decodeMap(_result.data!);
    // var _result = await http.post(
    //   Uri.parse(baseUrl! + AppConfigs.ENDPOINT_CORE),
    //   body: requestParams.toJson(),
    // );
    // var res = jsonDecode(const Utf8Codec().decode(_result.bodyBytes));
    final value = TokenEntity.fromJson(_mapData);
    return value;
  }

  @override
  Future<AccountInfo> getAccountInfo(RequestParams requestParams) async {
    try {
      Response _result = await _requestApi(
          _dio.post(AppConfigs.ENDPOINT_CORE, data: requestParams.toJson()));
      var _mapData = _decodeMap(_result.data!);
      final value = AccountInfo.fromJson(_mapData['data'][0]);
      return value;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> changePassword(RequestParams requestParams) async {
    try {
      await _requestApi(
          _dio.post(AppConfigs.ENDPOINT_CORE, data: requestParams.toJson()));
      return;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AccountStatus> getAccountStatus(RequestParams requestParams) async {
    Response _result = await _requestApi(
        _dio.post(AppConfigs.ENDPOINT_CORE, data: requestParams.toJson()));
    var _mapData = _decodeMap(_result.data!);
    final value = AccountStatus.fromJson(_mapData);
    return value;
  }

  @override
  Future<AccountMStatus> getAccountMStatus(RequestParams requestParams) async {
    Response _result = await _requestApi(
        _dio.post(AppConfigs.ENDPOINT_CORE, data: requestParams.toJson()));
    var _mapData = _decodeMap(_result.data!);
    final value = AccountMStatus.fromJson(_mapData['data']);
    return value;
  }

  @override
  Future<List<Account>?> getListAccount(RequestParams requestParams) async {
    Response _result = await _requestApi(
        _dio.post(AppConfigs.ENDPOINT_CORE, data: requestParams.toJson()));

    var _mapData = _decodeMap(_result.data!);
    final value = ListAccountResponse.fromJson(_mapData);
    return value.data;
  }

  @override
  Future<Portfolio> getPortfolio(RequestParams requestParams) async {
    Response _result = await _requestApi(
        _dio.post(AppConfigs.ENDPOINT_CORE, data: requestParams.toJson()));
    var _mapData = _decodeMap(_result.data!);
    final value = Portfolio.fromJson(_mapData);
    return value;
  }

  @override
  Future<List<StockCompanyData>> getAllStockCompanyData() async {
    try {
      Response _result =
          await _getApi(_dio.get(AppConfigs.URL_DATA_FEED + "getlistallstock"));
      final value = _result.data
          .map<StockCompanyData>((e) => StockCompanyData.fromJson(e))
          .toList();
      return value;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<StockInfo> getStockInfo(RequestParams requestParams) async {
    try {
      Response _result = await _requestApi(
        _dio.post(
          AppConfigs.ENDPOINT_CORE,
          data: requestParams.toJson(),
        ),
      );
      var _mapData = _decodeMap(_result.data);
      final _value = StockInfo.fromJson(_mapData['data']);
      return _value;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CashBalance> getCashBalance(RequestParams requestParams) async {
    try {
      Response _result = await _requestApi(
        _dio.post(
          AppConfigs.ENDPOINT_CORE,
          data: requestParams.toJson(),
        ),
      );
      var _mapData = _decodeMap(_result.data);
      final _value = CashBalance.fromJson(_mapData['data']);
      return _value;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ShareBalance> getShareBalance(RequestParams requestParams) async {
    try {
      Response _result = await _requestApi(
        _dio.post(
          AppConfigs.ENDPOINT_CORE,
          data: requestParams.toJson(),
        ),
      );
      var _mapData = _decodeMap(_result.data);
      final _value = ShareBalance.fromJson(_mapData['data']);
      return _value;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future newOrderRequest(RequestParams requestParams) async {
    try {
      var response = await _requestOrderApi(
        _dio.post(AppConfigs.ENDPOINT_CORE, data: requestParams.toJson()),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> cancleOrder(RequestParams requestParams) async {
    try {
      await _requestOrderApi(
        _dio.post(
          AppConfigs.ENDPOINT_CORE,
          data: requestParams.toJson(),
        ),
      );
      return;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> changeOrder(RequestParams requestParams) async {
    try {
      await _requestOrderApi(
        _dio.post(
          AppConfigs.ENDPOINT_CORE,
          data: requestParams.toJson(),
        ),
      );
      return;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<IndayOrder>> getIndayOrder(RequestParams requestParams) async {
    try {
      Response _result = await _requestApi(_dio.post(
        AppConfigs.ENDPOINT_CORE,
        data: requestParams.toJson(),
      ));
      List<dynamic> _listDataDynamic = _decodeMap(_result.data!)['data'];
      List<IndayOrder> _listData =
          _listDataDynamic.map((e) => IndayOrder.fromJson(e)).toList();
      return _listData;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<StockData>> getStockData(String stockCode) async {
    try {
      Response _result = await _getApi(
          _dio.get(AppConfigs.URL_DATA_FEED + "getliststockdata/$stockCode"));
      List _mapData = _result.data;
      List<StockData> listStock = [];
      for (var element in _mapData) {
        listStock.add(StockData.fromJson(element));
      }
      return listStock;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<IndexDetail>> getListIndexDetail(String listIndex) async {
    Response _result = await _getApi(
        _dio.get(AppConfigs.URL_DATA_FEED + 'getlistindexdetail/' + listIndex));
    List _mapData = _result.data;
    List<IndexDetail> listStock = [];
    for (var element in _mapData) {
      listStock.add(IndexDetail.fromJson(element));
    }
    return listStock;
  }

  @override
  Future<String> getListStockCode(String market) async {
    Response _result = await _getApi(_dio.get(
      AppConfigs.INFO_SBSI + 'list30.pt',
      queryParameters: {"market": market},
    ));
    var _mapData = _result.data;
    return _mapData['list'];
  }

  @override
  Future sendToken(Map<String, dynamic> json) async {
    Response _result = await _getApi(_dio
        .post(AppConfigs.NOTIFICATION + 'monitor/deviceManage', data: json));
    var _mapData = _result.data;
    return _mapData;
  }

  @override
  Future<List<StockDataShort>> getTopStock(int type) async {
    try {
      var path = "";
      if (type == 0)
        path =
            "${AppConfigs.INFO_SBSI}topStockInterested?count=10&type=&catId=";
      else if (type == 1)
        path = "${AppConfigs.INFO_SBSI}topStockChange?count=10&type=i&catId=";
      else if (type == 2)
        path = "${AppConfigs.INFO_SBSI}topStockChange?count=10&type=d&catId=";
      else
        path = "${AppConfigs.INFO_SBSI}topStockTrade?count=10&type=i&catId=";
      Response _result = await _getApi(_dio.get(path));
      final value = StockResponse.fromJson(_result.data);
      return value.data ?? [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ListStockTrade> getListStockTrade(String stock, String type) async {
    Response _result = await _getApi(
        _dio.get(AppConfigs.INFO_SBSI + type, queryParameters: {"sc": stock}));
    var data = ListStockTrade.fromJson(_result.data);
    return data;
  }

  @override
  Future<List<NewsStock>> getListStockNews(String stock) async {
    Response _result = await _getApi(_dio.get(
        AppConfigs.INFO_SBSI + 'stockNews.pt',
        queryParameters: {"symbol": stock}));
    List _mapData = _result.data;
    List<NewsStock> listStock = [];
    for (var element in _mapData) {
      listStock.add(NewsStock.fromJson(element));
    }
    return listStock;
  }

  @override
  Future<NewsDetail> getNewsDetail(int ID) async {
    Response _result = await _getApi(_dio.get(
        AppConfigs.INFO_SBSI + "newsDetail.pt",
        queryParameters: {"id": ID}));
    var data = NewsDetail.fromJson(_result.data);
    return data;
  }

  @override
  Future<BranchResponse> getStockBranch() async {
    Response _result =
        await _getApi(_dio.get(AppConfigs.INFO_SBSI + "listIndustry"));
    return BranchResponse.fromJson(_result.data);
  }

  @override
  Future<List<StockBranch>> getDetailStockBranch() async {
    Response _result = await _getApi(
        _dio.get(AppConfigs.INFO_SBSI + "listIndustryHeatMap?top=10"));
    if (_result.data is String)
      return StockBranchResponse.fromJson(json.decode(_result.data)).stockData;
    else
      return StockBranchResponse.fromJson(_result.data).stockData;
  }

  @override
  Future<List<MarketDepth>> getMarketDepth() async {
    String path = AppConfigs.INFO_SBSI + 'marketDepth';
    Response _result = await _getApi(_dio.get(path));
    List<MarketDepth> value =
        _result.data.map<MarketDepth>((e) => MarketDepth.fromJson(e)).toList();
    return value;
  }

  @override
  Future<IndexChartResponse> getChartIndex(String indexCode) async {
    Response _result = await _getApi(
        _dio.get(AppConfigs.URL_DATA_FEED + 'getchartindexdata/' + indexCode));
    return IndexChartResponse.fromJson(_result.data);
  }

  @override
  Future<CashAccount> getCashAccount(RequestParams requestParams) async {
    Response _result = await _requestApi(
      _dio.post(
        AppConfigs.ENDPOINT_CORE,
        data: requestParams.toJson(),
      ),
    );
    List _mapData = jsonDecode(_result.data)['data'];
    return CashAccount.fromJson(_mapData.first);
  }

  @override
  Future<List<Bank>> getLisBank(RequestParams requestParams) async {
    Response _result = await _requestApi(
      _dio.post(
        AppConfigs.ENDPOINT_CORE,
        data: requestParams.toJson(),
      ),
    );
    List _mapData = jsonDecode(_result.data)['data'];
    List<Bank> listBank = [];
    for (var element in _mapData) {
      listBank.add(Bank.fromJson(element));
    }
    return listBank;
  }

  @override
  Future<List<BeneficiaryAccount>> getListBeneficiaryAccount(
      RequestParams requestParams) async {
    Response _result = await _requestApi(
      _dio.post(
        AppConfigs.ENDPOINT_CORE,
        data: requestParams.toJson(),
      ),
    );
    List _mapData = jsonDecode(_result.data)['data'];
    List<BeneficiaryAccount> listBeneficiary = [];
    for (var element in _mapData) {
      listBeneficiary.add(BeneficiaryAccount.fromJson(element));
    }
    return listBeneficiary;
  }

  @override
  Future updateCashTransferOnline(RequestParams requestParams) async {
    await _requestApi(
      _dio.post(
        AppConfigs.ENDPOINT_CORE,
        data: requestParams.toJson(),
      ),
    );
  }

  @override
  Future checkPin(RequestParams requestParams) async {
    await _requestApi(
      _dio.post(
        AppConfigs.ENDPOINT_CORE,
        data: requestParams.toJson(),
      ),
    );
  }

  @override
  Future<List<HistoryTransfer>> getTransfersHistory(
      RequestParams requestParams) async {
    Response _result = await _requestApi(
      _dio.post(
        AppConfigs.ENDPOINT_CORE,
        data: requestParams.toJson(),
      ),
    );
    List _mapData = jsonDecode(_result.data)['data'];
    List<HistoryTransfer> listHistory = [];
    for (var element in _mapData) {
      listHistory.add(HistoryTransfer.fromJson(element));
    }
    return listHistory;
  }

  @override
  Future<List<EconomyRow>> getListEconomyRow(
      String stock, String timeLine) async {
    String path = AppConfigs.INFO_SBSI + 'ptkt';
    Response _result = await _getApi(_dio.get(path,
        queryParameters: {"symbol": stock, "period": "1${timeLine}"}));
    List _mapData = json.decode(_result.data);
    List<EconomyRow> listEconomy = [];
    for (var element in _mapData) {
      listEconomy.add(EconomyRow.fromJson(element));
    }
    return listEconomy;
  }

  @override
  Future<ReportStockResponse> getStockReport(
      String stock, String ternType) async {
    String path = AppConfigs.INFO_SBSI + 'stockReport.pt';
    Response _result = await _getApi(_dio.get(path, queryParameters: {
      "symbol": stock,
      "termtype": "${ternType}",
      "type": "CSTC",
      "from": "1",
      "to": "6",
    }));
    var data = (_result.data);
    return ReportStockResponse.fromJson(data);
  }

  @override
  Future<List<OrderHistory>> getListOrder(RequestParams requestParams) async {
    Response _result = await _requestApi(
      _dio.post(
        AppConfigs.ENDPOINT_CORE,
        data: requestParams.toJson(),
      ),
    );
    List _mapData = jsonDecode(_result.data)['data'];
    List<OrderHistory> listHistory = [];
    for (var element in _mapData) {
      listHistory.add(OrderHistory.fromJson(element));
    }
    return listHistory;
  }

  @override
  Future<TransactionNew> getListTransactionNew(
      RequestParams requestParams) async {
    Response _result = await _requestApi(
      _dio.post(
        AppConfigs.ENDPOINT_CORE,
        data: requestParams.toJson(),
      ),
    );
    List _mapData = jsonDecode(_result.data)['data'];
    return TransactionNew.fromJson(_mapData.first);
  }

  @override
  Future<List<ShareTransaction>> getListShareTransaction(
      RequestParams requestParams) async {
    Response _result = await _requestApi(
      _dio.post(
        AppConfigs.ENDPOINT_CORE,
        data: requestParams.toJson(),
      ),
    );
    List _mapData = jsonDecode(_result.data)['data'];
    List data2 = _mapData.first['data2'];
    List<ShareTransaction> listShare = [];
    for (var element in data2) {
      listShare.add(ShareTransaction.fromJson(element));
    }
    return listShare;
  }

  @override
  Future<TotalAssets> getTotalAssets(RequestParams requestParams) async {
    Response _result = await _requestApi(
      _dio.post(
        AppConfigs.ENDPOINT_CORE,
        data: requestParams.toJson(),
      ),
    );
    return TotalAssets.fromJson((_result.data)['data']);
  }

  @override
  Future<List<Bank>> getLisBankSignUp(RequestParams requestParams) async {
    Response _result = await _requestSignApi(
      _dio.post(
        AppConfigs.SIGN_UP_URL + "core",
        data: requestParams.toJson(),
      ),
    );
    List _mapData = (_result.data)['data'];
    final String responseLocal =
        await rootBundle.loadString('assets/json/bank.json');
    final dataLocal = await json.decode(responseLocal);
    List<Bank> listBank = [];
    _mapData.forEach((element) {
      var bank = Bank.fromJson(element);
      if (dataLocal != null) {
        dataLocal['data'].forEach((v) {
          if (v['bin'].toString() == bank.cBANKKEY) {
            bank = bank.copyWith(cBANKNAME: v['name']);
          }
        });
      }
      listBank.add(bank);
    });
    return listBank;
  }

  @override
  Future<String> getSaleID(RequestParams requestParams) async {
    Response _result = await _requestSignApi(
      _dio.post(
        AppConfigs.SIGN_UP_URL + "core",
        data: requestParams.toJson(),
      ),
    );
    List _mapData = (_result.data)['data'];
    return _mapData.first['SALE_NAME'];
  }

  @override
  Future checkAccount(RequestParams requestParams) async {
    Response _result = await _requestSignApi(
      _dio.post(
        AppConfigs.SIGN_UP_URL + "core",
        data: requestParams.toJson(),
      ),
    );
    List _mapData = (_result.data)['data'];
    return _mapData.first;
  }

  @override
  Future uploadMultipleFile(List<EKYCImage> data) async {
    var formData = FormData();
    for (var file in data) {
      formData.files.addAll([
        MapEntry(
            file.ekycImage.value,
            MultipartFile.fromBytes(file.bytes,
                filename: file.ekycImage.value)),
      ]);
    }
    Response _result =
        await _dio.post(AppConfigs.SIGN_UP_URL + '/uploadFile', data: formData);
    return _result.data['data'];
  }

  @override
  Future<ShareTransfer> getShareTransfer(RequestParams requestParams) async {
    Response _result = await _requestApi(
      _dio.post(
        AppConfigs.ENDPOINT_CORE,
        data: requestParams.toJson(),
      ),
    );
    var map = jsonDecode(_result.data);
    return ShareTransfer.fromJson(map['data']);
  }

  @override
  Future updateShareTransferIn(RequestParams requestParams) async {
    await _requestApi(
      _dio.post(
        AppConfigs.ENDPOINT_CORE,
        data: requestParams.toJson(),
      ),
    );
  }

  @override
  Future<List<ShareTransferHistory>> getListShareTransfer(
      RequestParams requestParams) async {
    Response _result = await _requestApi(
      _dio.post(
        AppConfigs.ENDPOINT_CORE,
        data: requestParams.toJson(),
      ),
    );
    List _mapData = jsonDecode(_result.data)['data'];
    List<ShareTransferHistory> listShareHistory = [];
    for (var element in _mapData) {
      listShareHistory.add(ShareTransferHistory.fromJson(element));
    }
    return listShareHistory;
  }

  @override
  Future<List<RightExc>> getListRightExc(RequestParams requestParams) async {
    Response _result = await _requestApi(
      _dio.post(
        AppConfigs.ENDPOINT_CORE,
        data: requestParams.toJson(),
      ),
    );
    List _mapData = jsonDecode(_result.data)['data'];
    List<RightExc> listRight = [];
    for (var element in _mapData) {
      listRight.add(RightExc.fromJson(element));
    }
    return listRight;
  }

  @override
  Future<List<CashCanAdv>> getListCashCanAdv(
      RequestParams requestParams) async {
    Response _result = await _requestApi(
      _dio.post(
        AppConfigs.ENDPOINT_CORE,
        data: requestParams.toJson(),
      ),
    );
    List _mapData = jsonDecode(_result.data)['data'];
    List<CashCanAdv> listCashCan = [];
    for (var element in _mapData) {
      listCashCan.add(CashCanAdv.fromJson(element));
    }
    return listCashCan;
  }

  @override
  Future<FeeAdvanceWithdraw> getFeeAdvanceWithdraw(
      RequestParams requestParams) async {
    Response _result = await _requestApi(
      _dio.post(
        AppConfigs.ENDPOINT_CORE,
        data: requestParams.toJson(),
      ),
    );
    List _mapData = jsonDecode(_result.data)['data'];
    List<FeeAdvanceWithdraw> listCashCan = [];
    for (var element in _mapData) {
      listCashCan.add(FeeAdvanceWithdraw.fromJson(element));
    }
    return listCashCan.first;
  }

  @override
  Future<List<AdvanceWithdraw>> getListAdvanceWithdraw(
      RequestParams requestParams) async {
    Response _result = await _requestApi(
      _dio.post(
        AppConfigs.ENDPOINT_CORE,
        data: requestParams.toJson(),
      ),
    );
    List _mapData = jsonDecode(_result.data)['data'];
    List<AdvanceWithdraw> listAdvance = [];
    for (var element in _mapData) {
      listAdvance.add(AdvanceWithdraw.fromJson(element));
    }
    return listAdvance;
  }
}
