import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:sbsi/model/order_data/inday_order.dart';
import 'package:sbsi/utils/validator.dart';

import '../../../../common/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/error_message.dart';
import '../../../widgets/button/button_filled.dart';
import '../../../widgets/textfields/appTextFieldNumber.dart';
import '../../../widgets/textfields/app_text_field.dart';
import '../stock_order_detail_logic.dart';

class NoteWidgetOrder extends StatefulWidget {
  final IndayOrder note;
  final int index;

  const NoteWidgetOrder({Key? key, required this.note, required this.index})
      : super(key: key);

  @override
  State<NoteWidgetOrder> createState() => _NoteWidgetOrderState();
}

class _NoteWidgetOrderState extends State<NoteWidgetOrder> with Validator {
  final TextEditingController pinController = TextEditingController();
  final logic = Get.find<StockOrderPageLogic>();

  final _pinController = TextEditingController();
  final priceController = TextEditingController();
  final volumeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final caption = Theme.of(context).textTheme.caption;
    return Slidable(
      enabled: MessageOrder.canEdit(widget.note),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            onPressed: (BuildContext context) {
              _pinController.clear();
              priceController.text = widget.note.showPrice ?? "";
              volumeController.text = widget.note.volume ?? "";
              editOrder(widget.note);
            },
            backgroundColor: const Color.fromRGBO(251, 122, 4, 1),
            foregroundColor: Colors.white,
            icon: null,
            label: 'Sửa lệnh',
          ),
          SlidableAction(
            onPressed: (BuildContext context) {
              _pinController.clear();
              cancelOrder(widget.note);
            },
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            icon: null,
            label: S.of(context).cancel_order,
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
            color: widget.index % 2 == 0 ? AppColors.table1 : AppColors.white),
        child: Row(
          children: [
            Expanded(
              flex: 73,
              child: Text(
                  widget.note.side == "B"
                      ? S.of(context).buy
                      : S.of(context).sell,
                  style: caption?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: widget.note.colorBack)),
            ),
            Expanded(
              flex: 80,
              child: Text(widget.note.symbol ?? "", style: caption),
            ),
            Expanded(
              flex: 61,
              child: Text(widget.note.showPrice ?? "",
                  style: caption?.copyWith(fontWeight: FontWeight.w700)),
            ),
            Expanded(
              flex: 61,
              child: Text(widget.note.volume ?? "",
                  style: caption?.copyWith(fontWeight: FontWeight.w400)),
            ),
            Expanded(
              flex: 57,
              child: Text(MessageOrder.getStatusOrder(widget.note),
                  style: caption?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: MessageOrder.getColorStatus(
                          MessageOrder.statusHuySua(widget.note)))),
            ),
          ],
        ),
      ),
    );
  }

  void cancelOrder(IndayOrder order) {
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
                S.of(context).cancel_order,
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
                    order.symbol ?? "",
                    style: body1?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).orderType,
                    style: body2?.copyWith(color: AppColors.textSecond),
                  ),
                  Text(
                    order.side == "B" ? S.of(context).buy : S.of(context).sell,
                    style: body1?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: order.side == "B"
                            ? AppColors.active
                            : AppColors.deActive),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).price,
                    style: body2?.copyWith(color: AppColors.textSecond),
                  ),
                  Text(
                    order.showPrice ?? "",
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
                    order.volume ?? "",
                    style: body1?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              AppTextFieldWidget(
                validator: (pin) => checkPin(pin!),
                hintText: S.of(context).input_pin,
                inputController: pinController,
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
                            logic.cancelOrder(order, pinController.text);
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

  void editOrder(IndayOrder order) {
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
                S.of(context).edit_note,
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
                    order.symbol ?? "",
                    style: body1?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).orderType,
                    style: body2?.copyWith(color: AppColors.textSecond),
                  ),
                  Text(
                    order.side == "B" ? S.of(context).buy : S.of(context).sell,
                    style: body1?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: order.side == "B"
                            ? AppColors.active
                            : AppColors.deActive),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      S.of(context).price,
                      style: body2?.copyWith(color: AppColors.textSecond),
                    ),
                  ),
                  Expanded(
                      child: AppTextFieldNumber(
                    inputController: priceController,
                    hintText: S.of(context).price,
                    backColor: AppColors.PastelSecond2,
                    minus: () {
                      checkNullPrice(order);
                      var value = priceController.numberValue;
                      value = value - 0.05;
                      priceController.updateValue(value);
                    },
                    plus: () {
                      checkNullPrice(order);
                      var value = priceController.numberValue;
                      value = value + 0.05;
                      priceController.updateValue(value);
                    },
                  ))
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      S.of(context).volumn,
                      style: body2?.copyWith(color: AppColors.textSecond),
                    ),
                  ),
                  Expanded(
                      child: AppTextFieldNumber(
                    inputController: volumeController,
                    hintText: S.of(context).volume,
                    backColor: AppColors.PastelSecond2,
                    minus: () {
                      checkNullVol();
                      var value = volumeController.numberValue;
                      value = value - 100;
                      volumeController.updateVol(value);
                    },
                    plus: () {
                      checkNullVol();
                      var value = volumeController.numberValue;
                      value = value + 100;
                      volumeController.updateVol(value);
                    },
                  ))
                ],
              ),
              const SizedBox(height: 20),
              AppTextFieldWidget(
                validator: (pin) => checkPin(pin!),
                hintText: S.of(context).input_pin,
                inputController: _pinController,
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
                            logic.changeOrder(
                                vol: volumeController.numberValue.toInt(),
                                data: order,
                                pinController: _pinController.text,
                                price: priceController.text);
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

  void checkNullPrice(IndayOrder indayOrder) {
    /// nếu giá không có thì sẽ lấy giá tham lastPrice
    if (priceController.text.isEmpty) {
      priceController.text = indayOrder.showPrice ?? "";
    }
  }

  void checkNullVol() {
    /// nếu khối lượng không có thì sẽ lấy giá 100
    if (volumeController.text.isEmpty) {
      volumeController.text = "100";
    }
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

  void updateVol(double value) {
    try {
      text = value.toStringAsFixed(0);
    } catch (e) {
      print(e.toString());
    }
  }
}
