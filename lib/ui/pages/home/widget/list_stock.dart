import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_images.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/ui/pages/home/enum/StockEnum.dart';
import 'package:sbsi/ui/pages/home/home_logic.dart';
import 'package:sbsi/ui/widgets/button/button_filled.dart';
import 'package:sbsi/ui/widgets/chart/custom_chart.dart';
import 'package:sbsi/utils/money_utils.dart';

class ListStockView extends StatelessWidget {
  const ListStockView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<HomeLogic>().state;
    final homeLogic = Get.find<HomeLogic>();
    final headline6 = Theme.of(context).textTheme.headline6;
    final headline3 = Theme.of(context).textTheme.headline3;
    final headline4 = Theme.of(context).textTheme.headline4;
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(blurRadius: 0, color: Color.fromRGBO(0, 0, 0, 0.10)),
          BoxShadow(blurRadius: 4, color: Color.fromRGBO(0, 0, 0, 0.10)),
          BoxShadow(blurRadius: 20, color: Color.fromRGBO(0, 0, 0, 0.10))
        ],
      ),
      child: DefaultTabController(
        length: StockEnum.values.length,
        child: Column(
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).variable,
                    style: headline4?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    S.of(context).all,
                    style: bodyText1?.copyWith(color: AppColors.textSecond),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TabBar(
                  onTap: (value) {
                    homeLogic.getTopStockData(value);
                  },
                  tabs: StockEnum.values
                      .map((e) => Center(child: Text(e.title(context))))
                      .toList()),
            ),
            const SizedBox(height: 34),
            Obx(() {
              if (state.listShortStock.isNotEmpty) {
                return ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    double sumChart = state.listShortStock[index].listChart
                        .cast<double>()
                        .fold(0, (pr, e) => (pr + e));
                    var lengthChart = state.listShortStock[index].listChart
                        .cast<double>()
                        .length;
                    return IntrinsicHeight(
                      child: Container(
                        color: index % 2 == 1
                            ? const Color.fromRGBO(
                                215, 209, 209, 0.10588235294117647)
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 74,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.listShortStock[index].stockCode ??
                                            "",
                                        style: headline6!.copyWith(
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        state.listShortStock[index].stockName ??
                                            "",
                                        style: headline3!.copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            overflow: TextOverflow.ellipsis,
                                            color: AppColors.textGrey3),
                                      )
                                    ],
                                  )),
                              const SizedBox(width: 36),
                              Expanded(
                                  flex: 76,
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: SizedBox(
                                        height: 27,
                                        child: CustomLineChart(
                                            drawPoint: (sumChart / lengthChart),
                                            chartColor: state
                                                .listShortStock[index]
                                                .stockPrice,
                                            data: state
                                                .listShortStock[index].listChart
                                                .cast<double>()),
                                      ))),
                              const SizedBox(width: 11),
                              Expanded(
                                flex: 72,
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text:
                                              '${state.listShortStock[index].percentChange! > 0 ? '+' : ''}${state.listShortStock[index].change}',
                                          style: headline6.copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: state.listShortStock[index]
                                                  .colorStock
                                                  .withOpacity(1)),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    '(${state.listShortStock[index].percentChange! > 0 ? '+' : ''}${state.listShortStock[index].percentChange}%)',
                                                style: headline6.copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 12,
                                                    color: state
                                                        .listShortStock[index]
                                                        .colorStock
                                                        .withOpacity(1))),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                          MoneyFormat.formatMoneyRound(
                                              '${state.listShortStock[index].klgd}'),
                                          style: headline6.copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.textGrey3)),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                  flex: 56,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: state
                                            .listShortStock[index].colorStock),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '${state.listShortStock[index].price?.toStringAsFixed(1)}',
                                        style: headline6.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: state.listShortStock.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      thickness: 1,
                      indent: 64,
                      endIndent: 32,
                      height: 32,
                    );
                  },
                );
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      SvgPicture.asset(AppImages.search_big_size),
                      const SizedBox(height: 15),
                      Text(
                        S.of(context).no_stock_hint_text,
                        textAlign: TextAlign.center,
                        style: headline6!
                            .copyWith(color: AppColors.gray88, height: 1.2),
                      ),
                      const SizedBox(height: 10),
                      ButtonFill(
                        voidCallback: () {},
                        title: S.of(context).add_stock,
                        style: ElevatedButton.styleFrom(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25)),
                      )
                    ],
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
