import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/model/entities/cash_can_adv.dart';
import 'package:sbsi/ui/commons/appbar.dart';
import 'package:sbsi/ui/pages/cash_can_adv/cash_can_adv_logic.dart';
import 'package:sbsi/utils/money_utils.dart';
import 'package:sbsi/utils/validator.dart';

import '../../../../generated/l10n.dart';
import '../../../widgets/button/button_filled.dart';
import '../../../widgets/textfields/app_text_field.dart';

class ConfirmCashPage extends StatefulWidget {
  final String money;

  final CashCanAdv cash;

  const ConfirmCashPage({Key? key, required this.money, required this.cash})
      : super(key: key);

  @override
  State<ConfirmCashPage> createState() => _ConfirmCashPageState();
}

class _ConfirmCashPageState extends State<ConfirmCashPage> with Validator {
  final state = Get.find<CashCanAdvLogic>().state;
  final logic = Get.find<CashCanAdvLogic>();

  @override
  void initState() {
    // lấy thông tin phí
    logic.getFeeWithDraw(
        sellDate: widget.cash.cSELLDATE ?? "",
        dueDate: widget.cash.cDUEDATE ?? "",
        money: widget.money);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
    final headline5 = Theme.of(context).textTheme.headline5;

    return Scaffold(
      appBar: AppBarCustom(
        title: S.of(context).advance_money,
      ),
      backgroundColor: AppColors.whiteBack,
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
                  MoneyFormat.formatMoneyRound('${widget.money}') + " VNĐ",
                  style: headline5?.copyWith(
                      fontWeight: FontWeight.w700, fontSize: 26),
                ),
              ),
              const SizedBox(height: 16),
              Obx(() {
                return ColumnText(
                    S.of(context).transfer_cFee,
                    MoneyFormat.formatMoneyRound(
                        '${state.feeWithDraw.value.cFEEVALUE}'));
              }),
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
                                        key: state.formPin,
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
                                                primary: const Color.fromRGBO(
                                                    255, 238, 238, 1)),
                                          )),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                              child: ButtonFill(
                                                  voidCallback: () {
                                                    if (!state
                                                        .formPin.currentState!
                                                        .validate()) return;
                                                    logic.updateShareTransferIn(
                                                        dueDate: widget.cash
                                                                .cDUEDATE ??
                                                            "",
                                                        sellDtate: widget.cash
                                                                .cSELLDATE ??
                                                            "",
                                                        money:
                                                            '${widget.money}');
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
