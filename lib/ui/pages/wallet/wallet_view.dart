import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/ui/commons/appbar.dart';
import 'package:sbsi/ui/pages/wallet/enums/wallet_enums.dart';
import '../../../services/auth_service.dart';
import 'tabbar/assets_tabbar.dart';
import 'tabbar/menu_tabbar.dart';
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
    final body1 = Theme.of(context).textTheme.bodyText1;
    return Scaffold(
      appBar: AppBarCustom(
        title: S.of(context).wallet,
        isCenter: true,
        action: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            margin: const EdgeInsets.symmetric(vertical: 11),
            decoration: BoxDecoration(
                color: AppColors.tabIn,
                borderRadius: BorderRadius.circular(16)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() {
                  var auth = Get.find<AuthService>().token.value;
                  return Text('${auth?.data?.user ?? ""}');
                }),
                const SizedBox(width: 2),
                Container(
                  width: 24,
                  height: 24,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: AppColors.white, shape: BoxShape.circle),
                  child: Obx(() {
                    return Text(
                      state.account.value.lastCharacter,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          ?.copyWith(fontWeight: FontWeight.w700),
                    );
                  }),
                )
              ],
            ),
          ),
          const SizedBox(width: 14),
        ],
      ),
      body: DefaultTabController(
        length: WalletEnum.values.length,
        child: Column(
          children: [
            const SizedBox(height: 24),
            Stack(
              fit: StackFit.passthrough,
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppColors.grayF2, width: 2.0),
                    ),
                  ),
                ),
                TabBar(
                    indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 3)),
                    labelStyle: body1?.copyWith(fontWeight: FontWeight.w700),
                    labelColor: Theme.of(context).primaryColor,
                    unselectedLabelStyle: body1,
                    indicatorPadding: EdgeInsets.zero,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: AppColors.textGrey,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    labelPadding: const EdgeInsets.only(bottom: 8),
                    indicatorWeight: 0,
                    onTap: (value) {},
                    tabs: WalletEnum.values
                        .map((e) => Center(child: Text(e.title(context))))
                        .toList()),
              ],
            ),
            Expanded(
              child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const AssetsTabBar(),
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
