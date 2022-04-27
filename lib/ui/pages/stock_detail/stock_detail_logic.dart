import 'package:get/get.dart';
import '../../../model/params/data_params.dart';
import '../../../model/params/request_params.dart';
import '../../../services/api/api_service.dart';
import '../../../services/auth_service.dart';
import '../../../services/store/store_service.dart';
import '../../commons/app_snackbar.dart';
import 'stock_detail_state.dart';

class StockDetailLogic extends GetxController {
  final StockDetailState state = StockDetailState(Get.arguments as String);

  final ApiService apiService = Get.find();
  final AuthService authService = Get.find();

  @override
  void onReady() {
    getAllStockCompanyData();
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
    state.selectedStock.value = state.allStockCompanyData
        .firstWhere((element) => element.stockCode?.trim().toLowerCase() == state.stockCode.trim().toLowerCase());
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
          p2: state.stockCode,
        ),
      );
      state.selectedStockInfo.value =
          await apiService.getStockInfo(_requestParams);
    } catch (error) {
      AppSnackBar.showError(message: error.toString());
    }
  }
}
