import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/ui/widgets/dropdown/app_drop_down.dart';

import '../../../../generated/l10n.dart';
import '../../../../model/response/list_account_response.dart';
import '../../../../services/auth_service.dart';
import '../../../widgets/textfields/app_text_field.dart';
import '../stock_transfer_logic.dart';

class StockExchangeTab extends StatefulWidget {
  const StockExchangeTab({Key? key}) : super(key: key);

  @override
  State<StockExchangeTab> createState() => _StockExchangeTabState();
}

class _StockExchangeTabState extends State<StockExchangeTab> {
  final logic = Get.put(StockTransferLogic());
  final state = Get.find<StockTransferLogic>().state;

  @override
  Widget build(BuildContext context) {
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
            ],
          ),
        ),
      ],
    ));
  }
}
