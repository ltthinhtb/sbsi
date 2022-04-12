import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_text_styles.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/ui/commons/appbar.dart';
import 'package:sbsi/ui/pages/menu/panel/cust_info/cust_info_logic.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomInfo extends StatefulWidget {
  const CustomInfo({
    Key? key,
  }) : super(key: key);

  @override
  _CustomInfoState createState() => _CustomInfoState();
}

class _CustomInfoState extends State<CustomInfo> {
  final logic = Get.put(CustomInfoLogic());
  final state = Get.find<CustomInfoLogic>().state;
  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<CustomInfoLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: S.of(context).account_info,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            buildHeader(S.of(context).profile_info),
            buildInfo(
                S.of(context).account, state.accountInfo.cACCOUNTCODE ?? ""),
            buildInfo(
                S.of(context).full_name, state.accountInfo.cACCOUNTNAME ?? ""),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(String label) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: AppTextStyle.H4Bold,
      ),
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
}
