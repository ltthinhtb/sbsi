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
    int flex = 4;
    return Expanded(
        child: Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: DefaultTabController(
        length: StockEnum.values.length,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TabBar(
                  labelColor: Colors.yellow,
                  unselectedLabelColor: Colors.grey,
                  indicator: ShapeDecoration(
                      shape: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.yellow,
                              width: 2,
                              style: BorderStyle.solid))),
                  onTap: (value) {
                    homeLogic.getTopStockData(value);
                  },
                  tabs: StockEnum.values
                      .map((e) => Center(
                          child: Text(e.title(context),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14))))
                      .toList()),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Obx(() {
                if (state.listShortStock.isNotEmpty) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        double sumChart = state.listShortStock[index].listChart
                            .cast<double>()
                            .fold(0, (pr, e) => (pr + e));
                        var lengthChart = state.listShortStock[index].listChart
                            .cast<double>()
                            .length;
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 7),
                          margin: EdgeInsets.only(top: 5),
                          color: index % 2 == 1
                              ? const Color.fromRGBO(
                                  215, 209, 209, 0.10588235294117647)
                              : null,
                          height: 55,
                          child: Row(
                            children: [
                              Expanded(
                                  flex: flex,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.listShortStock[index].stockCode ??
                                            "",
                                        style: headline6!.copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.white),
                                      ),
                                      Spacer(),
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
                              SizedBox(width: 10),
                              Expanded(
                                  flex: flex,
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: CustomLineChart(
                                          drawPoint: (sumChart / lengthChart),
                                          chartColor: state
                                              .listShortStock[index].stockPrice,
                                          data: state
                                              .listShortStock[index].listChart
                                              .cast<double>()))),
                              Expanded(
                                flex: flex,
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
                                      Spacer(),
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
                              SizedBox(width: 10),
                              Expanded(
                                  flex: flex ~/ 2,
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
                        );
                      },
                      itemCount: state.listShortStock.length);
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
            ),
          ],
        ),
      ),
    ));
  }
}
