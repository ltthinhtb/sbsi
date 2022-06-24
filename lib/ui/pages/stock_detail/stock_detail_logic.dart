import 'package:get/get.dart';
import 'package:sbsi/networks/error_exception.dart';
import 'package:sbsi/ui/pages/stock_detail/enums/stock_detail_tab.dart';
import '../../../model/params/data_params.dart';
import '../../../model/params/request_params.dart';
import '../../../services/api/api_service.dart';
import '../../../services/auth_service.dart';
import '../../../services/store/store_service.dart';
import '../../commons/app_snackbar.dart';
import '../../commons/hoziontal_chart.dart';
import 'stock_detail_state.dart';

class StockDetailLogic extends GetxController {
  final StockDetailState state = StockDetailState(Get.arguments as String);

  final ApiService apiService = Get.find();
  final AuthService authService = Get.find();

  @override
  void onReady() {
    getAllStockCompanyData();
    getListStockTrade();
    getListStockCollection();
    getListStockNews();
    getListEconomyRow();
    getStockReport();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// lấy thông tin list mã chứng khoán đã lưu vào db, danh sách mã chứng khoán thường cố định
  getAllStockCompanyData() {
    try {
      state.allStockCompanyData = Get.find<StoreService>().listStockCompany;
      if (state.allStockCompanyData.isNotEmpty) {
        initData();
      }
    } catch (e) {
      getAllStockCompanyData();
    }
  }

  Future initData() async {
    state.selectedStock.value = state.allStockCompanyData.firstWhere(
        (element) =>
            element.stockCode?.trim().toLowerCase() ==
            state.stockCode.trim().toLowerCase());
    await getStockInfo();
  }

  Future<void> getStockInfo() async {
    var _tokenEntity = authService.token.value;
    try {
      final RequestParams _requestParams = RequestParams(
        group: "Q",
        session: _tokenEntity?.data?.sid,
        user: _tokenEntity?.data?.user,
        data: ParamsObject(
          type: "string",
          cmd: "Web.sStockInfo",
          p1: _tokenEntity?.data?.defaultAcc,
          p2: state.selectedStock.value.stockCode,
        ),
      );
      state.selectedStockInfo.value =
          await apiService.getStockInfo(_requestParams);
      var list  = await apiService.getStockData(state.selectedStock.value.stockCode ?? "");
      if(list.isNotEmpty){
        state.stockData.value = list.first;
      }
    } on ErrorException catch (e) {
      AppSnackBar.showError(message: e.message);
    } catch (error) {
      AppSnackBar.showError(message: error.toString());
    }
  }

  Future<void> getListStockTrade() async {
    try {
      var response = await apiService.getListStockTrade(
          state.stockCode, "listLsStockTrade");
      state.listStockTrade.value = response.data!;
    } on ErrorException catch (e) {
      AppSnackBar.showError(message: e.message);
    } catch (error) {
      AppSnackBar.showError(message: error.toString());
    }
  }

  Future<void> getListStockCollection() async {
    try {
      var response = await apiService.getListStockTrade(
          state.stockCode, "collectionPrice");
      state.listStockCollection.value = response.data!;
    } on ErrorException catch (e) {
      AppSnackBar.showError(message: e.message);
    } catch (error) {
      AppSnackBar.showError(message: error.toString());
    }
  }

  Future<void> getListStockNews() async {
    try {
      var response = await apiService.getListStockNews(state.stockCode);
      state.listStockNews.value = response;
    } on ErrorException catch (e) {
      AppSnackBar.showError(message: e.message);
    } catch (error) {
      AppSnackBar.showError(message: error.toString());
    }
  }

  /// phân tích
  Future<void> getListEconomyRow() async {
    try {
      state.listEconomyRowH.value = await apiService.getListEconomyRow(
          state.stockCode, StockTimeline.hour.time);

      state.listEconomyRowD.value = await apiService.getListEconomyRow(
          state.stockCode, StockTimeline.day.time);
    } on ErrorException catch (e) {
      AppSnackBar.showError(message: e.message);
    } catch (error) {
      AppSnackBar.showError(message: error.toString());
    }
  }

  /// tài chính
  Future<void> getStockReport() async {
    try {
      var response = await apiService.getStockReport(
          state.stockCode, state.tern.value.value);
      state.contentList.value = response.content ?? [];
      state.headList.value = response.head ?? [];
      state.listIncomeState.clear();
      state.contentList.forEach((e) {
        if (e.reportNormID == 45) {
          state.listIncomeState.add(ReportState("ROE", e.reportNormID!));
        } else if (e.reportNormID == 47) {
          state.listIncomeState.add(ReportState("ROA", e.reportNormID!));
        } else if (e.reportNormID == 31) {
          state.listIncomeState.add(ReportState("GP", e.reportNormID!));
        } else if (e.reportNormID == 41) {
          state.listIncomeState.add(ReportState("GPM", e.reportNormID!));
        }
      });
    } on ErrorException catch (e) {
      AppSnackBar.showError(message: e.message);
    } catch (error) {
      AppSnackBar.showError(message: error.toString());
    }
  }

  /// convert dữ liệu sang dạng chart
  num maxVol = 0;

  List<ChartData> listChart() {
    List<ChartData> list = [];
    for (int i = 0;
        i <
            (state.listStockCollection.length > 15
                ? 15
                : state.listStockCollection.length);
        i++) {
      if (maxVol < state.listStockCollection[i].lASTVOL! / 1000)
        maxVol = state.listStockCollection[i].lASTVOL! / 1000;
      list.add(ChartData(
          (state.listStockCollection[i].lASTVOL! / 1000).toString(),
          state.listStockCollection[i].lASTPRICE!,
          state.listStockCollection[i].cOLOR!));
    }
    return list;
  }
}
