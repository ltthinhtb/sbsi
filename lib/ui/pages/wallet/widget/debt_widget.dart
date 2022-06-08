import 'package:flutter/material.dart';
import 'package:sbsi/model/entities/debt_acc.dart';
import 'package:sbsi/ui/widgets/animation_widget/expanded_widget.dart';

import '../../../../common/app_colors.dart';
import '../../../../utils/money_utils.dart';

class DebtWidget extends StatefulWidget {
  final int index;
  final DebtAcc debt;

  const DebtWidget({Key? key, required this.index, required this.debt})
      : super(key: key);

  @override
  State<DebtWidget> createState() => _DebtWidgetState();
}

class _DebtWidgetState extends State<DebtWidget> {
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
                  '${widget.index + 1}',
                  style: caption.copyWith(
                      fontWeight: FontWeight.w700, height: 16 / 12),
                )),
                Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        '${widget.debt.cINTERESTRATE?.toStringAsFixed(0)}%',
                        style: caption.copyWith(height: 16 / 12),
                      ),
                    )),
                Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        MoneyFormat.formatMoneyRound('${widget.debt.cLOAN}'),
                        textAlign: TextAlign.start,
                        style: caption.copyWith(
                            fontWeight: FontWeight.w700, height: 16 / 12),
                      ),
                    )),
                Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        widget.debt.cEXPIREDATE1 ?? "",
                        style: caption.copyWith(
                            fontWeight: FontWeight.w700, height: 16 / 12),
                      ),
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
                        rightValue: widget.debt.cDELIVERDATE ?? "",
                        leftValue: widget.debt.cBANKCODE ?? "",
                        rightTitle: 'Ngày vay',
                        leftTitle: 'Nguồn'),
                    const SizedBox(height: 16),
                    rowData(
                        rightValue: widget.debt.cINTERESTDATE ?? "",
                        leftValue: MoneyFormat.formatMoneyRound(
                            '${widget.debt.cLOANID}'),
                        rightTitle: 'Dư nợ gốc',
                        leftTitle: 'Ngày tính lãi'),
                    const SizedBox(height: 16),
                    rowData(
                        rightValue:
                            MoneyFormat.formatMoneyRound('${widget.debt.cFEE}'),
                        leftValue: widget.debt.totalDate,
                        rightTitle: "Lãi phát sinh",
                        leftTitle: 'Số ngày vay'),
                    const SizedBox(height: 16),
                    rowData(
                        rightValue: MoneyFormat.formatMoneyRound(
                            '${widget.debt.cFEEOUT}'),
                        leftValue: MoneyFormat.formatMoneyRound(
                            '${widget.debt.cLOANOUT}'),
                        rightTitle: 'Lãi đã trả',
                        leftTitle: 'Dư nợ đã trả'),
                    const SizedBox(height: 16),
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
