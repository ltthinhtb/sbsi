import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/ui/pages/market/market_logic.dart';
import 'package:sbsi/utils/money_utils.dart';

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
                flex:50,
                child: Text(
                  trade.sTOCKCODE ?? "",
                  style: caption?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Expanded(
                flex: 93,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    MoneyFormat.formatMoneyRound('${trade.kLGD}'),
                    style: caption?.copyWith(),
                  ),
                ),
              ),
              Expanded(
                flex: 88,
                child: Align(
                  alignment: Alignment.centerRight,

                  child: Text(
                    trade.pRICE?.toStringAsFixed(2) ?? "",
                    style: caption?.copyWith(
                      color: trade.color
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 90,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    trade.cHANGE?.toStringAsFixed(2) ?? "",
                    style: caption?.copyWith(
                        color: trade.color
                    ),
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
