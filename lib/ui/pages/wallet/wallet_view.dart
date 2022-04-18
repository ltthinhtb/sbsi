import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_dimens.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/ui/commons/appbar.dart';
import 'package:sbsi/ui/pages/wallet/enums/wallet_enums.dart';
import 'tabbar/assets_tabbar.dart';
import 'tabbar/menu_tabbar.dart';
import 'tabbar/profit_tabbar.dart';
import 'wallet_logic.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final logic = Get.find<WalletLogic>();
  final state = Get.find<WalletLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: S.of(context).wallet,
      ),
      body: DefaultTabController(
        length: WalletEnum.values.length,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: AppDimens.marginNormal),
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: AppColors.grayF2,
                borderRadius: BorderRadius.circular(9),
              ),
              child: TabBar(
                  tabs: WalletEnum.values
                      .map((e) => Center(child: Text(e.title(context))))
                      .toList()),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: TabBarView(children: [
                const AssetsTabBar(),
                const ProfitTabBar(),
                const MenuTabBar(),
                Container(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
