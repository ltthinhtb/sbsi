import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_dimens.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/model/response/account_status.dart';
import 'package:sbsi/utils/money_utils.dart';

import '../wallet_logic.dart';

class AssetsTabBar extends StatefulWidget {
  const AssetsTabBar({Key? key}) : super(key: key);

  @override
  State<AssetsTabBar> createState() => _AssetsTabBarState();
}

class _AssetsTabBarState extends State<AssetsTabBar>
    with AutomaticKeepAliveClientMixin {
  late AccountAssets assets;

  final state = Get.find<WalletLogic>().state;
  final logic = Get.find<WalletLogic>();


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(() {
      assets = state.assets.value;
      return RefreshIndicator(
        onRefresh: () async => logic.onReady(),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.marginNormal),
          children: [
            rowData(S.of(context).total_assets,
                '${MoneyFormat.formatMoneyRound(assets.assets ?? "")}đ'),
            const SizedBox(height: 20),
            rowData(S.of(context).cash_balance,
                '${MoneyFormat.formatMoneyRound(assets.cashBalance ?? "")}đ'),
            const SizedBox(height: 20),
            rowData(S.of(context).collaborative_assets,
                '${MoneyFormat.formatMoneyRound(assets.avaiColla ?? "")}đ'),
            const SizedBox(height: 20),
            rowData(S.of(context).collaborative_assets_total,
                '${MoneyFormat.formatMoneyRound(assets.avaiColla ?? "")}đ'),
            const SizedBox(height: 20),
            rowData(S.of(context).deposit_fee,
                '${MoneyFormat.formatMoneyRound(assets.depositFee ?? "")}đ'),
          ],
        ),
      );
    });
  }

  Widget rowData(String left, String right) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(left,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: AppColors.gray88)),
        Text(right,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.w700)),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
