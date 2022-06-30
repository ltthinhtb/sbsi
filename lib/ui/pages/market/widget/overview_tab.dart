import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_text_styles.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/model/response/market_depth_response.dart';
import 'package:sbsi/ui/pages/market/market_logic.dart';
import 'package:sbsi/ui/pages/market/widget/market_depth_chart.dart';

import 'stock_exchanges .dart';
import 'top_foreign_trade.dart';

class OverviewView extends StatefulWidget {
  const OverviewView({Key? key}) : super(key: key);

  @override
  State<OverviewView> createState() => _OverviewViewState();
}

class _OverviewViewState extends State<OverviewView>
    with AutomaticKeepAliveClientMixin {
  final state = Get.find<MarketLogic>().state;
  final logic = Get.find<MarketLogic>();


  @override
  Widget build(BuildContext context) {
    super.build(context);
    final subtitle1 = Theme.of(context).textTheme.subtitle1;
    final caption = Theme.of(context).textTheme.caption;
    final body1 = Theme.of(context).textTheme.bodyText1;

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
        return RefreshIndicator(
          onRefresh: () async{
            logic.getMarketDepth();
            logic.getDetailStockBranch();
            logic.getTopForeignTrade();
          },
          child: SingleChildScrollView(
            child: Column(
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
                                S.of(context).total +
                                    " ${state.marketDepthTotal}",
                                style: caption?.copyWith(
                                    color:
                                        const Color.fromRGBO(204, 204, 204, 1))),
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
                              width:
                                  (MediaQuery.of(context).size.width - 16 * 3) *
                                      pDown,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                color: AppColors.decrease,
                              )),
                          const Spacer(),
                          Container(
                              height: 4,
                              width:
                                  (MediaQuery.of(context).size.width - 16 * 3) *
                                      (1 - pDown - pUp),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                color: AppColors.yellow,
                              )),
                          const Spacer(),
                          Container(
                              height: 4,
                              width:
                                  (MediaQuery.of(context).size.width - 16 * 3) *
                                      pUp,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                color: AppColors.increase,
                              )),
                          const Spacer(),
                        ]),
                        const SizedBox(height: 8),
                        Row(children: [
                          Text("${S.of(context).decrease} ${state.marketDepthNegativeInteger}",
                              style: AppTextStyle.H7Bold.copyWith(
                                  color: AppColors.decrease)),
                          const Spacer(),
                          Text("${S.of(context).increase} ${state.marketDepthInteger}",
                              style: AppTextStyle.H7Bold.copyWith(
                                  color: AppColors.increase)),
                        ]),
                      ],
                    )),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(color: AppColors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          S.of(context).top_foreign,
                          style: body1?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(
                          height: 16,
                          color: Color.fromRGBO(242, 242, 242, 1),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 85,
                              child: Text(
                                S.of(context).stock_code,
                                style: caption?.copyWith(
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Expanded(
                              flex: 93,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  S.of(context).price,
                                  style: caption?.copyWith(
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 93,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  S.of(context).increase_decrease,
                                  style: caption?.copyWith(
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 90,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '${S.of(context).increase_decrease}%',
                                  textAlign: TextAlign.end,
                                  style: caption?.copyWith(
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      const TopForeignTrade()
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
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
