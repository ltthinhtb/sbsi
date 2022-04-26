import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_text_styles.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/model/order_data/change_order_data.dart';
import 'package:sbsi/model/order_data/inday_order.dart';
import 'package:sbsi/ui/commons/app_snackbar.dart';
import 'package:sbsi/ui/commons/appbar.dart';
import 'package:sbsi/ui/pages/order_list/order_list_logic.dart';
import 'package:sbsi/ui/widgets/button/button_filled.dart';
import 'package:sbsi/ui/widgets/dialog/custom_dialog.dart';
import 'package:sbsi/utils/error_message.dart';
import 'package:sbsi/utils/stock_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OrderDetail extends StatefulWidget {
  final IndayOrder data;

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
      _status = MessageOrder.getStatusOrder(widget.data);
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            buildInfo(S.of(context).stock_code, widget.data.symbol ?? ""),
            buildInfo(S.of(context).status, _status),
            buildInfo(
              S.of(context).orderType,
              widget.data.side == "B" ? S.of(context).buy : S.of(context).sell,
              textColor:
                  widget.data.side == "B" ? AppColors.green : AppColors.red,
            ),
            buildInfo(S.of(context).order_time, widget.data.orderTime ?? ""),
            buildInfo(
              S.of(context).order_volumn,
              StockUtil.formatVol(
                double.parse(widget.data.volume ?? "0"),
              ),
            ),
            buildInfo(
              S.of(context).order_price,
              StockUtil.formatMoney(
                double.parse(widget.data.orderPrice ?? "0") / 1000,
              ),
            ),
            buildInfo(S.of(context).order_source, widget.data.channel ?? "-"),
          ],
        ),
      ),
      floatingActionButton: canFix
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: ButtonFill(
                        voidCallback: () async {
                          bool? _r = await CustomDialog.showConfirmDialog(
                            context,
                            S.of(context).confirm_cancel_order,
                            [
                              S.of(context).are_you_sure_cancel_this_order,
                            ],
                            buttonColors: [
                              AppColors.primary2,
                              AppColors.primary
                            ],
                            textButtonColors: [
                              AppColors.primary,
                              AppColors.white
                            ],
                          );
                          if (_r ?? false) {
                            await cancelOrder();
                          }
                        },
                        title: S.of(context).cancel_order,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: ButtonFill(
                        voidCallback: () async {
                          ChangeOrderData? _r =
                              await CustomDialog.showChangeOrderDialog(
                                context,
                            S.of(context).confirm_change_order,
                            [
                              S.of(context).change_order,
                            ],
                            buttonColors: [
                              AppColors.primary2,
                              AppColors.primary
                            ],
                            textButtonColors: [
                              AppColors.primary,
                              AppColors.white
                            ],
                          );
                          if (_r != null &&
                              _r.price.isNotEmpty &&
                              _r.vol.isNotEmpty) {
                            await changeOrder(_r);
                          }
                        },
                        title: S.of(context).change_order,
                      ),
                    ),
                  )
                ],
              ),
            )
          : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildInfo(String label, String value, {Color? textColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: AppTextStyle.caption2,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: AppTextStyle.bodyText2.copyWith(color: textColor),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> cancelOrder() async {
    state.selectedListOrder
      ..clear()
      ..add(widget.data);
    try {
      await logic.cancelOrder();
    } catch (e) {
      AppSnackBar.showError(message: e.toString());
    }
    Navigator.pop(context);
  }

  Future<void> changeOrder(ChangeOrderData data) async {
    try {
      await logic.changeOrder(widget.data, data);
      Navigator.pop(context);
      AppSnackBar.showSuccess(message: S.of(context).change_order_successfully);
    } catch (e) {
      AppSnackBar.showError(message: e.toString());
    }
  }
}
