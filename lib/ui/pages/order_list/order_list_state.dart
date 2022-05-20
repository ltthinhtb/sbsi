import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/model/entities/order_history.dart';
import 'package:sbsi/model/order_data/inday_order.dart';

import '../../../model/response/list_account_response.dart';
import 'enums/order_enums.dart';

class OrderListState {
  late TextEditingController stockCodeController;

  late TextEditingController stockHistoryController;

  var selectedListOrder = <IndayOrder>[].obs;

  var listOrder = <IndayOrder>[].obs;

  final listOrderHistory = <OrderHistory>[].obs;

  SingingCharacter singingCharacter = SingingCharacter.all;

  inOrderHisTabs singingCharacterHistory = inOrderHisTabs.all;

  final account = Account().obs;

  final isSelectAll = false.obs;

  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  OrderListState() {
    stockCodeController = TextEditingController();
    stockHistoryController = TextEditingController();
  }
}
