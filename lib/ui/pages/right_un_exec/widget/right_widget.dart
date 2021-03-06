import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/model/entities/right_exc.dart';
import 'package:sbsi/ui/commons/app_snackbar.dart';
import 'package:sbsi/ui/pages/right_un_exec/right_un_exec_logic.dart';
import 'package:sbsi/ui/widgets/animation_widget/expanded_widget.dart';
import 'package:sbsi/ui/widgets/button/button_filled.dart';
import 'package:sbsi/ui/widgets/textfields/app_text_field.dart';
import 'package:sbsi/utils/money_utils.dart';
import 'package:sbsi/utils/validator.dart';

import '../../../../generated/l10n.dart';

class RightWidget extends StatefulWidget {
  final RightExc right;
  final int index;
  final bool? isMoney;

  const RightWidget(
      {Key? key,
      required this.right,
      required this.index,
      this.isMoney = false})
      : super(key: key);

  @override
  State<RightWidget> createState() => _RightWidgetState();
}

class _RightWidgetState extends State<RightWidget> with Validator {
  bool _isExpanded = false;

  final amountController = TextEditingController();

  ValueNotifier<num> amount = ValueNotifier<num>(0);

  final state = Get.find<RightUnExecLogic>().state;
  final logic = Get.find<RightUnExecLogic>();

