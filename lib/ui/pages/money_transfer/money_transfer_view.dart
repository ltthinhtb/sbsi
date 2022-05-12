import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/ui/commons/appbar.dart';

import '../../../common/app_images.dart';
import '../../../generated/l10n.dart';
import 'money_transfer_logic.dart';
import 'pages/bank_transfer.dart';

class MoneyTransferPage extends StatefulWidget {
  const MoneyTransferPage({Key? key}) : super(key: key);

  @override
  _MoneyTransferPageState createState() => _MoneyTransferPageState();
}

class _MoneyTransferPageState extends State<MoneyTransferPage> {
  final logic = Get.put(MoneyTransferLogic());
  final state = Get.find<MoneyTransferLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: S.of(context).transfer,
        isCenter: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                rowButton(
                    onTap: () {
                      Get.to(const BankTransfer());
                    },
                    title: S.of(context).bank_transfer,
                    button: AppImages.bank_icon),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(
                    thickness: 1,
                    height: 32,
                  ),
                ),
                rowButton(
                    onTap: () {},
                    title: S.of(context).internal_transfer,
                    button: AppImages.credit_card_icon),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(
                    thickness: 1,
                    height: 32,
                  ),
                ),
                rowButton(
                    onTap: () {},
                    title: S.of(context).history_transfer,
                    button: AppImages.ic_history),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget rowButton(
      {required String button,
      required String title,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 20),
        child: Row(
          children: [
            SvgPicture.asset(button),
            const SizedBox(width: 16),
            Expanded(
                child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(fontWeight: FontWeight.w700),
            )),
            SvgPicture.asset(AppImages.vector)
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<MoneyTransferLogic>();
    super.dispose();
  }
}
