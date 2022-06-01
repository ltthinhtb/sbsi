import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/ui/commons/appbar.dart';

import '../../../generated/l10n.dart';
import 'get_account_info_logic.dart';

class GetAccountInfoPage extends StatefulWidget {
  const GetAccountInfoPage({Key? key}) : super(key: key);

  @override
  _GetAccountInfoPageState createState() => _GetAccountInfoPageState();
}

class _GetAccountInfoPageState extends State<GetAccountInfoPage> {
  final logic = Get.put(GetAccountInfoLogic());
  final state = Get.find<GetAccountInfoLogic>().state;

  @override
  Widget build(BuildContext context) {
    final body1 = Theme.of(context).textTheme.bodyText1;
    return Scaffold(
      appBar: AppBarCustom(
        title: S.of(context).account_info,
        isCenter: true,
      ),
      backgroundColor: AppColors.whiteBack,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              var account = state.accountInfo.value;
              return Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 20,
                      color: Color.fromRGBO(0, 0, 0, 0.05)),
                ], color: AppColors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).account_info,
                      style: body1?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 16),
                    rowString(
                        S.of(context).identity_card, account.cCARDID ?? ""),
                    const SizedBox(height: 16),
                    rowString(S.of(context).issue_date_cmt,
                        account.cIDISSUEDATE ?? ""),
                    const SizedBox(height: 16),
                    rowString(
                        S.of(context).issue_loc, account.cIDISSUEPLACE ?? "")
                  ],
                ),
              );
            }),
            const SizedBox(height: 16),
            Obx(() {
              var account = state.accountInfo.value;
              Logger().d(account.toJson());
              return Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 20,
                      color: Color.fromRGBO(0, 0, 0, 0.05)),
                ], color: AppColors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).contact_info,
                      style: body1?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 16),
                    rowString(
                        S.of(context).address, account.address ),
                    const SizedBox(height: 16),
                    rowString(S.of(context).telephone,
                        account.cCUSTMOBILE ?? ""),
                    const SizedBox(height: 16),
                    rowString(
                        S.of(context).email, account.email)
                  ],
                ),
              );
            }),
            const SizedBox(height: 16),
            Obx(() {
              var account = state.accountInfo.value;
              return Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 20,
                      color: Color.fromRGBO(0, 0, 0, 0.05)),
                ], color: AppColors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).c_authen_sign,
                      style: body1?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 16),
                    Text(account.cAUTHENSIGN ?? "",style: Theme.of(context).textTheme.bodyText2,)
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget rowString(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(color: AppColors.textSecond),
        ),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(fontWeight: FontWeight.w700),
        )
      ],
    );
  }

  @override
  void dispose() {
    Get.delete<GetAccountInfoLogic>();
    super.dispose();
  }
}
