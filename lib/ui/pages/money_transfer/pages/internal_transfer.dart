import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/model/response/list_account_response.dart';
import 'package:sbsi/services/auth_service.dart';
import 'package:sbsi/utils/validator.dart';

import '../../../../common/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../commons/appbar.dart';
import '../../../widgets/button/button_filled.dart';
import '../../../widgets/dropdown/app_drop_down.dart';
import '../../../widgets/textfields/app_text_field.dart';
import '../enums/transfer_type.dart';
import '../money_transfer_logic.dart';
import '../widget/account_dropdown.dart';
import '../widget/money_availability.dart';
import 'confirm_payment.dart';

class InternalTransfer extends StatefulWidget {
  const InternalTransfer({Key? key}) : super(key: key);

  @override
  State<InternalTransfer> createState() => _InternalTransferState();
}

class _InternalTransferState extends State<InternalTransfer> with Validator {
  final state = Get.find<MoneyTransferLogic>().state;
  final logic = Get.find<MoneyTransferLogic>();

  @override
  void initState() {
    // clear money
    state.moneyController.clear();
    state.type = TransfersType.internal;
    state.transferContentController.text = logic.contentDefault;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final body1 = Theme.of(context).textTheme.bodyText1;

    return Scaffold(
      appBar: AppBarCustom(
        title: S.of(context).internal_transfer,
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
                    Form(
                      key: state.userMoneyKey,
                      child: AppTextFieldWidget(
                        hintText: S.of(context).money_transfer,
                        inputController: state.moneyController,
                        focusNode: state.userMoneyFocus,
                        enableBorder: true,
                        onChanged: (money) {
                          state.userMoneyKey.currentState?.validate();
                        },
                        validator: (money) {
                          return checkMoney(state.moneyController.numberValue
                              .toStringAsFixed(0));
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
                        validator: (content) {
                          return checkContent(content!);
                        },
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
                              if (!state.userMoneyKey.currentState!.validate())
                                return;
                              if (!state.transferContentKey.currentState!
                                  .validate()) return;
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