  @override
  Widget build(BuildContext context) {
    final caption = Theme.of(context).textTheme.caption;
    final body2 = Theme.of(context).textTheme.caption;
    Logger().d(widget.right.toJson());
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 11, 16, 13),
            decoration: BoxDecoration(
                color: _isExpanded
                    ? const Color.fromRGBO(221, 221, 221, 1)
                    : (widget.index % 2 == 0
                        ? const Color.fromRGBO(247, 247, 247, 1)
                        : AppColors.white)),
            child: Row(
              children: [
                Expanded(
                    flex: 62,
                    child: Text(
                      widget.right.cSHARECODE ?? "",
                      style: caption?.copyWith(fontWeight: FontWeight.w700),
                    )),
                Expanded(
                    flex: 130,
                    child: Text(
                      MoneyFormat.formatMoneyRound(
                          '${widget.right.cRIGHTVOLUME}'),
                      style: caption,
                    )),
                Expanded(
                    flex: 53,
                    child: Text(
                      widget.isMoney!
                          ? '${widget.right.cCASHRECEIVERATE?.toStringAsFixed(0)}%'
                          : (widget.right.cRightRate),
                      style: caption,
                    )),
                Expanded(
                    flex: 94,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        (widget.right.cRIGHTTYPENAMEEN == "Right buy")
                            ? (widget.right.cCLOSEDATE ?? "")
                            : (widget.isMoney!
                                ? MoneyFormat.formatMoneyRound(
                                    '${widget.right.cCASHVOLUME}')
                                : MoneyFormat.formatMoneyRound(
                                    '${widget.right.cSHAREDIVIDENT}')),
                        style: caption,
                      ),
                    )),
              ],
            ),
          ),
        ),
        ExpandedSection(
          child: Container(
            decoration:
                const BoxDecoration(color: AppColors.whiteF7, boxShadow: [
              BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 10,
                  color: Color.fromRGBO(0, 0, 0, 0.08))
            ]),
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 12),
            child: Column(
              children: [
                Visibility(
                  visible: widget.right.cRIGHTTYPENAMEEN != "Right buy",
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).right_date, style: body2),
                        Text(
                          widget.right.cCLOSEDATE ?? "",
                          style: body2?.copyWith(fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.right.cRIGHTTYPENAMEEN != "Right buy",
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).due_date, style: body2),
                        Text(
                          widget.right.cDueDate,
                          style: body2?.copyWith(fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.right.cRIGHTTYPENAMEEN != "Right buy",
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).expected_implementation_date, style: body2),
                        Text(
                          widget.right.eXECUTEDATE1,
                          style: body2?.copyWith(fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.right.cRIGHTTYPENAMEEN == "Right buy",
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).start_day, style: body2),
                        Text(
                          widget.right.cREGISTERFROMDATE ?? "",
                          style: body2?.copyWith(fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.right.cRIGHTTYPENAMEEN == "Right buy",
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).end_day, style: body2),
                        Text(
                          widget.right.cREGISTERTODATE ?? "",
                          style: body2?.copyWith(fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.right.cRIGHTTYPENAMEEN == "Right buy",
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).price_buy, style: body2),
                        Text(
                          MoneyFormat.formatMoneyRound(
                              '${widget.right.cBUYPRICE}'),
                          style: body2?.copyWith(fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.right.cRIGHTTYPENAMEEN == "Right buy",
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).right_stock_units, style: body2),
                        Text(
                          MoneyFormat.formatMoneyRound(
                              '${widget.right.cRIGHTVOLUME}'),
                          style: body2?.copyWith(fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.right.cRIGHTTYPENAMEEN == "Right buy",
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).registered_units, style: body2),
                        Text(
                          MoneyFormat.formatMoneyRound(
                              '${widget.right.cSHAREBUY}'),
                          style: body2?.copyWith(fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.right.cRIGHTTYPENAMEEN == "Right buy",
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).amount_stock, style: body2),
                        Text(
                          MoneyFormat.formatMoneyRound(
                              '${widget.right.cSHARERIGHT}'),
                          style: body2?.copyWith(fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.right.showAction,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: Text("S??? l?????ng ????ng k??", style: body2)),
                        Flexible(
                          child: AppTextFieldWidget(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 22, vertical: 10),
                            inputController: amountController,
                            hintText: S.of(context).input_amount,
                            onChanged: (value) {
                              amount.value = amountController.numberValue *
                                  (widget.right.cBUYPRICE ?? 0);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.right.cRIGHTTYPENAMEEN == "Right buy",
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).price_1, style: body2),
                        Text(
                          MoneyFormat.formatMoneyRound(
                              '${widget.right.cCASHBUYALL}'),
                          style: body2?.copyWith(fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.right.cRIGHTTYPENAMEEN == "Right buy",
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).right_value, style: body2),
                        ValueListenableBuilder<num>(
                          valueListenable: amount,
                          builder: (context, value, child) {
                            return Text(
                              MoneyFormat.formatMoneyRound(
                                  value.toStringAsFixed(0)),
                              style:
                                  body2?.copyWith(fontWeight: FontWeight.w700),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.right.showAction,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ButtonFill(
                      voidCallback: () {
                        if (amountController.numberValue >
                            widget.right.cShareCL) {
                          AppSnackBar.showError(
                              message:
                                  'Kh???i l?????ng v?????t qu?? kh???i l?????ng ???????c mua');
                          return;
                        }
                        if (amountController.text.isEmpty) {
                          AppSnackBar.showError(message: 'Vui l??ng nh???p KL');
                          return;
                        }
                        state.pinController.clear();
                        orderNew(widget.right);
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 5)),
                      title: S.of(context).sign_up,
                    ),
                  ),
                )
              ],
            ),
          ),
          expand: _isExpanded,
        )
      ],
    );
  }

  void orderNew(RightExc right) {
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
                S.of(context).right_exc_register,
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
                    S.of(context).stock_code,
                    style: body2?.copyWith(color: AppColors.textSecond),
                  ),
                  Text(
                    right.cSHARECODE ?? "",
                    style: body1?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).volumn,
                    style: body2?.copyWith(color: AppColors.textSecond),
                  ),
                  Text(
                    amountController.text,
                    style: body1?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              AppTextFieldWidget(
                validator: (pin) => checkPin(pin!),
                hintText: S.of(context).input_pin,
                inputController: state.pinController,
                obscureText: true,
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
                            logic
                                .updateShareTransferIn(
                                    amount: '${amountController.text}',
                                    pkRight: right.pKRIGHTSTOCKINFO ?? "")
                                .then((value) {
                              amountController.clear();
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

extension TextControllerExt on TextEditingController {
  double get numberValue {
    try {
      return double.parse(text);
    } catch (e) {
      return 0;
    }
  }

  void updateValue(double value) {
    try {
      text = value.toStringAsFixed(2);
    } catch (e) {
      print(e.toString());
    }
  }
}
