import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:sbsi/model/entities/debt_acc.dart';
import 'package:sbsi/ui/widgets/animation_widget/expanded_widget.dart';

import '../../../../common/app_colors.dart';
import '../../../../generated/l10n.dart';
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
    Logger().d(widget.debt.toJson());
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
                        MoneyFormat.formatMoneyRound('${widget.debt.debtLoan}'),
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
                        rightTitle: S.of(context).cDELIVERDATE,
                        leftTitle: S.of(context).bank_code),
                    const SizedBox(height: 16),
                    rowData(
                        rightValue: MoneyFormat.formatMoneyRound('${widget.debt.cLOANIN}'),
                        leftValue: MoneyFormat.formatMoneyRound(
                            '${widget.debt.cLOANID}'),
                        rightTitle: S.of(context).debit_root,
                        leftTitle: S.of(context).loan_date),
                    const SizedBox(height: 16),
                    rowData(
                        rightValue:
                            MoneyFormat.formatMoneyRound('${widget.debt.cFEE}'),
                        leftValue: widget.debt.totalDate,
                        rightTitle: S.of(context).fee_1,
                        leftTitle: S.of(context).loan_number_day),
                    const SizedBox(height: 16),
                    rowData(
                        rightValue: MoneyFormat.formatMoneyRound(
                            '${widget.debt.cFEEOUT}'),
                        leftValue: MoneyFormat.formatMoneyRound(
                            '${widget.debt.cLOANOUT}'),
                        rightTitle: S.of(context).c_fee_out,
                        leftTitle: S.of(context).c_loan_out),
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
                    .caption
                    ?.copyWith(color: AppColors.textSecond),
              )),
              Text(
                leftValue,
                style: Theme.of(context)
                    .textTheme
                    .caption
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
                    .caption
                    ?.copyWith(color: AppColors.textSecond),
              )),
              Text(
                rightValue,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(color: rightColor, fontWeight: FontWeight.w700),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
