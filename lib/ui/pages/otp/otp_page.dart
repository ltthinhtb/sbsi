import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/model/params/data_params.dart';
import 'package:sbsi/networks/error_exception.dart';
import 'package:sbsi/services/api/api_service.dart';
import 'package:sbsi/services/auth_service.dart';
import 'package:sbsi/ui/commons/app_snackbar.dart';
import 'package:sbsi/ui/commons/appbar.dart';
import 'package:sbsi/ui/widgets/button/button_filled.dart';

import '../../../generated/l10n.dart';
import '../../../model/params/index.dart';
import 'count_down.dart';

class OtpPage extends StatefulWidget {
  final VoidCallback onRequest;
  final TextEditingController pinPutController;
  final String phone;
  final bool? isGetOtp;
  final VoidCallback? getBackOtp;

  const OtpPage(
      {Key? key,
      required this.onRequest,
      required this.pinPutController,
      required this.phone,
      this.isGetOtp = true,
      this.getBackOtp})
      : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final formKeyPIN = GlobalKey<FormState>();

  final FocusNode pinPutFocusNode = FocusNode();

  final ValueNotifier<bool> check = ValueNotifier<bool>(false);

  @override
  void initState() {
    if (widget.isGetOtp!) {
      getOtp();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
    final body2 = Theme.of(context).textTheme.bodyText2;

    return Scaffold(
      appBar: AppBarCustom(
        title: S.of(context).confirm_payment,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('Xác thực số điện thoại',
                style: headline6?.copyWith(
                    fontWeight: FontWeight.w700, height: 24 / 20)),
          ),
          const SizedBox(height: 16),

          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   child: Text(
          //       'Mã OTP đã được gửi qua số điện thoại ${widget.phone.replaceRange(0, 7, "*** *** ")}',
          //       style: body2?.copyWith(
          //           fontWeight: FontWeight.w600,
          //           height: 20 / 14,
          //           color: const Color.fromRGBO(146, 146, 146, 1))),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('Mã OTP đã được gửi qua số điện thoại',
                style: body2?.copyWith(
                    fontWeight: FontWeight.w600,
                    height: 20 / 14,
                    color: const Color.fromRGBO(146, 146, 146, 1))),
          ),
          const SizedBox(height: 24),
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
                controller: widget.pinPutController,
                length: 6,
                defaultPinTheme: defaultPinTheme,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: TimeCountDown(
              voidCallback: () {
                if (!widget.isGetOtp!) {
                  widget.getBackOtp;
                } else {
                  getOtp();
                }
              },
              duration: const Duration(seconds: 30),
              textStyle: body2!.copyWith(color: AppColors.primary),
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
                        voidCallback: value
                            ? () {
                                widget.onRequest();
                              }
                            : null,
                        title: S.of(context).confirm);
                  },
                  valueListenable: check,
                ),
              )),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  void onRequestCheck() {
    if (widget.pinPutController.text.length < 6) {
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

  Future<void> getOtp() async {
    var token = Get.find<AuthService>().token.value;
    var param = RequestParams(
        group: "S",
        user: token?.data?.user ?? "",
        session: token?.data?.sid ?? "",
        data: ParamsObject(type: "string", cmd: "GetOTP"));

    try {
      await Get.find<ApiService>().getOtp(param);
    } on ErrorException catch (e) {
      AppSnackBar.showError(message: e.message);
    } catch (e) {}
  }
}
