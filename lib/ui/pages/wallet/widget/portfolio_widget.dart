import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/model/response/portfolio.dart';
import 'package:sbsi/ui/pages/main/main_logic.dart';
import 'package:sbsi/ui/pages/stock_order/stock_order_logic.dart';
import 'package:sbsi/ui/widgets/animation_widget/expanded_widget.dart';

import '../../../../common/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../../services/index.dart';
import '../../../../utils/money_utils.dart';
import '../../../widgets/button/button_filled.dart';

class PortfolioWidget extends StatefulWidget {
  final int index;
  final PortfolioStatus portfolio;

  const PortfolioWidget(
      {Key? key, required this.index, required this.portfolio})
      : super(key: key);

  @override
  State<PortfolioWidget> createState() => _PortfolioWidgetState();
}

class _PortfolioWidgetState extends State<PortfolioWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final caption = Theme.of(context).textTheme.caption!;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          _expanded = !_expanded;
        });
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
                color: _expanded
                    ? AppColors.table2
                    : (widget.index % 2 == 0 ? null : AppColors.whiteF7)),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  widget.portfolio.symbol ?? "",
                  style: caption.copyWith(
                      fontWeight: FontWeight.w700, height: 16 / 12),
                )),
                Expanded(
                    child: Text(
                  MoneyFormat.formatMoneyRound(
                      '${widget.portfolio.actualVol ?? ""}'),
                  style: caption.copyWith(height: 16 / 12),
                )),
                Expanded(
                    child: Text(
                  widget.portfolio.avgPrice1.trim(),
                  textAlign: TextAlign.start,
                  style: caption.copyWith(
                      fontWeight: FontWeight.w700,
                      height: 16 / 12,
                      color: widget.portfolio.glColor),
                )),
                Expanded(
                    child: Text(
                  widget.portfolio.gainLossPer ?? "",
                  style: caption.copyWith(
                      fontWeight: FontWeight.w700,
                      height: 16 / 12,
                      color: widget.portfolio.glColor),
                )),
                Expanded(
                    child: Text(
                  MoneyFormat.formatMoneyRound(
                      '${widget.portfolio.gainLossValue}'),
                  style: caption.copyWith(
                      fontWeight: FontWeight.w700, height: 16 / 12),
                )),
              ],
            ),
          ),
          Visibility(visible: _expanded, child: const SizedBox(height: 15)),
          ExpandedSection(
              expand: _expanded,
              child: Container(
                decoration: const BoxDecoration(color: AppColors.white),
                child: Column(
                  children: [
                    rowData(
                        rightValue: MoneyFormat.formatMoneyRound(
                            '${widget.portfolio.actualVol ?? ""}'),
                        leftValue: widget.portfolio.sellT0 ?? "",
                        leftColor: widget.portfolio.glColor,
                        rightTitle: 'Tổng KL',
                        leftTitle: 'Bán T0'),
                    const SizedBox(height: 16),
                    rowData(
                        rightValue: MoneyFormat.formatMoneyRound(
                            '${widget.portfolio.avaiableVol ?? ""}'),
                        leftValue: widget.portfolio.buyT0 ?? "",
                        rightTitle: 'KL khả dụng',
                        leftTitle: 'Mua T0'),
                    const SizedBox(height: 16),
                    rowData(
                        rightValue: MoneyFormat.formatMoneyRound(
                            '${widget.portfolio.marketValue ?? ""}'),
                        leftValue: widget.portfolio.buyT1 ?? "",
                        rightTitle: 'Giá trị TT',
                        leftTitle: 'Mua T1'),
                    const SizedBox(height: 16),
                    rowData(
                        rightValue: MoneyFormat.formatMoneyRound(
                            '${widget.portfolio.gainLossValue ?? ""}'),
                        rightColor: widget.portfolio.glColor,
                        leftValue: widget.portfolio.buyT2 ?? "",
                        rightTitle: 'Lãi/lỗ',
                        leftTitle: 'Mua T2'),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                              child: ButtonFill(
                                  voidCallback: () {
                                    // di chuyển đến tap đặt lệnh
                                    Get.find<MainLogic>().switchTap(2);
                                    // lấy listStock từ db
                                    final allStock = Get.find<StoreService>()
                                        .listStockCompany;
                                    final stock = allStock.firstWhere(
                                        (element) =>
                                            element.stockCode ==
                                            widget.portfolio.symbol);
                                    // chọn mã chứng khoán
                                    Get.find<StockOrderLogic>()
                                        .selectStock(stock);
                                  },
                                  title: S.of(context).buy,
                                  style: Theme.of(context)
                                      .elevatedButtonTheme
                                      .style
                                      ?.copyWith(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  AppColors.active),
                                          padding: ButtonStyleButton.allOrNull<
                                                  EdgeInsetsGeometry>(
                                              const EdgeInsets.symmetric(
                                                  horizontal: 24,
                                                  vertical: 10)),
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
                                  voidCallback: () {
                                    // di chuyển đến tap đặt lệnh
                                    Get.find<MainLogic>().switchTap(2);
                                    // lấy listStock từ db
                                    final allStock = Get.find<StoreService>()
                                        .listStockCompany;
                                    final stock = allStock.firstWhere(
                                        (element) =>
                                            element.stockCode ==
                                            widget.portfolio.symbol);
                                    // chọn mã chứng khoán
                                    Get.find<StockOrderLogic>()
                                        .selectStock(stock);
                                  },
                                  title: S.of(context).sell,
                                  style: Theme.of(context)
                                      .elevatedButtonTheme
                                      .style
                                      ?.copyWith(
                                          padding: ButtonStyleButton.allOrNull<
                                                  EdgeInsetsGeometry>(
                                              const EdgeInsets.symmetric(
                                                  horizontal: 24,
                                                  vertical: 10)),
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
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Widget rowData({
    required String leftTitle,
    required String rightTitle,
    Color leftColor = AppColors.black,
    required String leftValue,
    required String rightValue,
    Color rightColor = AppColors.black,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
              child: Row(
            children: [
              Expanded(
                  child: Text(
                leftTitle,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: AppColors.textSecond),
              )),
              Text(
                leftValue,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: leftColor, fontWeight: FontWeight.w700),
              ),
            ],
          )),
          const SizedBox(width: 16),
          Expanded(
              child: Row(
            children: [
              Expanded(
                  child: Text(
                rightTitle,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: AppColors.textSecond),
              )),
              Text(
                rightValue,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: rightColor, fontWeight: FontWeight.w700),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
