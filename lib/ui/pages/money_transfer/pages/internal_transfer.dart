import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/model/response/list_account_response.dart';
import 'package:sbsi/services/auth_service.dart';

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

class InternalTransfer extends StatefulWidget {
  const InternalTransfer({Key? key}) : super(key: key);

  @override
  State<InternalTransfer> createState() => _InternalTransferState();
}

class _InternalTransferState extends State<InternalTransfer> {
  final state = Get.find<MoneyTransferLogic>().state;
  final logic = Get.find<MoneyTransferLogic>();

  @override
  void initState() {
    // clear money
    state.moneyController.clear();
    state.type = TransfersType.internal;
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
                    Obx(() {
                      var listAccount = Get.find<AuthService>().listAccount;
                      return AppDropDownWidget<Account>(
                        isExpanded: true,
                        items: listAccount
                            .map((e) => DropdownMenuItem<Account>(
                                child: Text(e.accCode ?? ""), value: e))
                            .toList(),
                        value: state.accountReceiver.value,
                        hintText: S.of(context).bank,
                        onChanged: null,
                      );
                    }),
                    const SizedBox(height: 16),
                    Form(
                      key: state.userMoneyKey,
                      child: AppTextFieldWidget(
                        hintText: S.of(context).money_transfer,
                        inputController: state.moneyController,
                        focusNode: state.userMoneyFocus,
                        enableBorder: true,
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
                      voidCallback: () {},
                      title: S.of(context).cancel,
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
                              logic.updateCashTransferInternal();
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
