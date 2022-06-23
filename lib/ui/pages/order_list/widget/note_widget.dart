import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/ui/pages/order_list/order_list_logic.dart';
import 'package:sbsi/utils/money_utils.dart';
import 'package:sbsi/utils/validator.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_images.dart';
import '../../../../generated/l10n.dart';
import '../../../../model/order_data/inday_order.dart';
import '../../../../utils/error_message.dart';
import '../../../widgets/button/button_filled.dart';
import '../../../widgets/textfields/appTextFieldNumber.dart';
import '../../../widgets/textfields/app_text_field.dart';

class NoteWidget extends StatefulWidget {
  const NoteWidget({Key? key, required this.listOrder, required this.index})
      : super(key: key);

  final IndayOrder listOrder;
  final int index;

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> with Validator {
  final state = Get.find<OrderListLogic>().state;
  final logic = Get.find<OrderListLogic>();

  ValueNotifier<bool> _isSelect = ValueNotifier<bool>(false);

  final _pinController = TextEditingController();
  final priceController = TextEditingController();
  final volumeController = TextEditingController();

  @override
  void initState() {
    // listen select all note
    state.isSelectAll.listen((p0) {
      _isSelect.value = p0;
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return buildItem(widget.listOrder);
  }

  Widget buildItem(IndayOrder data) {
    String _status = MessageOrder.getStatusOrder(data);
    final caption = Theme.of(context).textTheme.caption;
    return Slidable(
      enabled: MessageOrder.canEdit(data),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            onPressed: (context) {
              _pinController.clear();
              priceController.text = data.showPrice ?? "";
              volumeController.text = data.volume ?? "";
              editOrder(data);
            },
            backgroundColor: const Color.fromRGBO(251, 122, 4, 1),
            foregroundColor: Colors.white,
            icon: null,
            label: S.of(context).change_order,
          ),
          SlidableAction(
            onPressed: (BuildContext context) {
              _pinController.clear();
              cancelOrder(data);
            },
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            icon: null,
            label: S.of(context).cancel_order,
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 3),
        decoration: BoxDecoration(
            color: widget.index % 2 == 0 ? AppColors.whiteF7 : AppColors.white),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            !MessageOrder.canEdit(data)
                ? const SizedBox(width: 24)
                : GestureDetector(
                    onTap: () {
                      _isSelect.value = !_isSelect.value;
                      if (_isSelect.value) {
                        logic.addSelectOrder(data);
                      } else {
                        logic.removeSelectOrder(data);
                      }
                    },
                    child: ValueListenableBuilder<bool>(
                      valueListenable: _isSelect,
                      builder:
                          (BuildContext context, bool value, Widget? child) {
                        return SvgPicture.asset(
                          value ? AppImages.tickActive : AppImages.tick,
                          width: 24,
                        );
                      },
                    )),
            const SizedBox(width: 20),
            Expanded(
              flex: 96,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 16,
                        width: 16,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: data.colorBack,
                            borderRadius: BorderRadius.circular(4)),
                        child: Text(
                          data.sideString(context),
                          style: caption?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.white),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        data.symbol ?? "",
                        style: caption?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        "${data.orderTime ?? ""}",
                        style: caption,
                      ),
                      // const SizedBox(width: 1),
                      // Text(
                      //   _status,
                      //   style: caption?.copyWith(
                      //       color: MessageOrder.getColorStatus(
                      //           MessageOrder.statusHuySua(data))),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 96,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      MoneyFormat.formatMoneyRound('${data.volume}'),
                      style: caption?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      data.showPrice ?? "",
                      style: caption?.copyWith(
                          fontWeight: FontWeight.w400, color: data.colorBack),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 95,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      MoneyFormat.formatMoneyRound('${data.matchVolume}'),
                      style: caption?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${data.matchPrice}',
                      style: caption?.copyWith(
                          fontWeight: FontWeight.w400, color: data.colorBack),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 95,
              child: Align(
                alignment: Alignment.centerRight,
                child: Column(
                  children: [
                    Text(
                      '${data.reVolume}',
                      style: caption?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _status,
                      textAlign: TextAlign.center,
                      style: caption?.copyWith(
                          color: MessageOrder.getColorStatus(
                              MessageOrder.statusHuySua(data))),
                    ),
                  ],
                ),
              ),
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
                            logic.cancelOrder(order, _pinController.text);
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
