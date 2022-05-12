import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/model/response/list_account_response.dart';
import 'package:sbsi/services/auth_service.dart';
import 'package:sbsi/ui/pages/money_transfer/money_transfer_logic.dart';
import 'package:sbsi/ui/widgets/dropdown/app_drop_down.dart';

import '../../../../generated/l10n.dart';

class AccountDropDown extends StatelessWidget {
  const AccountDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final body1 = Theme.of(context).textTheme.bodyText1;
    final state = Get.find<MoneyTransferLogic>().state;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0,-0.5),
            blurRadius: 8,
            color: Color.fromRGBO(0, 0, 0, 0.03)
          ),
          BoxShadow(
              offset: Offset(0,-1),
              blurRadius: 10,
              color: Color.fromRGBO(0, 0, 0, 0.04)
          )
        ]
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).select_account,
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
              value: state.account.value,
              onChanged: (account) {},
            );
          })
        ],
      ),
    );
  }
}
