import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/ui/commons/appbar.dart';

import '../../../common/app_images.dart';
import '../../../generated/l10n.dart';
import '../stock_order/widget/card_data.dart';
import 'stock_detail_logic.dart';

class StockDetailPage extends StatefulWidget {
  const StockDetailPage({Key? key}) : super(key: key);

  @override
  _StockDetailPageState createState() => _StockDetailPageState();
}

class _StockDetailPageState extends State<StockDetailPage> {
  final logic = Get.put(StockDetailLogic());
  final state = Get.find<StockDetailLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: S.of(context).stock_detail,
        isCenter: true,
        action: [
          GestureDetector(
              onTap: () {}, child: SvgPicture.asset(AppImages.search_normal)),
          const SizedBox(width: 20),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          Obx(() {
            var stock = state.selectedStock.value;
            var stockInfo = state.selectedStockInfo.value;
            return CardData(stock: stock, stockInfo: stockInfo);
          }),
        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<StockDetailLogic>();
    super.dispose();
  }
}
