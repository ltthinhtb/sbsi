import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/model/entities/share_transaction.dart';
import 'package:sbsi/ui/pages/cash_transaction/cash_transaction_logic.dart';
import 'package:sbsi/utils/money_utils.dart';
import '../../../../common/app_colors.dart';

class TransactionHistoryWidget extends StatefulWidget {
  const TransactionHistoryWidget(
      {Key? key,
        required this.transaction,
        required this.index})
      : super(key: key);

  final ShareTransaction transaction;
  final int index;

  @override
  State<TransactionHistoryWidget> createState() => _TransactionHistoryWidgetState();
}

class _TransactionHistoryWidgetState extends State<TransactionHistoryWidget> {
  final state = Get.find<CashTransactionLogic>().state;
  final logic = Get.find<CashTransactionLogic>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildItem(widget.transaction);
  }

  Widget buildItem(ShareTransaction data) {
    final caption = Theme.of(context).textTheme.caption;
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
      decoration: BoxDecoration(
          color: widget.index % 2 == 0 ? AppColors.whiteF7 : AppColors.white),
      child: Row(
        children: [
          Expanded(
            flex: 62,
            child: Text(
              widget.transaction.cTRANSACTIONDATE ?? "",
              style: caption?.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
          Expanded(
            flex: 79,
            child: Center(
              child: Text(
                widget.transaction.cSHARECODE ?? "",
                style: caption?.copyWith(fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Expanded(
            flex: 79,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                MoneyFormat.formatMoneyRound(
                    widget.transaction.cSHAREIN.toString()),
                style: caption?.copyWith(fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Expanded(
            flex: 79,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                MoneyFormat.formatMoneyRound(
                    widget.transaction.cSHAREOUT.toString()),
                style: caption?.copyWith(fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
