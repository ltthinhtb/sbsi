import 'dart:async';
import 'package:get/get.dart';
import 'package:sbsi/model/order_data/change_order_data.dart';
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
          p4: state.singingCharacter
              .value(stockCode: state.stockCodeController.text.trim())),
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
      getOrderList();
      Get.back(); // back dialog
      AppSnackBar.showSuccess(message: S.current.cancel_order_success);
    } on ErrorException catch (e) {
      AppSnackBar.showError(message: e.message);
    } catch (e) {
      logger.e(e.toString());
    }
  }

  // select all or Clear
  void selectAll() {
    state.isSelectAll.value = !state.isSelectAll.value;
    state.selectedListOrder.clear();
    if (state.isSelectAll.value) {
      // check order canedit to add list
      state.listOrder.forEach((element) {
        if (MessageOrder.canEdit(element)) {
          state.selectedListOrder.add(element);
        }
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

  // load tài khoản mặc định
  void loadAccount() {
    var _tokenEntity = authService.token.value;
    var index = authService.listAccount.indexWhere(
        (element) => _tokenEntity?.data?.defaultAcc == element.accCode);
    if (index >= 0) {
      state.account.value = authService.listAccount[index];
    }
  }

  // sửa lệnh
  Future<void> changeOrder(IndayOrder data, ChangeOrderData changeData) async {
    var _tokenEntity = authService.token.value;
    RequestParams _requestParams = RequestParams(
      group: "O",
      session: _tokenEntity?.data?.sid,
      user: _tokenEntity?.data?.user,
      data: ParamsObject(
        type: "string",
        cmd: "Web.changeOrder",
        orderNo: data.orderNo,
        nvol: int.tryParse(changeData.vol) ?? 0,
        nprice: changeData.price,
        fisID: "",
        orderType: "1",
        pin: "",
      ),
    );
    try {
      await apiService.changeOrder(_requestParams);
    } catch (e) {
      rethrow;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    loadAccount();
    getOrderList();
    getOrderListHistory();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onClose() {
    super.onClose();
  }

  List<IndayOrder> searchStock(String stockCode) {
    if (stockCode != '') {
      List<IndayOrder> searchResult = state.listOrder
          .where(
            (element) => element.symbol!.toLowerCase().startsWith(
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
}
