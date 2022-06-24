import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/ui/pages/market/market_logic.dart';

class TopForeignTrade extends StatelessWidget {
  const TopForeignTrade({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final caption = Theme.of(context).textTheme.caption;
    return Obx(() {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var trade = Get.find<MarketLogic>().state.topForeignTrade[index];
          return Container(
            decoration: BoxDecoration(
                color: index % 2 == 0
                    ? const Color.fromRGBO(247, 247, 247, 1)
                    : AppColors.white),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  flex: 85,
                  child: Text(
                    trade.nAME ?? "",
                    style: caption?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                Expanded(
                  flex: 93,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      trade.lASTPOINT ?? "",
                      style: caption?.copyWith(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 93,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      trade.cHANGE ?? "",
                      style: caption?.copyWith(color: trade.color),
                    ),
                  ),
                ),
                Expanded(
                  flex: 90,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      trade.pERCENTCHANGE ?? "",
                      style: caption?.copyWith(color: trade.color),
                    ),
                  ),
                )
              ],
            ),
          );
        },
        itemCount: Get.find<MarketLogic>().state.topForeignTrade.length,
      );
    });
  }
}
