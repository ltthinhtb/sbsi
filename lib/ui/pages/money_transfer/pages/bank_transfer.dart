import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/ui/commons/appbar.dart';
import 'package:sbsi/ui/pages/money_transfer/money_transfer_logic.dart';
import 'package:sbsi/ui/widgets/dropdown/app_drop_down.dart';

import '../../../../common/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../../model/response/list_account_response.dart';
import '../../../../services/auth_service.dart';
import '../widget/account_dropdown.dart';
import '../widget/money_availability.dart';

class BankTransfer extends StatefulWidget {
  const BankTransfer({Key? key}) : super(key: key);

  @override
  State<BankTransfer> createState() => _BankTransferState();
}

class _BankTransferState extends State<BankTransfer> {
  final state = Get.find<MoneyTransferLogic>().state;

  @override
  Widget build(BuildContext context) {
    final body1 = Theme.of(context).textTheme.bodyText1;

    return Scaffold(
      appBar: AppBarCustom(
        title: S.of(context).bank_transfer,
      ),
      backgroundColor: AppColors.whiteBack,
      body: Column(
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
            decoration: const BoxDecoration(color: AppColors.white, boxShadow: [
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
                    items: listAccount
                        .map((e) => DropdownMenuItem<Account>(
                            child: Text(e.accCode ?? ""), value: e))
                        .toList(),
                    value: state.accountReceiver.value,
                    onChanged: (account) {},
                  );
                }),
                const SizedBox(height: 16),
                Obx(() {
                  var listAccount = Get.find<AuthService>().listAccount;
                  return AppDropDownWidget<Account>(
                    items: listAccount
                        .map((e) => DropdownMenuItem<Account>(
                        child: Text(e.accCode ?? ""), value: e))
                        .toList(),
                    value: state.accountReceiver.value,
                    onChanged: (account) {},
                  );
                })
              ],
            ),
          )
        ],
      ),
    );
  }
}
