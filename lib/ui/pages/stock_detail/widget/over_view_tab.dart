import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_shadows.dart';
import 'package:sbsi/model/stock_data/stock_info.dart';
import 'package:sbsi/ui/pages/stock_detail/stock_detail_logic.dart';
import 'package:sbsi/ui/widgets/button/button_filled.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/money_utils.dart';
import '../../../commons/hoziontal_chart.dart';

class OverViewTab extends StatefulWidget {
  const OverViewTab({Key? key}) : super(key: key);

  @override
  State<OverViewTab> createState() => _OverViewTabState();
}

class _OverViewTabState extends State<OverViewTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final body1 = Theme.of(context).textTheme.bodyText1;
    final body2 = Theme.of(context).textTheme.bodyText2;
    final caption = Theme.of(context).textTheme.caption;

    return Obx(() {
      var stock = Get.find<StockDetailLogic>().state.selectedStockInfo.value;
      var listStockTrade = Get.find<StockDetailLogic>().state.listStockTrade;

      return SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: AppColors.white, boxShadow: AppShadow.boxShadow),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.of(context).step_price,
                          style: body1?.copyWith(fontWeight: FontWeight.w700)),
                      Text(S.of(context).more,
                          style: body2?.copyWith(color: AppColors.textSecond)),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    height: 16,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      stockGraph(true, stock),
                      const SizedBox(width: 11),
                      stockGraph(false, stock)
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: AppColors.white, boxShadow: AppShadow.boxShadow),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Khớp lệnh',
                          style: body1?.copyWith(fontWeight: FontWeight.w700)),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    height: 16,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                          flex: 180,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: listStockTrade.length > 10
                                ? 10
                                : listStockTrade.length,
                            itemBuilder: (BuildContext context, int index) {
                              var stockTrade = listStockTrade[index];
                              return Container(
                                height: 40,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(
                                    left: 17.71, right: 3),
                                decoration: BoxDecoration(
                                    color: index % 2 == 0
                                        ? AppColors.table1
                                        : AppColors.white),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        stockTrade.time,
                                        style: caption,
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          '${stockTrade.lASTPRICE ?? ""}',
                                          style: caption?.copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: stockTrade.color),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          '${stockTrade.lASTVOL ?? ""}',
                                          style: caption?.copyWith(),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          )),
                      SizedBox(
                        width: (21 / 375) * MediaQuery.of(context).size.width,
                      ),
                      Expanded(
                          flex: 195,
                          child: SizedBox(
                            height: 400,
                            child: HorizontalBarChart(
                              seriesList:
                                  Get.find<StockDetailLogic>().listChart(),
                              maxVol: Get.find<StockDetailLogic>().maxVol,
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                      child: ButtonFill(
                          voidCallback: () {},
                          title: S.of(context).buy,
                          style: Theme.of(context)
                              .elevatedButtonTheme
                              .style
                              ?.copyWith(
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColors.active),
                                  padding: ButtonStyleButton.allOrNull<
                                          EdgeInsetsGeometry>(
                                      const EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 10)),
                                  shape: ButtonStyleButton.allOrNull<
                                          OutlinedBorder>(
                                      const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ))))),
                  const SizedBox(width: 16),
                  Expanded(
                      child: ButtonFill(
                          voidCallback: () {},
                          title: S.of(context).sell,
                          style: Theme.of(context)
                              .elevatedButtonTheme
                              .style
                              ?.copyWith(
                                  padding: ButtonStyleButton.allOrNull<
                                          EdgeInsetsGeometry>(
                                      const EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 10)),
                                  shape: ButtonStyleButton.allOrNull<
                                          OutlinedBorder>(
                                      const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ))))),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      );
    });
  }

  Widget stockGraph(bool isBuy, StockInfo stockData) {
    num vol1 = (isBuy ? stockData.g1?.volumn : stockData.g4?.volumn) ?? 0;
    num vol2 = (isBuy ? stockData.g2?.volumn : stockData.g5?.volumn) ?? 0;
    num vol3 = (isBuy ? stockData.g3?.volumn : stockData.g6?.volumn) ?? 0;

    String price1 = (isBuy ? stockData.g1?.price : stockData.g4?.price) ?? "0";
    String price2 = (isBuy ? stockData.g2?.price : stockData.g5?.price) ?? "0";
    String price3 = (isBuy ? stockData.g3?.price : stockData.g6?.price) ?? "0";

    int percentVol1 =
        ((isBuy ? stockData.totalBuyVol : stockData.totalSellVol) - vol1)
            .toInt();
    int percentVol2 =
        ((isBuy ? stockData.totalBuyVol : stockData.totalSellVol) - vol2)
            .toInt();
    int percentVol3 =
        ((isBuy ? stockData.totalBuyVol : stockData.totalSellVol) - vol3)
            .toInt();

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection: isBuy ? TextDirection.ltr : TextDirection.rtl,
            children: [
              Text(
                S.of(context).volumn,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(color: AppColors.gray7E),
              ),
              Container(
                child: Text(
                  isBuy ? S.of(context).buy : S.of(context).sell,
                  style: Theme.of(context).textTheme.caption?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: isBuy ? AppColors.active : AppColors.deActive),
                ),
              )
            ],
          ),
          const SizedBox(height: 17),
          rowVol(
              price: price1, isBuy: isBuy, percentVol: percentVol1, vol: vol1),
          const SizedBox(height: 12),
          rowVol(
              price: price2, isBuy: isBuy, percentVol: percentVol2, vol: vol2),
          const SizedBox(height: 12),
          rowVol(
              price: price3, isBuy: isBuy, percentVol: percentVol3, vol: vol3),
        ],
      ),
    );
  }

  Widget rowVol(
      {required int percentVol,
      required num vol,
      required bool isBuy,
      required String price}) {
    return Stack(
      children: [
        Row(
          textDirection: isBuy ? TextDirection.ltr : TextDirection.rtl,
          children: [
            const Expanded(child: SizedBox()),
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textDirection: isBuy ? TextDirection.ltr : TextDirection.rtl,
                children: [
                  Expanded(
                    flex: percentVol,
                    child: const SizedBox(),
                  ),
                  Expanded(
                    flex: vol.toInt(),
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                          color: isBuy ? AppColors.Pastel2 : AppColors.Pastel,
                          borderRadius: BorderRadius.circular(2)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textDirection: isBuy ? TextDirection.ltr : TextDirection.rtl,
          children: [
            SizedBox(
              height: 20,
              child: Center(
                child: Text(
                  '${MoneyFormat.formatVol10('$vol')}',
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(
              height: 20,
              child: Center(
                child: Text(
                  '$price',
                  style: Theme.of(context).textTheme.caption?.copyWith(
                      color: isBuy ? AppColors.active : AppColors.deActive,
                      fontWeight: FontWeight.w600),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
