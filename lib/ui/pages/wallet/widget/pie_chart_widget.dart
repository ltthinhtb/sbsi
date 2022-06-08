import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../wallet_logic.dart';

class PieChartWidget extends StatefulWidget {
  const PieChartWidget({Key? key}) : super(key: key);

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  int touchedIndex = -1;

  final state = Get.find<WalletLogic>().state;

  // chứng khoán
  num get market_value {
    if (state.account.value.lastCharacter == "6") {
      return state.assets.value.lmvNum;
    }
    return state.portfolioTotal.value.marketPriceValue;
  }

  // nợ
  num get debt {
    if (state.account.value.lastCharacter == "6") {
      return state.assets.value.debtNum;
    }
    return 0;
  }

  // tiền
  num get money {
    if (state.account.value.lastCharacter == "6") {
      return state.assets.value.withdrawalCashNum;
    }
    return state.assets.value.withdrawalCashNum;
  }

  num get sum {
    return market_value + debt + money;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final body2 = Theme.of(context).textTheme.bodyText2;
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 171,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: AppColors.PastelCard,
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Expanded(
              child: PieChart(PieChartData(
                  pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  }),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 25,
                  sections: showingSections())),
            ),
            const SizedBox(width: 21),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                          color: AppColors.blue,
                          borderRadius: BorderRadius.circular(1)),
                    ),
                    const SizedBox(width: 7.72),
                    Text(
                      '${S.of(context).money}:',
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(),
                    ),
                    const SizedBox(
                      width: 2.28,
                    ),
                    Text(
                      '${((money / sum) * 100).toStringAsFixed(0)}%',
                      style: body2?.copyWith(fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                          color: AppColors.yellowStatus,
                          borderRadius: BorderRadius.circular(1)),
                    ),
                    const SizedBox(width: 7.72),
                    Text(
                      '${S.of(context).stock}:',
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(),
                    ),
                    const SizedBox(
                      width: 2.28,
                    ),
                    Text(
                      '${((market_value / sum) * 100).toStringAsFixed(0)}%',
                      style: body2?.copyWith(fontWeight: FontWeight.w700),
                    )
                  ],
                ),

                Visibility(
                  visible: state.account.value.lastCharacter == "6",
                  child: Padding(
                    padding: const EdgeInsets.only(top: 18),
                    child: Row(
                      children: [
                        Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                              color: AppColors.deActive,
                              borderRadius: BorderRadius.circular(1)),
                        ),
                        const SizedBox(width: 7.72),
                        Text(
                          '${S.of(context).debt}:',
                          style: Theme.of(context).textTheme.bodyText2?.copyWith(),
                        ),
                        const SizedBox(
                          width: 2.28,
                        ),
                        Text(
                          '${((debt / sum) * 100).toStringAsFixed(0)}%',
                          style: body2?.copyWith(fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
      );
    });
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 45.0 : 40.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppColors.yellowStatus,
            value: market_value.toDouble(),
            title: '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: AppColors.blue,
            value: money.toDouble(),
            title: '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: AppColors.red,
            value: debt.toDouble(),
            title: '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }
}
