import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import '../../../widgets/animation_widget/price_row.dart';
import '../../../widgets/animation_widget/total_volumn_row.dart';
import '../stock_order_logic.dart';

class Stock3Price extends StatelessWidget {
  const Stock3Price({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<StockOrderLogic>().state;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        color: AppColors.white,
          boxShadow: [
            const BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                blurRadius: 4
            ),
            const BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                blurRadius: 20
            )
          ]
      ),
      child: Column(
        children: [
          Obx(
            () => Container(
              child: TotalVolumnPercentRow(
                padding: 20,
                sum: state.sumBSVol.value,
                buyValue: state.sumBuyVol.value,
                sellValue: state.sumSellVol.value,
              ),
            ),
          ),
          Obx(
            () => Container(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        PricePercentRow(
                          isBuy: true,
                          sum: state.sumBuyVol.value,
                          price: state.selectedStockInfo.value.g1?.price ?? "0.0",
                          value: state.selectedStockInfo.value.g1?.volumn
                                  ?.toDouble() ??
                              0,
                        ),
                        PricePercentRow(
                          sum: state.sumBuyVol.value,
                          price: state.selectedStockInfo.value.g2?.price ?? "0.0",
                          value: state.selectedStockInfo.value.g2?.volumn
                                  ?.toDouble() ??
                              0,
                        ),
                        PricePercentRow(
                          sum: state.sumBuyVol.value,
                          price: state.selectedStockInfo.value.g3?.price ?? "0.0",
                          value: state.selectedStockInfo.value.g3?.volumn
                                  ?.toDouble() ??
                              0,
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 5,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        PricePercentRow(
                          isBuy: false,
                          sum: state.sumSellVol.value,
                          price: state.selectedStockInfo.value.g4?.price ?? "0.0",
                          value: state.selectedStockInfo.value.g4?.volumn
                                  ?.toDouble() ??
                              0,
                        ),
                        PricePercentRow(
                          isBuy: false,
                          sum: state.sumSellVol.value,
                          price: state.selectedStockInfo.value.g5?.price ?? "0.0",
                          value: state.selectedStockInfo.value.g5?.volumn
                                  ?.toDouble() ??
                              0,
                        ),
                        PricePercentRow(
                          isBuy: false,
                          sum: state.sumSellVol.value,
                          price: state.selectedStockInfo.value.g6?.price ?? "0.0",
                          value: state.selectedStockInfo.value.g6?.volumn
                                  ?.toDouble() ??
                              0,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
