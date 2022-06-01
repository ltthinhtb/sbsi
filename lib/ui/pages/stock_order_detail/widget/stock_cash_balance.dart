import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/model/stock_company_data/stock_company_data.dart';

import 'package:sbsi/ui/widgets/textfields/app_text_field.dart';
import 'package:sbsi/utils/money_utils.dart';
import 'package:sbsi/utils/order_utils.dart';
import 'package:sbsi/utils/validator.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/debouncer.dart';
import '../../../widgets/button/button_filled.dart';
import '../../../widgets/textfields/appTextFieldNumber.dart';
import '../../../widgets/textfields/app_text_typehead.dart';
import '../stock_order_detail_logic.dart';
import '../stock_order_detail_state.dart';

class StockCashBalance extends StatefulWidget {
  const StockCashBalance({Key? key}) : super(key: key);

  @override
  State<StockCashBalance> createState() => _StockCashBalanceState();
}

class _StockCashBalanceState extends State<StockCashBalance> with Validator {
  final _debouncer = Debouncer(milliseconds: 500);

  var state = Get.find<StockOrderPageLogic>().state;
  var logic = Get.find<StockOrderPageLogic>();

  @override
  Widget build(BuildContext context) {
    final bodyText2 = Theme.of(context).textTheme.bodyText1;
    return Obx(() {
      var cashBalance = state.selectedCashBalance.value;
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration:
            const BoxDecoration(color: AppColors.PastelSecond2, boxShadow: [
          const BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), blurRadius: 4),
          const BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), blurRadius: 20)
        ]),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 20),
              child: AppTextTypeHead<StockCompanyData>(
                key: state.searchCKKey,
                hintText: S.of(context).stock_code,
                inputController: state.stockController,
                focusNode: state.stockNode,
                suggestionsCallback: (String pattern) {
                  return logic.searchStock(pattern);
                },
                onSuggestionSelected: (suggestion) {
                  return logic.selectStock(suggestion);
                },
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).pp_1,
                    style: bodyText2,
                  ),
                  Text(
                    cashBalance.ppAccount,
                    style: bodyText2?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).mr,
                    style: bodyText2,
                  ),
                  Text(
                    "-",
                    style: bodyText2?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 16),
            // Padding(
            //   padding: const EdgeInsets.only(left: 15, right: 20),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: Text(
            //           S.of(context).maxVolumeSellBuy,
            //           style: bodyText2,
            //         ),
            //       ),
            //       Text(
            //         MoneyFormat.formatMoneyRound(
            //             cashBalance.volumeAvaiable ?? ""),
            //         style: bodyText2?.copyWith(
            //             fontWeight: FontWeight.w700, color: AppColors.active),
            //       ),
            //       const SizedBox(
            //         child: VerticalDivider(
            //           color: AppColors.divider,
            //           thickness: 1,
            //         ),
            //         height: 13,
            //       ),
            //       Text(
            //         MoneyFormat.formatMoneyRound(cashBalance.balance ?? ""),
            //         style: bodyText2?.copyWith(
            //             fontWeight: FontWeight.w700, color: AppColors.deActive),
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tổng giá trị",
                    style: bodyText2,
                  ),
                  ValueListenableBuilder<num>(
                      valueListenable: state.total,
                      builder: (context, value, child) {
                        return Text(
                          MoneyFormat.formatMoneyRound('${value}'),
                          style:
                              bodyText2?.copyWith(fontWeight: FontWeight.w700),
                        );
                      }),
                ],
              ),
            ),
            const SizedBox(height: 23),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                      child: AppTextFieldNumber(
                    focusNode: state.priceNode,
                    inputController: state.priceController,
                    hintText: S.of(context).price,
                    onChanged: (value) {
                      _debouncer.run(() {
                        logic.getCashBalance();
                        logic.changeTotal();
                      });
                    },
                    minus: () {
                      /// bước nhảy step giá
                      checkNullPrice();
                      var step = state.selectedStockInfo.value.stepPrice!;
                      var value = state.priceController.numberValue;
                      if (value > step) {
                        // đổi thành phiên LO
                        state.tradingOrder.value = "LO";
                        state.priceController.updateValue(value - step);
                        logic.getCashBalance();
                        logic.changeTotal();
                      }
                    },
                    plus: () {
                      /// bước nhảy step giá
                      checkNullPrice();
                      // đổi thành phiên LO
                      state.tradingOrder.value = "LO";
                      var step = state.selectedStockInfo.value.stepPrice!;
                      var value = state.priceController.numberValue;
                      state.priceController.updateValue(value + step);
                      logic.getCashBalance();
                      logic.changeTotal();
                    },
                  )),
                  const SizedBox(width: 16),
                  Expanded(
                      child: AppTextFieldNumber(
                    inputController: state.volController,
                    hintText: S.of(context).volume_short,
                    onChanged: (value) {
                      logic.changeTotal();
                    },
                    minus: () {
                      /// bước nhảy step Khối lượng
                      var step = 100;
                      var value = state.volController.numberValue;
                      if (value > step) {
                        state.volController.updateValue(value - step);
                        logic.changeTotal();
                      }
                    },
                    plus: () {
                      /// bước nhảy step Khối lượng
                      var step = 100;
                      var value = state.volController.numberValue;
                      state.volController.updateValue(value + step);
                      logic.changeTotal();
                    },
                  )),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          primary: AppColors.active),
                      onPressed: () {
                        state.pinController.clear();
                        if (validate(state, true)) {
                          orderNew(isBuy: true);
                        }
                      },
                      child: Column(
                        children: [
                          Text(S.of(context).buy),
                          Text(
                            '(${MoneyFormat.formatMoneyRound(cashBalance.volumeAvaiable ?? "")})',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(color: AppColors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 2)),
                      onPressed: () {
                        state.pinController.clear();
                        if (validate(state, false)) {
                          orderNew(isBuy: false);
                        }
                      },
                      child: Column(
                        children: [
                          Text(S.of(context).sell),
                          Text(
                            '(${MoneyFormat.formatMoneyRound(cashBalance.balance ?? "")})',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(color: AppColors.white),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  void orderNew({required bool isBuy}) {
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
                S.of(context).order,
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
                    state.selectedStockInfo.value.sym ?? "",
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
                    isBuy ? S.of(context).buy : S.of(context).sell,
                    style: body1?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: isBuy ? AppColors.active : AppColors.deActive),
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
                    state.priceController.text,
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
                    state.volController.text,
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
                            logic.requestNewOrder(isBuy: isBuy);
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

  bool validate(StockOrderPageState state, bool isBuy) {
    var checkPrice = true;
    if (state.tradingOrder.value == "LO")
      checkPrice = OrderUtils.checkPrice(state.selectedStockInfo.value,
          price: state.priceController.text);
    var checkVol = OrderUtils.checkVol(state.selectedStockInfo.value,
        vol: state.volController.numberValue,
        isBuy: isBuy,
        cashBalance: state.selectedCashBalance.value);
    return checkPrice && checkVol;
  }

  void checkNullPrice() {
    /// nếu giá không có thì sẽ lấy giá tham lastPrice
    var state = Get.find<StockOrderPageLogic>().state;
    if (state.priceController.text.isEmpty || !parsePrice) {
      state.priceController.text =
          state.selectedStockInfo.value.lastPrice?.toStringAsFixed(2) ?? "";
    }
  }

  /// kiểm tra xem có khác phiên LO không nếu parse đc giá là phiên LO
  bool get parsePrice {
    try {
      var state = Get.find<StockOrderPageLogic>().state;
      double.parse(state.priceController.text);
      return true;
    } catch (e) {
      return false;
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
}
