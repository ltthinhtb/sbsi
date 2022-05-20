import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/ui/pages/order_list/order_list_logic.dart';
import 'package:sbsi/utils/money_utils.dart';
import '../../../../common/app_colors.dart';
import '../../../../model/entities/order_history.dart';
import '../../../../utils/error_message.dart';

class HistoryWidget extends StatefulWidget {
  const HistoryWidget({Key? key, required this.history, required this.index})
      : super(key: key);

  final OrderHistory history;
  final int index;

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  final state = Get.find<OrderListLogic>().state;
  final logic = Get.find<OrderListLogic>();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildItem(widget.history);
  }


  Widget buildItem(OrderHistory data) {
    String _status = MessageOrder.getStatusOrder1(data);
    final caption = Theme.of(context).textTheme.caption;
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 10, 0, 3),
      decoration: BoxDecoration(
          color: widget.index % 2 == 0 ? AppColors.whiteF7 : AppColors.white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 126,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 16,
                      width: 16,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: data.colorBack,
                          borderRadius: BorderRadius.circular(4)),
                      child: Text(
                        data.sideString(context),
                        style: caption?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.white),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      data.cSHARECODE ?? "",
                      style: caption?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  _status,
                  style: caption?.copyWith(
                      color: MessageOrder.getColorStatus(
                          MessageOrder.statusHuySua1(data))),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 96,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  MoneyFormat.formatMoneyRound('${data.cORDERVOLUME}'),
                  style: caption?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Text(
                  '${data.cORDERPRICE ?? ""}',
                  style: caption?.copyWith(
                      fontWeight: FontWeight.w400, color: data.colorBack),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 95,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  MoneyFormat.formatMoneyRound('${data.cMATCHVOL}'),
                  style: caption?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Text(
                  '${data.cMATCHEDVALUE}',
                  style: caption?.copyWith(
                      fontWeight: FontWeight.w400, color: data.colorBack),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 95,
            child: Text(
              '${data.cORDERTIME?.split(" ").first ?? ""}',
              style: caption?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
