import 'package:get/get.dart';
import 'package:sbsi/model/params/data_params.dart';
import 'package:sbsi/model/params/index.dart';
import 'package:sbsi/model/stock_company_data/stock_company_data.dart';
import 'package:sbsi/model/stock_data/cash_balance.dart';
import 'package:sbsi/model/stock_data/stock_info.dart';
import 'package:sbsi/networks/error_exception.dart';
import 'package:sbsi/services/index.dart';
import 'package:sbsi/services/socket/socket.dart';
import 'package:sbsi/ui/commons/app_loading.dart';
import 'package:sbsi/ui/commons/app_snackbar.dart';
import 'package:sbsi/ui/pages/stock_order/enums.dart';
import 'package:sbsi/ui/pages/stock_order/stock_order_state.dart';
import 'package:sbsi/ui/pages/stock_order/widget/stock_cash_balance.dart';
import 'package:sbsi/utils/extension.dart';
import 'package:sbsi/utils/logger.dart';
import 'package:sbsi/utils/order_utils.dart';
import '../../../generated/l10n.dart';
import '../../../model/order_data/inday_order.dart';
import '../../../model/stock_data/stock_socket.dart';

class StockOrderLogic extends GetxController {
  final StockOrderState state = StockOrderState();
  final ApiService apiService = Get.find();
  final AuthService authService = Get.find();

  final Socket _socket = Socket();

  List<StockCompanyData> searchStock(String stockCode) {
    if (stockCode != '') {
      List<StockCompanyData> searchResult = state.allStockCompanyData
          .where(
            (element) => element.stockCode!.toLowerCase().startsWith(
                  stockCode.toLowerCase(),
                ),
          )
          .toList();
      if (searchResult.length > 10) {
        searchResult = searchResult.sublist(0, 10);
      }
      return searchResult;
    } else {
      return [];
    }
  }

  // switch tài khoản 1-6
  void changeAccount() {
    var index = authService.listAccount.indexWhere(
        (element) => state.account.value.accCode != element.accCode);
    if (index >= 0) {
      state.account.value = authService.listAccount[index];
      getCashBalance();
      getOrderList();
    }
  }

