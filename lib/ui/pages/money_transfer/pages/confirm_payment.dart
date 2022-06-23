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

  @override
  void initState() {
    logic.getCFeeOnline();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
    final headline5 = Theme.of(context).textTheme.headline5;

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
              Center(
                child: Text(
                  state.moneyController.text + "VNĐ",
                  style: headline5?.copyWith(
                      fontWeight: FontWeight.w700, fontSize: 26),
                ),
              ),
              // const SizedBox(height: 16),
              // Obx(() {
              //   // nếu chuyển nội bộ thì phí bằng 0
              //   if (state.type == TransfersType.internal) {
              //     state.cFeeOnline.value = 0.0;
              //   }
              //   return ColumnText(
              //       S.of(context).transfer_cFee,
              //       MoneyFormat.formatMoneyRound('${state.cFeeOnline.value}') +
              //           " đ");
              // }),
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
              Visibility(
                visible: state.type == TransfersType.bank,
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    state.bank.value.cBANKNAME ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(height: 20 / 14),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ColumnText(S.of(context).transfer_content,
                  state.transferContentController.text),
              const SizedBox(height: 16),
              ColumnText(S.of(context).fee_type,
                  S.of(context).fee_title),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                      child: ButtonFill(
                    voidCallback: () {
                      Get.back();
                    },
                    title: S.of(context).cancel_short,
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
                            createTransfer();
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

  void createTransfer() {
    final headline6 = Theme.of(context).textTheme.headline6;
    Get.dialog(
      Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        child: Builder(builder: (context) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  S.of(context).input_pin,
                  style: headline6?.copyWith(
                      fontWeight: FontWeight.w700, height: 24 / 20),
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
                      title: S.of(context).cancel_short,
                      style: ElevatedButton.styleFrom(
                          onPrimary: AppColors.primary,
                          primary: const Color.fromRGBO(255, 238, 238, 1)),
                    )),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: ButtonFill(
                            voidCallback: () async {
                              state.otpController.clear();
                              if (!state.pinKey.currentState!.validate())
                                return;
                              try {
                                // check pin ok then
                                await logic.checkPin();
                                // type transfer = bank
                                if (state.type == TransfersType.bank) {
                                  Get.to(OtpPage(
                                    onRequest: () {
                                      logic.updateCashTransferOnline();
                                    },
                                    pinPutController: state.otpController,
                                    phone: "0349949866",
                                    isGetOtp: true,
                                  ));
                                } else {
                                  // type transfer = internal
                                  logic.updateCashTransferInternal();
                                }
                              } on ErrorException catch (e) {
                                AppSnackBar.showError(message: e.message);
                              }
                            },
                            title: S.of(context).confirm))
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom)
              ],
            ),
          );
        }),
      ),
      barrierDismissible: false,
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
