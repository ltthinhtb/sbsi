import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/model/entities/order_history.dart';
import 'package:sbsi/model/order_data/inday_order.dart';

import '../../../model/entities/confirm_order.dart';
import '../../../model/response/list_account_response.dart';
import '../../../utils/date_utils.dart';
import 'enums/order_enums.dart';

class OrderListState {
  late TextEditingController stockCodeController;

  late TextEditingController stockHistoryController;

  late TextEditingController stockCodeConfirmController;

  var selectedListOrder = <IndayOrder>[].obs;

  var selectedListConfirmOrder = <OrderConfirm>[].obs;

  List<IndayOrder> get buyOrder {
    var list = <IndayOrder>[];
    selectedListOrder.forEach((element) {
      if (element.side == "B") list.add(element);
    });
    return list;
  }

  num get totalBuy {
    num _amount = 0;
    buyOrder.forEach((element) {
      _amount += double.parse(element.showPrice ?? "0") *
          double.parse(element.volume ?? "0") *
          1000;
    });
    return _amount;
  }

  List<IndayOrder> get sellOrder {
    var list = <IndayOrder>[];
    selectedListOrder.forEach((element) {
      if (element.side != "B") list.add(element);
    });
    return list;
  }

  num get totalSell {
    num _amount = 0;
    sellOrder.forEach((element) {
      _amount += double.parse(element.showPrice!) *
          double.parse(element.volume!) *
          1000;
    });
    return _amount;
  }

  num get totalAmount {
    num _amount = 0;
    selectedListOrder.forEach((element) {
      _amount += double.parse(element.showPrice ?? "0") *
          double.parse(element.volume ?? "0") *
          1000;
    });
    return _amount;
  }

  var listOrder = <IndayOrder>[].obs;

  final listOrderHistory = <OrderHistory>[].obs;

  var listOrderConfirm = <OrderConfirm>[].obs;

  SingingCharacter singingCharacter = SingingCharacter.all;

  inOrderHisTabs singingCharacterHistory = inOrderHisTabs.all;

  OderCmd cmd = OderCmd.all;

  final account = Account().obs;

  final isSelectAll = false.obs;

  final isSelectAllConfirmOrder = false.obs;

  final startDateController = TextEditingController(
      text: DateTimeUtils.toDateString(
          DateTime.now().subtract(const Duration(days: 90)),
          format: "dd/MM/yyyy"));
  final endDateController = TextEditingController(
      text: DateTimeUtils.toDateString(DateTime.now(), format: "dd/MM/yyyy"));

  final startDateController1 = TextEditingController(
      text: DateTimeUtils.toDateString(
          DateTime.now().subtract(const Duration(days: 90)),
          format: "dd/MM/yyyy"));
  final endDateController1 = TextEditingController(
      text: DateTimeUtils.toDateString(DateTime.now(), format: "dd/MM/yyyy"));

  OrderListState() {
    stockCodeController = TextEditingController();
    stockHistoryController = TextEditingController();
    stockCodeConfirmController = TextEditingController();
  }
}
