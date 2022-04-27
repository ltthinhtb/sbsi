import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/model/stock_company_data/stock_company_data.dart';
import 'package:sbsi/ui/pages/stock_order/stock_order_logic.dart';
import 'package:sbsi/ui/pages/stock_order/stock_order_state.dart';
import 'package:sbsi/utils/money_utils.dart';
import 'package:sbsi/utils/order_utils.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/button/button_filled.dart';
import '../../../widgets/textfields/appTextFieldNumber.dart';
import '../../../widgets/textfields/app_text_typehead.dart';

class StockCashBalance extends StatelessWidget {
  const StockCashBalance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = Get.find<StockOrderLogic>().state;
    var logic = Get.find<StockOrderLogic>();
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
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      S.of(context).maxVolumeSellBuy,
                      style: bodyText2,
                    ),
                  ),
                  Text(
                    MoneyFormat.formatMoneyRound(
                        cashBalance.volumeAvaiable ?? ""),
                    style: bodyText2?.copyWith(
                        fontWeight: FontWeight.w700, color: AppColors.active),
                  ),
                  const SizedBox(
                    child: VerticalDivider(
                      color: AppColors.divider,
                      thickness: 1,
                    ),
                    height: 13,
                  ),
                  Text(
                    MoneyFormat.formatMoneyRound(cashBalance.balance ?? ""),
                    style: bodyText2?.copyWith(
                        fontWeight: FontWeight.w700, color: AppColors.deActive),
                  ),
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
                    minus: () {
                      /// bước nhảy step giá
                      checkNullPrice();
                      var step = state.selectedStockInfo.value.stepPrice!;
                      var value = state.priceController.numberValue;
                      if (value > step) {
                        state.priceController.updateValue(value - step);
                      }
                    },
                    plus: () {
                      /// bước nhảy step giá
                      checkNullPrice();
                      var step = state.selectedStockInfo.value.stepPrice!;
                      var value = state.priceController.numberValue;
                      state.priceController.updateValue(value + step);
                    },
                  )),
                  const SizedBox(width: 16),
                  Expanded(
                      child: AppTextFieldNumber(
                    inputController: state.volController,
                    hintText: S.of(context).volume_short,
                    minus: () {
                      /// bước nhảy step Khối lượng
                      var step = 100;
                      var value = state.volController.numberValue;
                      if (value > step) {
                        state.volController.updateValue(value - step);
                      }
                    },
                    plus: () {
                      /// bước nhảy step Khối lượng
                      var step = 100;
                      var value = state.volController.numberValue;
                      state.volController.updateValue(value + step);
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
                    child: ButtonFill(
                      title: S.of(context).buy,
                      voidCallback: () {
                        if (validate(state, true))
                          logic.requestNewOrder(isBuy: true);
                      },
                      style: ElevatedButton.styleFrom().copyWith(
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.active)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ButtonFill(
                      title: S.of(context).sell,
                      voidCallback: () {
                        if (validate(state, false))
                          logic.requestNewOrder(isBuy: false);
                      },
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

  bool validate(StockOrderState state, bool isBuy) {
    var checkPrice = OrderUtils.checkPrice(state.selectedStockInfo.value,
        price: state.priceController.text);
    var checkVol = OrderUtils.checkVol(state.selectedStockInfo.value,
        vol: state.volController.numberValue,
        isBuy: isBuy,
        cashBalance: state.selectedCashBalance.value);
    return checkPrice && checkVol;
  }

  void checkNullPrice() {
    /// nếu giá không có thì sẽ lấy giá tham lastPrice
    var state = Get.find<StockOrderLogic>().state;
    if (state.priceController.text.isEmpty || !parsePrice) {
      state.priceController.text =
          state.selectedStockInfo.value.lastPrice?.toStringAsFixed(2) ?? "";
    }
  }

  /// kiểm tra xem có khác phiên LO không nếu parse đc giá là phiên LO
  bool get parsePrice {
    try {
      var state = Get.find<StockOrderLogic>().state;
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
