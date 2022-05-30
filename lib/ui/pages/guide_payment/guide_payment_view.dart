import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_images.dart';
import 'package:sbsi/ui/commons/appbar.dart';

import '../../../generated/l10n.dart';
import 'guide_payment_logic.dart';

class GuidePaymentPage extends StatefulWidget {
  const GuidePaymentPage({Key? key}) : super(key: key);

  @override
  _GuidePaymentPageState createState() => _GuidePaymentPageState();
}

class _GuidePaymentPageState extends State<GuidePaymentPage> {
  final logic = Get.put(GuidePaymentLogic());
  final state = Get.find<GuidePaymentLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: S.of(context).payment_guide,isCenter: true,),
      body: Column(
        children: [
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              // Get.to(
              //     WebViewPage(
              //         appBar: customAppBar("Nộp tiền nhanh định danh"),
              //         url: 'https://opacc-api.apec.com.vn/documents/HDNT/DD.html'));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  SvgPicture.asset('assets/icon_svg/user-circle.svg'),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      'Nộp tiền nhanh định danh',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  SvgPicture.asset(AppImages.vector)
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
           //   Get.to(TransferNormal());
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  SvgPicture.asset('assets/icon_svg/user-circle.svg'),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      'Nộp tiền thông thường',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  SvgPicture.asset(AppImages.vector)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<GuidePaymentLogic>();
    super.dispose();
  }
}