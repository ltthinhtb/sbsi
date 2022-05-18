import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/model/order_data/inday_order.dart';

import '../../../model/response/list_account_response.dart';
import 'enums/order_enums.dart';

class OrderListState {
  late TextEditingController stockCodeController;

  var selectedListOrder = <IndayOrder>[].obs;

  var listOrder = <IndayOrder>[].obs;

  SingingCharacter singingCharacter = SingingCharacter.all;

  final account = Account().obs;

  final isSelectAll = false.obs;

  OrderListState() {
    stockCodeController = TextEditingController();
  }
}
