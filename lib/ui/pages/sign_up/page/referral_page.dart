import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/ui/commons/appbar.dart';
import 'package:sbsi/ui/widgets/button/button_filled.dart';
import 'package:sbsi/ui/widgets/textfields/app_text_field.dart';

import '../../../../generated/l10n.dart';
import '../sign_up_logic.dart';
import 'create_account.dart';

class ReferralPage extends StatefulWidget {
  const ReferralPage({Key? key}) : super(key: key);

  @override
  State<ReferralPage> createState() => _ReferralPageState();
}

class _ReferralPageState extends State<ReferralPage> {
  final logic = Get.put(SignUpLogic());
  final state = Get.find<SignUpLogic>().state;

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
    return Scaffold(
      appBar: AppBarCustom(
        title: S.of(context).enter_referral_code,
        isCenter: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Vui lòng nhập Mã giới thiệu/\nBrokerID',
                style: headline6?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Nếu không có mã vui lòng nhấn tiếp tục để tiến hành mở tài khoản giao dịch',
                style: headline6?.copyWith(
                    fontSize: 16, color: AppColors.textSecond, height: 24 / 16),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AppTextFieldWidget(
                inputController: state.referralController,
                hintText: S.of(context).referral_code,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AppTextFieldWidget(
                inputController: state.referralNameController,
                hintText: 'Tên người giới thiệu/nhân viên môi giới',
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ButtonFill(
                      voidCallback: () {
                        Get.to(const CreateAccount());
                      },
                      title: S.of(context).continue_step)),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
