import 'package:cached_network_image/cached_network_image.dart';
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

import '../../../../router/route_config.dart';

class ListStockView extends StatelessWidget {
  const ListStockView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<HomeLogic>().state;
    final homeLogic = Get.find<HomeLogic>();
    final caption = Theme.of(context).textTheme.caption?.copyWith(fontSize: 13);
    final headline4 = Theme.of(context).textTheme.headline4;
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    final bodyText2 = Theme.of(context).textTheme.bodyText2;
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(blurRadius: 0, color: Color.fromRGBO(0, 0, 0, 0.08)),
          BoxShadow(blurRadius: 8, color: Color.fromRGBO(0, 0, 0, 0.08))
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
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TabBar(
                  padding: EdgeInsets.zero,
                  onTap: (index) {
                    homeLogic.getTopStockData(index);
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
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteConfig.stockDetail,
                              arguments: state.listShortStock[index].stockCode);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 36,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "https://info.sbsi.vn/logo/${state.listShortStock[index].stockCode}",
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: AppColors.grayF2),
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.scaleDown),
                                    ),
                                  ),
                                  placeholder: (context, url) => Container(
                                    decoration: const BoxDecoration(
                                        color: AppColors.grayF2,
                                        shape: BoxShape.circle),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Center(child: Icon(Icons.error)),
                                ),
                              ),
                              const SizedBox(width: 18),
                              Expanded(
                                  flex: 29,
                                  child: Text(
                                    state.listShortStock[index].stockCode ?? "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .button
                                        ?.copyWith(fontWeight: FontWeight.w700),
                                  )),
                              const SizedBox(width: 18),
                              Expanded(
                                  flex: 70,
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: SizedBox(
                                        height: 27,
                                        child: CustomLineChart(
                                            drawPoint: (sumChart / lengthChart),
                                            color: state.listShortStock[index]
                                                .colorStock,
                                            data: state
                                                .listShortStock[index].listChart
                                                .cast<double>()),
                                      ))),
                              Expanded(
                                flex: 50,
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text:
                                              '${state.listShortStock[index].price?.toStringAsFixed(1)}',
                                          style: bodyText2?.copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: state.listShortStock[index]
                                                  .colorStock),
                                        ),
                                      ),
                                      Text(
                                          MoneyFormat.formatMoneyRound(
                                              '${state.listShortStock[index].klgd}'),
                                          style: caption?.copyWith(
                                              fontSize: 12,
                                              height: 20 / 12,
                                              color: AppColors.textGrey3)),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 18),
                              Expanded(
                                  flex: 50,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: state
                                            .listShortStock[index].colorStock),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '${state.listShortStock[index].percentChange! > 0 ? '+' : ''}${state.listShortStock[index].change}%',
                                        style: caption?.copyWith(
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
                        style: caption!
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
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
