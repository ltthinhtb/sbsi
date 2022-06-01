import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_text_styles.dart';
import 'package:sbsi/ui/commons/appbar.dart';
import 'package:sbsi/utils/stock_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../stock_order_detail_logic.dart';

class StockOrderPageConfirm extends StatefulWidget {
  const StockOrderPageConfirm({
    Key? key,
  }) : super(key: key);

  @override
  _StockOrderPageConfirmState createState() => _StockOrderPageConfirmState();
}

class _StockOrderPageConfirmState extends State<StockOrderPageConfirm> {
  final state = Get.find<StockOrderPageLogic>().state;

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const AppBarCustom(
        title: "Xác nhận lệnh mua",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            buildInfo("Số tài khoản", state.selectedCashBalance.value.accCode!),
            buildInfo("Loại lệnh", state.isBuy.value ? "Mua" : "Bán"),
            buildInfo("Mã CK", state.selectedStockInfo.value.sym!),
            buildInfo("Giá", state.priceController.text),
            buildInfo(
              "Khối lượng",
              StockUtil.formatVol(
                double.parse(state.volController.text.replaceAll(",", "")),
              ),
            ),
            const Divider(
              height: 20,
              thickness: 1,
            ),
            buildInfo(
                "Giá trị lệnh đặt\n(Chưa bao gồm phí và thuế)",
                StockUtil.formatMoney((double.tryParse(state
                                .priceController.text
                                .replaceAll(",", "")) ??
                            state.selectedStockInfo.value.lastPrice ??
                            0) *
                        double.parse(
                            state.volController.text.replaceAll(",", "")) *
                        1000) +
                    " VND",
                valueColor: AppColors.green),
          ],
        ),
      ),
      floatingActionButton: MaterialButton(
        minWidth: width - 30,
        height: 50,
        color: AppColors.primary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        onPressed: () {
          Get.back(result: true);
        },
        child: Text(
          "Xác nhận",
          style: AppTextStyle.H5Bold.copyWith(color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildInfo(String label, String value, {Color? valueColor}) {
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
              style: AppTextStyle.bodyText2.copyWith(color: valueColor),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
