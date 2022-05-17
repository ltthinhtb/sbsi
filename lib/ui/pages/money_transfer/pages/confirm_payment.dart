import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/networks/error_exception.dart';
import 'package:sbsi/ui/commons/appbar.dart';
import 'package:sbsi/ui/pages/money_transfer/enums/transfer_type.dart';
import 'package:sbsi/ui/pages/otp/otp_page.dart';
import 'package:sbsi/ui/widgets/button/button_filled.dart';
import 'package:sbsi/ui/widgets/textfields/app_text_field.dart';
import 'package:sbsi/utils/validator.dart';

import '../../../../common/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../commons/app_snackbar.dart';
import '../money_transfer_logic.dart';

class ConfirmPayment extends StatefulWidget {
  final String title;

  const ConfirmPayment({Key? key, required this.title}) : super(key: key);

  @override
  State<ConfirmPayment> createState() => _ConfirmPaymentState();
}

class _ConfirmPaymentState extends State<ConfirmPayment> with Validator {
  final state = Get.find<MoneyTransferLogic>().state;
  final logic = Get.find<MoneyTransferLogic>();

  String get receiver => widget.title == TransfersType.bank.name
      ? state.userNameController.text
      : (state.accountReceiver.value.accName ?? "");

  String get account => widget.title == TransfersType.bank.name
      ? state.userAccountController.text
      : (state.accountReceiver.value.accCode ?? "");

  get onSubmit => widget.title == TransfersType.bank.name
      ? logic.updateCashTransferOnline()
      : logic.updateCashTransferInternal();

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
    return Scaffold(
      appBar: AppBarCustom(
        title: widget.title,
        isCenter: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Center(
                child: Text(
                  S.of(context).money_payment,
                  style: headline6?.copyWith(height: 24 / 20),
                ),
              ),
              const SizedBox(height: 16),
              ColumnText(S.of(context).transfer_cFee, "10,000 VNĐ"),
              const SizedBox(height: 16),
              ColumnText(S.of(context).account_receiver, receiver),
              const SizedBox(height: 4),
              Text(
                account,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(height: 20 / 14),
              ),
              const SizedBox(height: 16),
              ColumnText(S.of(context).content_transfer,
                  state.transferContentController.text),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                      child: ButtonFill(
                    voidCallback: () {},
                    title: S.of(context).cancel,
                    style: ElevatedButton.styleFrom(
                        onPrimary: AppColors.primary,
                        primary: const Color.fromRGBO(255, 238, 238, 1)),
                  )),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: ButtonFill(
                          voidCallback: () {
                            state.pinController.clear();
                            Get.dialog(
                                Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: (248 / 812) *
                                          MediaQuery.of(context).size.height),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        S.of(context).input_pin,
                                        style: headline6?.copyWith(
                                            fontWeight: FontWeight.w700,
                                            height: 24 / 20),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        S.of(context).please_input_pin_verify,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(height: 24 / 16),
                                      ),
                                      const SizedBox(height: 16),
                                      Form(
                                        key: state.pinKey,
                                        child: AppTextFieldWidget(
                                          hintText: S.of(context).input_pin,
                                          validator: (pin) => checkPin(pin!),
                                          inputController: state.pinController,
                                          obscureText: true,
                                        ),
                                      ),
                                      const SizedBox(height: 32),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: ButtonFill(
                                            voidCallback: () {
                                              Get.back();
                                            },
                                            title: S.of(context).cancel,
                                            style: ElevatedButton.styleFrom(
                                                onPrimary: AppColors.primary,
                                                primary: const Color.fromRGBO(
                                                    255, 238, 238, 1)),
                                          )),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                              child: ButtonFill(
                                                  voidCallback: () {
                                                    state.otpController.clear();
                                                    try {
                                                      logic.checkPin();
                                                      if (state.type ==
                                                          TransfersType.bank) {
                                                        Get.to(OtpPage(
                                                          onRequest: () {
                                                            onSubmit();
                                                          },
                                                          pinPutController: state
                                                              .otpController,
                                                          phone: "0349949866",
                                                        ));
                                                      }
                                                      else {
                                                        onSubmit();
                                                      }
                                                    } on ErrorException catch (e) {
                                                      AppSnackBar.showError(
                                                          message: e.message);
                                                    }
                                                  },
                                                  title: S.of(context).confirm))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                barrierDismissible: false);
                          },
                          title: S.of(context).confirm))
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget ColumnText(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
              color: const Color.fromRGBO(255, 137, 150, 1), height: 20 / 14),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(fontWeight: FontWeight.w700, height: 20 / 14),
        )
      ],
    );
  }
}