  void changeTotal() {
    num price = 0;
    price = state.priceController.numberValue;
    if (state.tradingOrder.value != "LO" &&
        state.tradingOrder.value.isNotEmpty) {
      price = state.selectedStockInfo.value.c ?? 0;
    }
    state.total.value = price * state.volController.numberValue * 1000;
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

  /// chọn mã chứng khoán từ textfield
  void selectStock(StockCompanyData suggestion) {
    /// hủy kênh socket mã
    _socket.removeStockSocket(suggestion.stockCode!);

    /// đăng ký socket mã
    _socket.addStockSocket(suggestion.stockCode!);

    state.selectedStock.value = suggestion;

    /// chọn mã xong update các mã thuộc sàn đó
    StockExchange.values.forEach((element) {
      if (element.name == state.selectedStock.value.postTo) {
        state.tradingOrderList.value = element.priceList;
      }
    });
    state.stockController.text = state.selectedStock.value.stockCode ?? "";
    getStockInfo();
  }

  Future<void> getStockInfo() async {
    var _tokenEntity = authService.token.value;
    try {
      state.loading.value = true;
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
      state
        ..sumBuyVol.value = getSumBuyVol()
        ..sumSellVol.value = getSumSellVol()
        ..sumBSVol.value = getSumBSVol();
      state.priceController.clear();
      state.volController.clear();
      await getAccountStatus(_tokenEntity?.data?.defaultAcc);
      await getCashBalance();
      state.total.value = 0;
      state.loading.value = false;

      state.scrollController.jumpTo(0);
    } catch (error) {
      state.loading.value = false;
      AppSnackBar.showError(message: error.toString());
    }
  }

  void socketListen() {
    _socket.socket.on('public', (data) {
      if (data != null) {
        try {
          if (data['data']['id'] == 3220) {
            SocketStock stock = SocketStock.fromJson(data['data']);
            logger.d(stock.toJson());
            state.selectedStockInfo.value =
                state.selectedStockInfo.value.copyWith(stock);
          }
        } catch (e) {
          // logger.e(e);
        }
      }
    });
  }

  Future<void> refreshPage() async {
    try {
      var _tokenEntity = authService.token.value;
      final RequestParams _requestParams = RequestParams(
        group: "Q",
        session: _tokenEntity?.data?.sid,
        user: _tokenEntity?.data?.user,
        data: ParamsObject(
          type: "string",
          cmd: "Web.sStockInfo",
          p1: _tokenEntity?.data?.defaultAcc ?? "",
          p2: state.selectedStock.value.stockCode,
        ),
      );
      state.selectedStockInfo.value =
          await apiService.getStockInfo(_requestParams);
      state
        ..sumBuyVol.value = getSumBuyVol()
        ..sumSellVol.value = getSumSellVol()
        ..sumBSVol.value = getSumBSVol();
      await getAccountStatus(_tokenEntity?.data?.defaultAcc ?? "");
      await getCashBalance();
      await getOrderList();
    } catch (error) {
      AppSnackBar.showError(message: error.toString());
    }
  }

  Future<void> getAccountStatus(String? account) async {
    try {
      var _tokenEntity = authService.token.value;
      final RequestParams _requestParams = RequestParams(
        group: "Q",
        session: _tokenEntity?.data?.sid,
        user: _tokenEntity?.data?.user,
        data: ParamsObject(
          type: "string",
          cmd: "Web.Portfolio.AccountStatus",
          p1: account ?? _tokenEntity?.data?.defaultAcc ?? "",
        ),
      );
      state.accountStatus.value =
          await apiService.getAccountMStatus(_requestParams);
    } catch (error) {
      AppSnackBar.showError(message: error.toString());
    }
  }

  Future<void> getCashBalance() async {
    if (state.priceController.text == "0") return;
    try {
      var _tokenEntity = authService.token.value;
      final RequestParams _requestParams = RequestParams(
        group: "Q",
        session: _tokenEntity?.data?.sid,
        user: _tokenEntity?.data?.user,
        data: ParamsObject(
            type: "string",
            cmd: "Web.sCashBalance",
            p1: state.account.value.accCode ?? _tokenEntity?.data?.defaultAcc,
            p2: state.selectedStock.value.stockCode,
            p3: state.priceController.text,
            p4: state.isBuy.value ? "B" : "S"),
      );
      state.selectedCashBalance.value =
          await apiService.getCashBalance(_requestParams);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> requestNewOrder({required bool isBuy}) async {
    var _tokenEntity = authService.token.value;
    state.isBuy.value = isBuy;
    String refId =
        '${_tokenEntity?.data?.user}' + ".H." + OrderUtils.getRandom();
    String sReceiveCheckSumValue = OrderUtils.generateMd5(
        '${_tokenEntity?.data?.sid}' +
            state.priceController.text +
            (state.isBuy.value ? "B" : "S") +
            state.volController.text +
            "vpbs@456" +
            '${'${state.account.value.accCode}' + state.selectedStock.value.stockCode! + refId}');
    final RequestParams _requestParams = RequestParams(
      group: "O",
      session: _tokenEntity?.data?.sid,
      user: _tokenEntity?.data?.user,
      checksum: sReceiveCheckSumValue,
      data: ParamsObject(
        type: "string",
        cmd: "Web.newOrder",
        account: state.account.value.accCode!,
        side: (state.isBuy.value ? "B" : "S"),
        symbol: state.selectedStock.value.stockCode!,
        volume:
            int.tryParse(state.volController.numberValue.toStringAsFixed(0)),
        price: state.priceController.text,
        advance: "",
        refId: refId,
        orderType: "1",
        pin: state.pinController.text,
      ),
    );
    try {
      AppLoading.showLoading();
      var response = await apiService.newOrderRequest(_requestParams);
      logger.d(response);
      AppLoading.disMissLoading();

      /// load lại sức mua
      await getCashBalance();
      // load lại sổ lệnh
      await getOrderList();
      Get.back();
      AppSnackBar.showSuccess(message: S.current.create_order_success);
      // sau khi đặt lệnh thành công tắt thông báo

    } on ErrorException catch (error) {
      AppLoading.disMissLoading();
      AppSnackBar.showError(message: error.message);
    } catch (error) {
      AppLoading.disMissLoading();
      AppSnackBar.showError(message: error.toString());
    }
  }

  // hủy lệnh
  Future<void> cancelOrder(IndayOrder order, String pin) async {
    var _tokenEntity = authService.token.value;
    String refId =
        '${_tokenEntity?.data?.user}' + ".M." + OrderUtils.getRandom();
    RequestParams _requestParams = RequestParams(
      group: "O",
      session: _tokenEntity?.data?.sid,
      user: _tokenEntity?.data?.user,
      data: ParamsObject(
        type: "string",
        cmd: "Web.cancelOrder",
        orderNo: order.orderNo ?? "",
        fisID: "",
        refId: refId,
        orderType: "1",
        pin: pin,
      ),
    );
    try {
      await apiService.cancleOrder(_requestParams);
      await getOrderList();
      await getCashBalance();
      Get.back(); // back dialog
      AppSnackBar.showSuccess(message: S.current.cancel_order_success);
    } on ErrorException catch (e) {
      AppSnackBar.showError(message: e.message);
    } catch (e) {
      logger.e(e.toString());
    }
  }

  // sửa lệnh
  Future<void> changeOrder(
      {required IndayOrder data,
        required int vol,
        required String price,
        required String pinController}) async {
    var _tokenEntity = authService.token.value;
    RequestParams _requestParams = RequestParams(
      group: "O",
      session: _tokenEntity?.data?.sid,
      user: _tokenEntity?.data?.user,
      data: ParamsObject(
        type: "string",
        cmd: "Web.changeOrder",
        orderNo: data.orderNo,
        nvol: vol,
        nprice: price,
        fisID: "",
        orderType: "1",
        pin: pinController,
      ),
    );
    try {
      await apiService.changeOrder(_requestParams);
      getOrderList();
      Get.back(); // back dialog
      AppSnackBar.showSuccess(message: S.current.change_order_success);
      // sau 2s loại lại lệnh
      Future.delayed(const Duration(seconds: 2), () {
        getOrderList();
      });
    } on ErrorException catch (error) {
      AppSnackBar.showError(message: error.message);
    } catch (e) {
      logger.e(e.toString());
    }
  }

  @override
  void onInit() async {
    super.onInit();

    /// tạo cổng socket
    //socketListen();

    loadAccount();
    getAllStockCompanyData();
  }

  @override
  void onClose() {
    _socket.dispose();
    super.onClose();
  }

  void loadAccount() {
    var _tokenEntity = authService.token.value;
    var index = authService.listAccount.indexWhere(
        (element) => _tokenEntity?.data?.defaultAcc == element.accCode);

    if (index >= 0) {
      state.account.value = authService.listAccount[index];
      // load sổ lệnh nhanh
      getOrderList();
    }
  }

  Future initData() async {
    if (state.selectedStock.value.stockCode == null) {
      state.selectedStock.value = state.allStockCompanyData
          .firstWhere((element) => element.stockCode == "BID");
      state.stockController.text = state.selectedStock.value.stockCode ?? "";
      await getStockInfo();
    }
  }

  void cleanStock(){
    state.selectedStock.value = StockCompanyData();
    state.stockController.clear();
    state.selectedStockInfo.value = StockInfo();
    state.selectedCashBalance.value = CashBalance();
    state.priceController.clear();
    state.volController.clear();
    state.tradingOrderList.clear();
    state.tradingOrder.value = "";
  }

  Future<void> validateInfo() async {
    if (state.selectedStock.value.stockCode == null) {
      throw 0;
    }
    if (state.priceController.text.isNotIn(priceType) &&
        state.priceController.text.isNotANumber) {
      throw -1;
    }
    if (state.volController.text.isNotANumber) {
      throw -2;
    }
    if (state.volController.text.isNotPositive) {
      throw -3;
    }
    if (state.volController.text.isNotAnInteger) {
      throw -4;
    }
    // if (state.volController.text.isNotPositive ||
    //     !state.volController.text.isMultipleOfHundred ||
    //     state.volController.text.isNotAnInteger) {
    //   throw -2;
    // }
    return;
  }


  double getSumBuyVol() {
    num _sum = state.selectedStockInfo.value.g1!.volumn! +
        state.selectedStockInfo.value.g2!.volumn! +
        state.selectedStockInfo.value.g3!.volumn!;
    return _sum.toDouble();
  }

  double getSumSellVol() {
    num _sum = state.selectedStockInfo.value.g4!.volumn! +
        state.selectedStockInfo.value.g5!.volumn! +
        state.selectedStockInfo.value.g6!.volumn!;
    return _sum.toDouble();
  }

  double getSumBSVol() {
    num _sum = state.selectedStockInfo.value.g1!.volumn! +
        state.selectedStockInfo.value.g2!.volumn! +
        state.selectedStockInfo.value.g3!.volumn! +
        state.selectedStockInfo.value.g4!.volumn! +
        state.selectedStockInfo.value.g5!.volumn! +
        state.selectedStockInfo.value.g6!.volumn!;
    return _sum.toDouble();
  }

  // load list order
  Future<void> getOrderList() async {
    var _tokenEntity = authService.token.value;
    logger.w(state.stockFast.value.value);
    final RequestParams _requestParams = RequestParams(
      group: "Q",
      session: _tokenEntity?.data?.sid,
      user: _tokenEntity?.data?.user,
      data: ParamsObject(
          type: "string",
          cmd: "Web.Order.IndayOrder2",
          p1: "1",
          p2: "30",
          p3: state.account.value.accCode,
          p4: state.stockFast.value.value),
    );
    try {
      state.listOrder.value = await apiService.getIndayOrder(_requestParams);
    } catch (e) {
      print(e);
    }
  }
}

List<String> priceType = [
  "LO",
  "MP",
  "ATC",
  "ATO",
  "MTL",
  "MOK",
  "MAK",
  "PLO",
];
