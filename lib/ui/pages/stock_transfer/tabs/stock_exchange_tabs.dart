import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/model/response/portfolio.dart';
import 'package:sbsi/ui/widgets/dropdown/app_drop_down.dart';
import 'package:sbsi/utils/money_utils.dart';

import '../../../../generated/l10n.dart';
import '../../../../model/response/list_account_response.dart';
import '../../../../services/auth_service.dart';
import '../../../../utils/validator.dart';
import '../../../widgets/button/button_filled.dart';
import '../../../widgets/textfields/app_text_field.dart';
import '../stock_transfer_logic.dart';

class StockExchangeTab extends StatefulWidget {
  const StockExchangeTab({Key? key}) : super(key: key);

  @override
  State<StockExchangeTab> createState() => _StockExchangeTabState();
}

class _StockExchangeTabState extends State<StockExchangeTab> with Validator {
  final logic = Get.put(StockTransferLogic());
  final state = Get.find<StockTransferLogic>().state;

  @override
  Widget build(BuildContext context) {
    final body1 = Theme.of(context).textTheme.bodyText1;
    return SingleChildScrollView(
        child: Column(
      children: [
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(color: AppColors.white, boxShadow: [
            BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 20,
                color: Color.fromRGBO(0, 0, 0, 0.05))
          ]),
          child: Column(
            children: [
              Obx(() {
                var listAccount = Get.find<AuthService>().listAccount;
                return AppDropDownWidget<Account>(
                  items: listAccount
                      .map((e) => DropdownMenuItem<Account>(
                          child: Text(e.accCode ?? ""), value: e))
                      .toList(),
                  value: (state.account.value.accCode?.isEmpty ?? true)
                      ? null
                      : state.account.value,
                  onChanged: (account) {
                    logic.changeAccount(account!);
                  },
                );
              }),
              const SizedBox(height: 16),
              Form(
                key: state.userReceiverKey,
                child: AppTextFieldWidget(
                  hintText: S.of(context).money_transfer,
                  inputController: state.userReceiverController,
                  focusNode: state.userReceiverFocus,
                  enableBorder: true,
                  readOnly: true,
                ),
              ),
              const SizedBox(height: 16),
              Obx(() {
                var listPortfolio = state.portfolioList;
                return AppDropDownWidget<PortfolioStatus>(
                  items: listPortfolio
                      .map((e) => DropdownMenuItem<PortfolioStatus>(
                          child: Text(e.symbol ?? ""), value: e))
                      .toList(),
                  hintText: S.of(context).stock_code,
                  value: (state.portfolio.value.symbol?.isEmpty ?? true)
                      ? null
                      : state.portfolio.value,
                  onChanged: (portfolio) {
                    logic.changePortfolio(portfolio!);
                  },
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(color: AppColors.white, boxShadow: [
            BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 20,
                color: Color.fromRGBO(0, 0, 0, 0.05))
          ]),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).availability_amount,
                    style: body1?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  Obx(() {
                    return Text(
                      MoneyFormat.formatMoneyRound(
                          '${state.shareTransfer.value.max}'),
                      style: body1?.copyWith(
                          fontWeight: FontWeight.w700, color: AppColors.active),
                    );
                  }),
                ],
              ),
              const SizedBox(height: 16),
              Form(
                key: state.formKey,
                child: AppTextFieldWidget(
                  inputController: state.amountController,
                  hintText: S.of(context).input_amount,
                  textInputType: TextInputType.number,
                  onChanged: (value) {
                    state.formKey.currentState?.validate();
                  },
                  validator: (amount) => checkAmount(
                      state.amountController.numberValue,
                      state.shareTransfer.value.max!),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                  child: ButtonFill(
                title: S.of(context).cancel_short,
                style: ElevatedButton.styleFrom(
                    onPrimary: AppColors.primary,
                    primary: const Color.fromRGBO(255, 238, 238, 1)),
                voidCallback: () {
                  Get.back();
                },
              )),
              const SizedBox(width: 20),
              Expanded(
                  child: ButtonFill(
                title: S.of(context).confirm,
                voidCallback: () async {
                  state.pinController.clear();
                  orderNew();
                },
              ))
            ],
          ),
        )
      ],
    ));
  }

  void orderNew() {
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
                    state.portfolio.value.symbol ?? "",
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
                    state.amountController.text,
                    style: body1?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              AppTextFieldWidget(
                validator: (pin) => checkPin(pin!),
                hintText: S.of(context).input_pin,
                inputController: state.pinController,
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
                            logic.updateShareTransferIn();
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
