import 'dart:async';
import 'package:get/get.dart';
import 'package:sbsi/model/order_data/change_order_data.dart';
import 'package:sbsi/model/order_data/inday_order.dart';
import 'package:sbsi/model/params/data_params.dart';
import 'package:sbsi/model/params/index.dart';
import 'package:sbsi/services/index.dart';
import 'package:sbsi/ui/pages/order_list/order_list_state.dart';
import 'package:sbsi/utils/extension.dart';

class OrderListLogic extends GetxController {
  final OrderListState state = OrderListState();
  final ApiService apiService = Get.find();
  final AuthService authService = Get.find();

  void getNewData() {
    state.newDataArrived.value = false;
    state.listOrder = state.listOrderStorage;
    return;
  }

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
          p3: _tokenEntity?.data?.defaultAcc,
          p4: "${state.symbol},${state.orderStatus},${state.orderType}"),
    );
    try {
      state.listOrder.value = await apiService.getIndayOrder(_requestParams);
    } catch (e) {
      print(e);
    }
  }

  Future<List<IndayOrder>?> checkList() async {
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
          p3: _tokenEntity?.data?.defaultAcc,
          p4: "${state.symbol},${state.orderStatus},${state.orderType}"),
    );
    try {
      var listOrders = await apiService.getIndayOrder(_requestParams);
      if (listOrders.isNotEmpty) {
        if (listOrders.length == state.listOrder.length) {
          for (var i = 0; i < listOrders.length; i++) {
            if (listOrders[i].orderNo != state.listOrder[i].orderNo) {
              return listOrders;
            }
            if (listOrders[i].status != state.listOrder[i].status) {
              return listOrders;
            }
            return null;
          }
        } else {
          return listOrders;
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> selectAll() async {
    state.selectedListOrder.clear();
    for (var item in state.listOrder) {
      if (item.canFix) {
        state.selectedListOrder.add(item);
      }
    }
  }

  Future<void> cancelOrder() async {
    var _tokenEntity = authService.token.value;
    if (state.selectedListOrder.isNotEmpty) {
      RequestParams _requestParams = RequestParams(
        group: "O",
        session: _tokenEntity?.data?.sid,
        user: _tokenEntity?.data?.user,
        data: ParamsObject(
          type: "string",
          cmd: "Web.cancelOrder",
          orderNo: "",
          fisID: "",
          orderType: "1",
          pin: "123456",
        ),
      );
      try {
        for (var item in state.selectedListOrder) {
          _requestParams.data!.orderNo = item.orderNo;
          await apiService.cancleOrder(_requestParams);
        }
      } catch (e) {
        rethrow;
      }
    }
    getOrderList();
  }

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

  bool itemIsChecked(String no) {
    if (state.selectedListOrder.any((element) => element.orderNo == no)) {
      return true;
    } else {
      return false;
    }
  }


  Future<List<IndayOrder>> filterOrder() async {
    List<IndayOrder> filtedList = state.listOrder;
    switch (state.orderType.value) {
      case "Tất cả":
        break;
      case "Mua":
        filtedList.removeWhere((element) => element.side == "S");
        break;
      case "Bán":
        filtedList.removeWhere((element) => element.side == "B");
        break;
      default:
    }
    return filtedList;
  }

  @override
  void onInit() async {
    super.onInit();
    getOrderList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
