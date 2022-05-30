import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/model/entities/cash_can_adv.dart';
import 'package:sbsi/ui/pages/cash_can_adv/cash_can_adv_logic.dart';
import 'package:sbsi/ui/pages/cash_can_adv/widget/confirm_cash.dart';
import 'package:sbsi/ui/widgets/button/button_filled.dart';
import 'package:sbsi/utils/money_utils.dart';
import 'package:sbsi/utils/validator.dart';

import '../../../../common/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../commons/money_text_controller.dart';
import '../../../widgets/textfields/app_text_field.dart';

class CashCanWidget extends StatefulWidget {
  final CashCanAdv cash;
  final int index;

  const CashCanWidget({Key? key, required this.cash, required this.index})
      : super(key: key);

  @override
  State<CashCanWidget> createState() => _CashCanWidgetState();
}

class _CashCanWidgetState extends State<CashCanWidget> with Validator {
  bool _isExpanded = false;
  final state = Get.find<CashCanAdvLogic>().state;

  final moneyController = MoneyMaskedTextController(
    thousandSeparator: ',',
    rightSymbol: "",
    decimalSeparator: "",
    precision: 0,
  );

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final caption = Theme.of(context).textTheme.caption;
    return Container(
      padding: const EdgeInsets.only(left: 18, top: 10, bottom: 10),
      decoration: BoxDecoration(
          color: _isExpanded
              ? const Color.fromRGBO(221, 221, 221, 1)
              : (widget.index % 2 == 0
                  ? const Color.fromRGBO(247, 247, 247, 1)
                  : AppColors.white)),
      child: Row(
        children: [
          Expanded(
              flex: 117,
              child: Text(
                widget.cash.cSELLDATE ?? "",
                style: caption,
              )),
          Expanded(
              flex: 170,
              child: Text(
                MoneyFormat.formatMoneyRound('${widget.cash.cWITHDRAWABLE}'),
                style: caption?.copyWith(fontWeight: FontWeight.w700),
              )),
          Expanded(
              flex: 80,
              child: Row(
                children: [
                  Flexible(
                    flex: 59,
                    child: SizedBox(
                      height: 30,
                      child: ButtonFill(
                        voidCallback: () {
                          state.pinController.clear();
                          orderNew(widget.cash);
                        },
                        title: S.of(context).action,
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            textStyle: caption,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(2),
                              ),
                            ),
                            primary: AppColors.active),
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 21,
                  )
                ],
              )),
        ],
      ),
    );
  }

  void orderNew(CashCanAdv right) {
    Get.dialog(Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: Builder(builder: (context) {
        final body2 = Theme.of(context).textTheme.bodyText2;
        final body1 = Theme.of(context).textTheme.bodyText1;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Text(
                S.of(context).advance_money,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).sell_day,
                    style: body2?.copyWith(color: AppColors.textSecond),
                  ),
                  Text(
                    right.cSELLDATE ?? "",
                    style: body1?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Ngày tiền về",
                    style: body2?.copyWith(color: AppColors.textSecond),
                  ),
                  Text(
                    right.cDUEDATE ?? "",
                    style: body1?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Số tiền bán",
                    style: body2?.copyWith(color: AppColors.textSecond),
                  ),
                  Text(
                    MoneyFormat.formatMoneyRound("${right.cWITHDRAWBLEMAX}"),
                    style: body1?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Form(
                key: formKey,
                child: AppTextFieldWidget(
                  validator: (money) => checkMoney1(
                      moneyController.numberValue.toInt(),
                      right.cWITHDRAWBLEMAX!.toInt()),
                  hintText: S.of(context).money_payment,
                  inputController: moneyController,
                ),
              ),
              const SizedBox(height: 20),
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
                            if (!formKey.currentState!.validate()) {
                              return;
                            }
                            Get.to(ConfirmCashPage(
                              money: '${moneyController.numberValue.toInt()}',
                              cash: widget.cash,
                            ))!
                                .then((value) {
                              Get.back();
                            });
                          },
                          title: S.of(context).confirm))
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      }),
    ));
  }
}
