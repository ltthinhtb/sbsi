import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/model/response/transaction_new.dart';
import 'package:sbsi/ui/pages/cash_transaction/cash_transaction_logic.dart';
import 'package:sbsi/ui/widgets/animation_widget/expanded_widget.dart';
import 'package:sbsi/utils/money_utils.dart';
import '../../../../common/app_colors.dart';

class TransactionWidget extends StatefulWidget {
  const TransactionWidget(
      {Key? key,
      required this.transaction,
      required this.index,
      required this.endBalancer})
      : super(key: key);

  final Transaction transaction;
  final int index;
  final num endBalancer;

  @override
  State<TransactionWidget> createState() => _TransactionWidgetState();
}

class _TransactionWidgetState extends State<TransactionWidget> {
  final state = Get.find<CashTransactionLogic>().state;
  final logic = Get.find<CashTransactionLogic>();

  @override
  void initState() {
    super.initState();
  }

  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return buildItem(widget.transaction);
  }

  Widget buildItem(Transaction data) {
    final caption = Theme.of(context).textTheme.caption;
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(18, 12, 0, 12),
            decoration: BoxDecoration(
                color: _isExpanded
                    ? AppColors.tableHover
                    : (widget.index % 2 == 0
                        ? AppColors.whiteF7
                        : AppColors.white)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    data.cTRANSACTIONDATE ?? "",
                    style: caption?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      MoneyFormat.formatMoneyRound("${data.balancerEnd}"),
                      style: caption?.copyWith(
                          fontWeight: FontWeight.w700, color: data.color),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    MoneyFormat.formatMoneyRound("${widget.endBalancer}"),
                    style: caption?.copyWith(fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
          ExpandedSection(
              expand: _isExpanded,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text(widget.transaction.cCONTENT ?? "")],
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
