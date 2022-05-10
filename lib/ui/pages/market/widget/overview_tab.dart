import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_text_styles.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/model/response/market_depth_response.dart';
import 'package:sbsi/ui/pages/market/market_logic.dart';
import 'package:sbsi/ui/pages/market/widget/market_depth_chart.dart';

import 'stock_exchanges .dart';

class OverviewView extends StatelessWidget {
  OverviewView({Key? key}) : super(key: key);
  final state = Get.find<MarketLogic>().state;
  final logic = Get.find<MarketLogic>();

  @override
  Widget build(BuildContext context) {
    final subtitle1 = Theme.of(context).textTheme.subtitle1;
    final caption = Theme.of(context).textTheme.caption;

    return Obx(
      () {
        var data = <MarketDepth>[];
        if (state.marketDepth.length > 0) data = state.marketDepth;
        var pUp = state.marketDepthTotal != 0
            ? state.marketDepthInteger.toDouble() /
                state.marketDepthTotal.toDouble()
            : 0;
        var pDown = state.marketDepthTotal != 0
            ? state.marketDepthNegativeInteger.toDouble() /
                state.marketDepthTotal.toDouble()
            : 0;
        return Column(
          children: [
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: StockExchangesView(),
            ),
            const SizedBox(height: 16),
            Container(
                height: 263,
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.03),
                      offset: Offset(0, -5),
                      blurRadius: 8),
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.04),
                      offset: Offset(0, -1),
                      blurRadius: 10),
                ], color: AppColors.white),
                padding: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                        child: Text(S.of(context).market_depth,
                            style: subtitle1?.copyWith(
                                fontWeight: FontWeight.w700)),
                        width: MediaQuery.of(context).size.width),
                    Container(
                        margin: const EdgeInsets.only(top: 4, bottom: 30),
                        child: Text(
                            S.of(context).total + " ${state.marketDepthTotal}",
                            style: caption?.copyWith(
                                color: const Color.fromRGBO(204, 204, 204, 1))),
                        width: MediaQuery.of(context).size.width),
                    Expanded(
                        child: Visibility(
                      child: MarketDepthBarChart(data: data),
                      visible: data.isNotEmpty,
                    )),
                    const SizedBox(height: 26),
                    Row(children: [
                      Container(
                          height: 4,
                          width: (MediaQuery.of(context).size.width - 16 * 3) *
                              pDown,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: AppColors.decrease,
                          )),
                      const Spacer(),
                      Container(
                          height: 4,
                          width: (MediaQuery.of(context).size.width - 16 * 3) *
                              (1 - pDown - pUp),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: AppColors.yellow,
                          )),
                      const Spacer(),
                      Container(
                          height: 4,
                          width: (MediaQuery.of(context).size.width - 16 * 3) *
                              pUp,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: AppColors.increase,
                          )),
                      const Spacer(),
                    ]),
                    const SizedBox(height: 8),
                    Row(children: [
                      Text("Giảm ${state.marketDepthNegativeInteger}",
                          style: AppTextStyle.H7Bold.copyWith(
                              color: AppColors.decrease)),
                      const Spacer(),
                      Text("Tăng ${state.marketDepthInteger}",
                          style: AppTextStyle.H7Bold.copyWith(
                              color: AppColors.increase)),
                    ]),
                  ],
                )),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }
}

enum StockEnum { domestic, world }

extension StockExt on StockEnum {
  String title(BuildContext context) {
    switch (this) {
      case StockEnum.domestic:
        return S.of(context).domestic;
      case StockEnum.world:
        return S.of(context).the_world;
    }
  }
}
