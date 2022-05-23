import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pinput/pinput.dart';

import '../../../../common/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../commons/appbar.dart';
import '../../../widgets/button/button_filled.dart';
import '../../otp/count_down.dart';
import '../sign_up_logic.dart';
import 'verify_account.dart';

class OtpValidate extends StatefulWidget {
  const OtpValidate({Key? key}) : super(key: key);

  @override
  State<OtpValidate> createState() => _OtpValidateState();
}

class _OtpValidateState extends State<OtpValidate> {
  final logic = Get.put(SignUpLogic());
  final state = Get.find<SignUpLogic>().state;

  final formKeyPIN = GlobalKey<FormState>();

  final FocusNode pinPutFocusNode = FocusNode();

  final ValueNotifier<bool> check = ValueNotifier<bool>(false);

  final pinController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
    final body2 = Theme.of(context).textTheme.bodyText2;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarCustom(
        title: S.of(context).create_account,
        isCenter: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearPercentIndicator(
              width: MediaQuery.of(context).size.width,
              progressColor: AppColors.yellowStatus,
              backgroundColor: Colors.grey[300],
              lineHeight: 5,
              percent: 0.2,
              padding: EdgeInsets.zero,
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Bước 1: Tạo tài khoản',
                style: headline6?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Mã OTP đã được gửi qua số điện thoại ${state.phoneController.text.replaceRange(0, 7, "*** *** ")}',
                style: headline6?.copyWith(
                    fontSize: 16,
                    height: 24 / 16,
                    color: const Color.fromRGBO(146, 146, 146, 1)),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: formKeyPIN,
                child: Pinput(
                  onChanged: (value) {
                    onRequestCheck();
                  },
                  onSubmitted: (text) {
                    onRequestCheck();
                  },
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  focusNode: pinPutFocusNode,
                  controller: pinController,
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: TimeCountDown(
                duration: const Duration(seconds: 30),
                textStyle: body2!.copyWith(color: AppColors.primary),
                voidCallback: () {},
              ),
            ),
            const Spacer(),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ValueListenableBuilder<bool>(
                    builder: (context, value, child) {
                      return ButtonFill(
                          voidCallback: value ? () {
                            Get.to(const VerifyAccount());
                          } : null,
                          title: S.of(context).continue_step);
                    },
                    valueListenable: check,
                  ),
                )),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void onRequestCheck() {
    if (pinController.text.length < 6) {
      check.value = false;
    } else {
      check.value = true;
    }
  }

  final defaultPinTheme = PinTheme(
    height: 60,
    textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: AppColors.whiteEEE,
      borderRadius: BorderRadius.circular(5),
    ),
  );
}
