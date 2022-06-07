import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/ui/commons/appbar.dart';
import 'package:sbsi/ui/pages/order_list/order_list_logic.dart';
import 'package:sbsi/utils/error_message.dart';
import 'package:sbsi/utils/money_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../model/entities/order_history.dart';

class OrderDetail extends StatefulWidget {
  final OrderHistory data;

  const OrderDetail({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  final logic = Get.find<OrderListLogic>();
  final state = Get.find<OrderListLogic>().state;
  late String _status;
  late bool canFix;

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    // TODO: implement initState
    super.initState();
    setState(() {
      _status = MessageOrder.getStatusOrder1(widget.data);
      if (_status == "Khớp 1 phần" || _status == "Chờ khớp") {
        canFix = true;
      } else {
        canFix = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: S.of(context).order_detail,
        isCenter: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 16),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 248, 231, 1),
          boxShadow: [
            const BoxShadow(offset: Offset(0,4),blurRadius: 20,color: const Color.fromRGBO(0, 0, 0, 0.05))
          ]
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildInfo(S.of(context).stock_code, widget.data.cSHARECODE ?? ""),
            buildInfo(S.of(context).status, _status,textColor: MessageOrder.getColorStatus(
                MessageOrder.statusHuySua1(widget.data))),
            buildInfo(
              S.of(context).orderType,
              widget.data.cSIDE == "B" ? S.of(context).buy : S.of(context).sell,
              textColor:
                  widget.data.cSIDE == "B" ? AppColors.green : AppColors.red,
            ),
            buildInfo(S.of(context).order_time, widget.data.cORDERDATE ?? ""),
            buildInfo(
              S.of(context).order_volumn,
              MoneyFormat.formatMoneyRound('${widget.data.cORDERVOLUME}'),
            ),
            buildInfo(
              S.of(context).order_price,
              MoneyFormat.formatMoneyRound('${widget.data.cORDERPRICE}'),
            ),
            buildInfo(S.of(context).order_source, widget.data.cCHANELNAME ?? "-"),
          ],
        ),
      ),
    );
  }

  Widget buildInfo(String label, String value, {Color? textColor}) {
    final body2 = Theme.of(context).textTheme.bodyText2;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: body2?.copyWith(color: AppColors.textSecond),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: body2?.copyWith(fontWeight: FontWeight.w700,color: textColor),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

}
