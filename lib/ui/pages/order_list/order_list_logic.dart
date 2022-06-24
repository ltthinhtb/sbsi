import 'dart:async';
import 'package:get/get.dart';
import 'package:sbsi/model/entities/confirm_history_order.dart';
import 'package:sbsi/model/entities/order_history.dart';
import 'package:sbsi/model/order_data/inday_order.dart';
import 'package:sbsi/model/params/data_params.dart';
import 'package:sbsi/model/params/index.dart';
import 'package:sbsi/networks/error_exception.dart';
import 'package:sbsi/services/index.dart';
import 'package:sbsi/ui/commons/app_snackbar.dart';
import 'package:sbsi/ui/pages/order_list/enums/order_enums.dart';
import 'package:sbsi/ui/pages/order_list/order_list_state.dart';
import 'package:sbsi/utils/error_message.dart';

import '../../../generated/l10n.dart';
import '../../../model/entities/confirm_order.dart';
import '../../../utils/logger.dart';
import '../../../utils/order_utils.dart';

class OrderListLogic extends GetxController {
  final OrderListState state = OrderListState();
  final ApiService apiService = Get.find();
  final AuthService authService = Get.find();

  // load list order
  void getOrderList() async {
    var _tokenEntity = authService.token.value;
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
          p4: state.singingCharacter.value),
    );
    try {
      state.listOrder.value = await apiService.getIndayOrder(_requestParams);
    } catch (e) {
      print(e);
    }
  }

  // load lịch sử lệnh
  void getOrderListHistory() async {
    var _tokenEntity = authService.token.value;
    final RequestParams _requestParams = RequestParams(
      group: "B",
      session: _tokenEntity?.data?.sid,
      user: _tokenEntity?.data?.user,
      data: ParamsObject(
          type: "cursor",
          cmd: "ListOrder",
          p7: "1",
          p8: "30",
          p1: state.account.value.accCode,
          p3: state.startDateController.text,
          p4: state.endDateController.text,
          p5: state.singingCharacterHistory.value,
          p2: ""),
    );
    try {
      state.listOrderHistory.value =
          await apiService.getListOrder(_requestParams);
    } catch (e) {
      print(e);
    }
  }

  // load lịch sử lệnh xác nhận lệnh
  void getConfirmOrderListHistory() async {
    var _tokenEntity = authService.token.value;
    final RequestParams _requestParams = RequestParams(
      group: "B",
      session: _tokenEntity?.data?.sid,
      user: _tokenEntity?.data?.user,
      data: ParamsObject(
          type: "cursor",
          cmd: "ListOrderConfirmHistory",
          p6: "1",
          p7: "30",
          p1: state.account.value.accCode,
          p3: state.startDateController2.text,
          p4: state.endDateController2.text,
          p5: state.cmd1.value,
          p2: ""),
    );
    try {
      state.listOrderConfirmHistory.value =
          await apiService.getListCOrderConfirmHistory(_requestParams);
    } catch (e) {
      print(e);
    }
  }

  // load list order confirm
  void getListOrderConfirm() async {
    var _tokenEntity = authService.token.value;
    final RequestParams _requestParams = RequestParams(
      group: "B",
      session: _tokenEntity?.data?.sid,
      user: _tokenEntity?.data?.user,
      data: ParamsObject(
          type: "cursor",
          cmd: "ListOrderConfirm",
          p1: state.account.value.accCode,
          p2: "",
          p3: state.startDateController1.text,
          p4: state.endDateController1.text,
          p5: state.cmd.value,
          p6: "1",
          p7: "30"),
    );
    try {
      state.listOrderConfirm.value =
          await apiService.getListOrderConfirm(_requestParams);
    } catch (e) {
      print(e);
    }
  }

  // filter theo trạng thái lệnh
  void changeOrderListStatus(SingingCharacter character) {
    state.singingCharacter = character;
    getOrderList();
  }

  // filter history lịch sử lệnh
  void changeOrderHistoryListStatus(inOrderHisTabs character) {
    state.singingCharacterHistory = character;
    getOrderListHistory();
  }

  // filter theo trạng thái lệnh
  void changeOrderConfirmListStatus(OderCmd cmd) {
    state.cmd = cmd;
    getListOrderConfirm();
  }

  // filter history lịch sử lệnh
  void changeOrderHistoryListStatusHistory(OderCmd cmd) {
    state.cmd1 = cmd;
    getConfirmOrderListHistory();
  }

  // hủy lệnh
  Future<void> cancelOrder(IndayOrder order, String pin,
      {bool showDialog = true}) async {
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
      getOrderList();
      Get.back(); // back dialog

      // trường hợp cancel all thì k show dialog
      if (showDialog) {
        AppSnackBar.showSuccess(message: S.current.cancel_order_success);
      }
    } on ErrorException catch (e) {
      if (showDialog) {
        AppSnackBar.showError(message: e.message);
      }
    } catch (e) {
      logger.e(e.toString());
    }
  }

  // xác nhận lệnh
  Future<void> confirmOrder(OrderConfirm order, String pin,
      {bool showDialog = true}) async {
    var _tokenEntity = authService.token.value;
    RequestParams _requestParams = RequestParams(
      group: "B",
      session: _tokenEntity?.data?.sid,
      user: _tokenEntity?.data?.user,
      data: ParamsObject(
        type: "string",
        cmd: "UpdateOrderConfirm",
        p1: order.pKORDER ?? "",
        p3: pin,
      ),
    );
    try {
      await apiService.cancleOrder(_requestParams);
      getOrderList();
      Get.back(); // back dialog

      // trường hợp cancel all thì k show dialog
      if (showDialog) {
        AppSnackBar.showSuccess(message: S.current.cancel_order_success);
      }
    } on ErrorException catch (e) {
      if (showDialog) {
        AppSnackBar.showError(message: e.message);
      }
    } catch (e) {
      logger.e(e.toString());
    }
  }

  Future<void> cancelAll(String pin) async {
    try {
      await Future.wait(state.selectedListOrder
          .map((element) => cancelOrder(element, pin, showDialog: false))
          .toList());
      getOrderList();
      Get.back(); // back dialog
      AppSnackBar.showSuccess(message: S.current.cancel_order_success);
      state.isSelectAll.value = false;
    } on ErrorException catch (e) {
      AppSnackBar.showError(message: e.message);
    } catch (e) {
      logger.e(e.toString());
    }
  }

  // select all or Clear
  void selectAll({bool? isSelect}) {
    // có thể bằng biến giá trị param truyền vào
    state.isSelectAll.value = isSelect ?? (!state.isSelectAll.value);
    state.selectedListOrder.clear();
    // nếu key là select all
    if (state.isSelectAll.value) {
      // check order canedit to add list
      state.listOrder.forEach((element) {
        if (MessageOrder.canEdit(element)) {
          state.selectedListOrder.add(element);
        }
      });
    }
  }

  Future<void> cancelAllOrderConfirm(String pin) async {
    try {
      await Future.wait(state.selectedListConfirmOrder
          .map((element) => confirmOrder(element, pin, showDialog: false))
          .toList());
      getListOrderConfirm();
      Get.back(); // back dialog
      AppSnackBar.showSuccess(message: S.current.confirm_order_success);
      state.isSelectAllConfirmOrder.value = false;
    } on ErrorException catch (e) {
      AppSnackBar.showError(message: e.message);
    } catch (e) {
      logger.e(e.toString());
    }
  }

  // select all or Clear
  void selectAllConfirm({bool? isSelect}) {
    // có thể bằng biến giá trị param truyền vào
    state.isSelectAllConfirmOrder.value =
        isSelect ?? (!state.isSelectAllConfirmOrder.value);
    state.selectedListConfirmOrder.clear();
    // nếu key là select all
    if (state.isSelectAllConfirmOrder.value) {
      // check order canedit to add list
      state.listOrderConfirm.forEach((element) {
        state.selectedListConfirmOrder.add(element);
      });
    }
  }

  // add order to list select
  void addSelectOrder(IndayOrder order) {
    state.selectedListOrder.add(order);
  }

  // remove order to list select
  void removeSelectOrder(IndayOrder order) {
    state.selectedListOrder.remove(order);
  }

  // add order to list select
  void addSelectOrderConfirm(OrderConfirm order) {
    state.selectedListConfirmOrder.add(order);
  }

  // remove order to list select
  void removeSelectConfirm(OrderConfirm order) {
    state.selectedListConfirmOrder.remove(order);
  }

  // load tài khoản mặc định
  void loadAccount() {
    var _tokenEntity = authService.token.value;
    var index = authService.listAccount.indexWhere(
        (element) => _tokenEntity?.data?.defaultAcc == element.accCode);
    if (index >= 0) {
      state.account.value = authService.listAccount[index];
    }
  }

  // switch tài khoản 1-6
  void changeAccount() {
    var index = authService.listAccount.indexWhere(
        (element) => state.account.value.accCode != element.accCode);
    if (index >= 0) {
      state.account.value = authService.listAccount[index];
      getOrderList();
      getOrderListHistory();
      getListOrderConfirm();
      getConfirmOrderListHistory();
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
    loadAccount();
    getOrderList();
    getOrderListHistory();
    getListOrderConfirm();
    getConfirmOrderListHistory();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onClose() {
    super.onClose();
  }

  List<String> searchStockString(String stockCode) {
    List<IndayOrder> searchResult = state.listOrder
        .where(
          (element) => element.symbol!.toLowerCase().startsWith(
                stockCode.toLowerCase(),
              ),
        )
        .toList();
    return searchResult
        .map((e) {
          return e.symbol ?? "";
        })
        .toSet()
        .toList();
  }

  List<IndayOrder> searchStock(String stockCode) {
    List<IndayOrder> searchResult = state.listOrder
        .where(
          (element) => element.symbol!.toLowerCase().startsWith(
                stockCode.toLowerCase(),
              ),
        )
        .toList();
    return searchResult;
  }

  List<String> searchStockHistoryString(String stockCode) {
    List<OrderHistory> searchResult = state.listOrderHistory
        .where(
          (element) => element.cSHARECODE!.toLowerCase().startsWith(
                stockCode.toLowerCase(),
              ),
        )
        .toList();
    return searchResult
        .map((e) {
          return e.cSHARECODE ?? "";
        })
        .toSet()
        .toList();
  }

  List<OrderHistory> searchStockHistory(String stockCode) {
    List<OrderHistory> searchResult = state.listOrderHistory
        .where(
          (element) => element.cSHARECODE!.toLowerCase().startsWith(
                stockCode.toLowerCase(),
              ),
        )
        .toList();
    return searchResult;
  }

  List<String> searchStockConfirmString(String stockCode) {
    List<OrderConfirm> searchResult = state.listOrderConfirm
        .where(
          (element) => element.cSHARECODE!.toLowerCase().startsWith(
                stockCode.toLowerCase(),
              ),
        )
        .toList();
    return searchResult
        .map((e) {
          return e.cSHARECODE ?? "";
        })
        .toSet()
        .toList();
  }

  List<OrderConfirm> searchStockConfirm(String stockCode) {
    List<OrderConfirm> searchResult = state.listOrderConfirm
        .where(
          (element) => element.cSHARECODE!.toLowerCase().startsWith(
                stockCode.toLowerCase(),
              ),
        )
        .toList();
    return searchResult;
  }

  List<String> searchStockConfirmHistoryString(String stockCode) {
    List<OrderConfirmHistory> searchResult = state.listOrderConfirmHistory
        .where(
          (element) => element.cSHARECODE!.toLowerCase().startsWith(
                stockCode.toLowerCase(),
              ),
        )
        .toList();
    return searchResult
        .map((e) {
          return e.cSHARECODE ?? "";
        })
        .toSet()
        .toList();
  }

  List<OrderConfirmHistory> searchStockConfirmHistory(String stockCode) {
    List<OrderConfirmHistory> searchResult = state.listOrderConfirmHistory
        .where(
          (element) => element.cSHARECODE!.toLowerCase().startsWith(
                stockCode.toLowerCase(),
              ),
        )
        .toList();
    return searchResult;
  }
}
