import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_text_styles.dart';
import 'package:sbsi/model/response/index_chart.dart';
import 'package:sbsi/model/response/index_detail.dart';
import 'package:sbsi/ui/pages/home/home_logic.dart';
import 'package:sbsi/ui/widgets/chart/custom_chart.dart';

import '../../enum/vnIndex.dart';

class StockExchangesView extends StatelessWidget {
  const StockExchangesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<HomeLogic>().state;
    final body2 = Theme.of(context).textTheme.bodyText2;

    return SizedBox(
      height: 120,
      child: Obx(() {
        if (state.listIndexDetail.isEmpty) return const SizedBox();
        return ListView.separated(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              var element = state.listIndexDetail[index];
              return Container(
                width: 128,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    boxShadow: [
                      const BoxShadow(
                          blurRadius: 20,
                          color: Color.fromRGBO(0, 0, 0, 0.05),
                          offset: Offset(0, 4)),
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 128,
                      margin: const EdgeInsets.only(left: 8),
                      child: Text(
                        state.listIndexDetail[index].stockCode?.value ?? "",
                        style: body2?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      // width: MediaQuery.of(context).size.width,
                    ),
                    const SizedBox(height: 4),
                    Container(
                        height: 31,
                        margin: const EdgeInsets.only(left: 8, right: 8),
                        child: ChartIndexPoint(
                          index: element,
                        )),
                    const SizedBox(height: 8),
                    Container(
                        margin: const EdgeInsets.only(left: 8, right: 8),
                        child: Row(children: [
                          Text('${element.cIndex}',
                              style: AppTextStyle.H7Regular.copyWith(
                                  color: state.listIndexDetail[index].color)),
                          const Spacer(),
                          Text('(${element.percent})',
                              style: AppTextStyle.H7Regular.copyWith(
                                  color: state.listIndexDetail[index].color))
                        ])),
                    const SizedBox(height: 8),
                    Container(
                        margin: const EdgeInsets.only(left: 8, right: 8),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Container(
                              height: 2,
                              width: 102 * element.pCountDown,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                color: AppColors.decrease,
                              )),
                          const Spacer(),
                          Container(
                              height: 2,
                              width: 102 * element.pCountCeiling,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                color: AppColors.yellow,
                              )),
                          const Spacer(),
                          Container(
                              height: 2,
                              width: 102 * element.pCountUp,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                color: AppColors.increase,
                              )),
                        ])),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(width: 10);
            },
            itemCount: state.listIndexDetail.length);
      }),
    );
  }
}

extension StockCodeExt1 on Index {
  String? get name => _mapName[this] ?? "";

  String get code => _mapCode[this] ?? "";

  Map<Index, String> get _mapName => {
        Index.vn: 'VN-Index',
        Index.vn30: 'VN30-Index',
        Index.hnx: 'HNX-Index',
        Index.upCom: 'UPCOM-Index',
      };

  Map<Index, String> get _mapCode => {
        Index.vn: '10',
        Index.vn30: '11',
        Index.hnx: '02',
        Index.upCom: '03',
      };
}

class ChartIndexPoint extends StatelessWidget {
  final IndexDetail index;

  const ChartIndexPoint({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<IndexChartResponse>(
        future:
            Get.find<HomeLogic>().getChartIndex(index.mc!, index.stockCode!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var chart = snapshot.data ?? IndexChartResponse();
            // print('chart ${index.stockCode?.value} độ dài ${chart.dataChart.length}');
            return CustomLineChart(
                drawPoint: chart.drawPoint,
                color: chart.colorChart,
                data: chart.dataChart);
          }
          return const SizedBox();
        });
  }
}
