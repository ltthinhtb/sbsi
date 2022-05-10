import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/ui/pages/market/market_logic.dart';
import 'package:sbsi/ui/pages/market/widget/market_area.dart';

class BranchStockView extends StatelessWidget {
  BranchStockView({Key? key}) : super(key: key);
  final state = Get.find<MarketLogic>().state;
  final logic = Get.find<MarketLogic>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: MarketAreaView(),
    );
  }
}
