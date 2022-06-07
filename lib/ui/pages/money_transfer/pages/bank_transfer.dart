import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/model/entities/beneficiary_account.dart';
import 'package:sbsi/ui/commons/appbar.dart';
import 'package:sbsi/ui/pages/money_transfer/enums/transfer_type.dart';
import 'package:sbsi/ui/pages/money_transfer/money_transfer_logic.dart';
import 'package:sbsi/ui/pages/money_transfer/pages/confirm_payment.dart';
import 'package:sbsi/ui/widgets/button/button_filled.dart';
import 'package:sbsi/ui/widgets/dropdown/app_drop_down.dart';
import 'package:sbsi/ui/widgets/textfields/app_text_field.dart';

import '../../../../common/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../../model/entities/bank.dart';
import '../../../../utils/validator.dart';
import '../widget/account_dropdown.dart';
import '../widget/money_availability.dart';

class BankTransfer extends StatefulWidget {
  const BankTransfer({Key? key}) : super(key: key);

  @override
  State<BankTransfer> createState() => _BankTransferState();
}

class _BankTransferState extends State<BankTransfer> with Validator {
  final state = Get.find<MoneyTransferLogic>().state;
  final logic = Get.find<MoneyTransferLogic>();

  @override
  void initState() {
    // clear money
    state.moneyController.clear();
    state.type = TransfersType.bank;
    state.transferContentController.text = logic.contentDefault;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final body1 = Theme.of(context).textTheme.bodyText1;

    return Scaffold(
      appBar: AppBarCustom(
        title: S.of(context).bank_transfer,
      ),
      backgroundColor: AppColors.whiteBack,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: AvailabilityMoney(),
              ),
              const SizedBox(height: 16),
              const AccountDropDown(),
              const SizedBox(height: 16),
              Container(
                decoration:
                    const BoxDecoration(color: AppColors.white, boxShadow: [
                  BoxShadow(
                      offset: Offset(0, -0.5),
                      blurRadius: 8,
                      color: Color.fromRGBO(0, 0, 0, 0.03)),
                  BoxShadow(
                      offset: Offset(0, -1),
                      blurRadius: 10,
                      color: Color.fromRGBO(0, 0, 0, 0.04))
                ]),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).account_receiver,
                      style: body1?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 16),
                    state.listBeneficiary.isNotEmpty
                        ? Obx(() {
                            var listBeneficiary = state.listBeneficiary;
                            int BeneficiaryIndex = listBeneficiary.indexWhere(
                                (element) =>
                                    element.cBANKACCOUNTCODE ==
                                    state.beneficiary.value.cBANKACCOUNTCODE);
                            bool checkBeneficiary = BeneficiaryIndex >= 0;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: AppDropDownWidget<BeneficiaryAccount>(
                                items: listBeneficiary
                                    .map((e) => DropdownMenuItem<
                                            BeneficiaryAccount>(
                                        child: Text(
                                            '${e.cBANKCODE ?? ""} ${e.cBANKACCOUNTCODE ?? ""}'),
                                        value: e))
                                    .toList(),
                                value: checkBeneficiary
                                    ? state.beneficiary.value
                                    : null,
                                onChanged: (account) {
                                  logic.changeBeneficiary(account!);
                                },
                              ),
                            );
                          })
                        : const SizedBox(),
                    Obx(() {
                      var listBank = state.listBank;
                      int bankIndex = listBank.indexWhere((element) =>
                          element.cBANKCODE == state.bank.value.cBANKCODE);
                      bool checkBank = bankIndex >= 0;
                      return AppDropDownWidget<Bank>(
                        isExpanded: true,
                        items: listBank
                            .map((e) => DropdownMenuItem<Bank>(
                                child: Text(e.cBANKNAME ?? ""), value: e))
                            .toList(),
                        value: checkBank ? state.bank.value : null,
                        hintText: S.of(context).bank,
                        onChanged: null,
                      );
                    }),
                    const SizedBox(height: 16),
                    Form(
                      key: state.userAccountKey,
                      child: AppTextFieldWidget(
                        hintText: S.of(context).user_name,
                        inputController: state.userAccountController,
                        focusNode: state.userAccountFocus,
                        readOnly: true,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Form(
                      key: state.userNameKey,
                      child: AppTextFieldWidget(
                        hintText: S.of(context).account_name,
                        inputController: state.userNameController,
                        focusNode: state.userNameFocus,
                        readOnly: true,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Form(
                      key: state.userMoneyKey,
                      child: AppTextFieldWidget(
                        hintText: S.of(context).money_transfer,
                        inputController: state.moneyController,
                        focusNode: state.userMoneyFocus,
                        enableBorder: true,
                        validator: (money) {
                          return checkMoney(state.moneyController.numberValue.toString());
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Form(
                      key: state.transferContentKey,
                      child: AppTextFieldWidget(
                        maxLines: 3,
                        maxLength: 1000,
                        hintText: S.of(context).transfer_content,
                        inputController: state.transferContentController,
                        focusNode: state.transferContentFocus,
                        enableBorder: true,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
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
                      // style: ElevatedButton.styleFrom().copyWith(
                      //     backgroundColor: MaterialStateProperty.all(
                      //         const Color.fromRGBO(255, 238, 238, 1))),
                    )),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: ButtonFill(
                            voidCallback: () {
                              if (!state.userMoneyKey.currentState!
                                  .validate()) {
                                return;
                              }
                              Get.to(ConfirmPayment(
                                title: state.type.name,
                              ));
                            },
                            title: S.of(context).confirm))
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
