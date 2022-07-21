import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_images.dart';
import 'package:sbsi/ui/pages/sign_up/sign_up_logic.dart';
import 'package:sbsi/ui/widgets/button/button_filled.dart';

import '../../../../generated/l10n.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  final state = Get.find<SignUpLogic>().state;

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
    final body1 = Theme.of(context).textTheme.bodyText1;
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 68),
          SvgPicture.asset(AppImages.tick_success),
          // const SizedBox(height: 40),
          // Text(
          //   "Mở tài khoản thành công",
          //   style: headline6?.copyWith(fontWeight: FontWeight.w700),
          // ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: 'Cảm ơn quý khách ',
                    style: body1?.copyWith(color: AppColors.textGrey4)),
                TextSpan(
                    text: state.orcResponse?.name ?? "",
                    style: body1?.copyWith(
                        color: AppColors.primary, fontWeight: FontWeight.w700)),
                TextSpan(
                    text: " đã lựa chọn dịch vụ của Công ty chứng khoán SBSI.",
                    style: body1?.copyWith(color: AppColors.textGrey4))
              ], style: body1),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Số tài khoản của quý khách là:",
            style: body1?.copyWith(fontWeight: FontWeight.w700),
          ),
          Text(
            state.accountCode,
            style: body1?.copyWith(
                fontWeight: FontWeight.w700, color: AppColors.primary),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Quý khách vui lòng kiểm tra lại Email đã đăng ký để hoàn thiện thủ tục mở tài khoản. Mọi thắc mắc xin liên hệ: (024) 33776699",
              textAlign: TextAlign.center,
              style: body1?.copyWith(color: AppColors.primary),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: ButtonFill(
                      style: ElevatedButton.styleFrom(
                          onPrimary: AppColors.primary,
                          primary: const Color.fromRGBO(255, 238, 238, 1)),
                      voidCallback: () {
                        Navigator.popUntil(
                            context, (Route<dynamic> route) => route.isFirst);
                      },
                      title: "Hoàn tất"),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ButtonFill(
                      voidCallback: () {
                        Navigator.popUntil(
                            context, (Route<dynamic> route) => route.isFirst);
                      },
                      title: S.of(context).sign_in),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32)
        ],
      ),
    );
  }
}
