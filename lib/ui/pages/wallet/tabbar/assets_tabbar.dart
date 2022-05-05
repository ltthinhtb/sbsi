import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_shadows.dart';
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
    final width = (139 / 375) * MediaQuery.of(context).size.width;
    return Obx(() {
      assets = state.assets.value;
      // chứng khoán
      var market_value = state.portfolioTotal.value.marketPriceValue;
      // tiền
      var money = state.assets.value.assetsValue;

      double percent = (market_value / (money + market_value));

      return RefreshIndicator(
        onRefresh: () async => logic.onReady(),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(height: 16),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: AppColors.PastelCard,
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  CircularPercentIndicator(
                    radius: width / 2,
                    lineWidth: 27,
                    animation: true,
                    backgroundColor: AppColors.yellowStatus,
                    percent: percent,
                    startAngle: 0,
                    center: Text(
                      "${(percent * 100).toStringAsFixed(2)}%",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: AppColors.deActive,
                  ),
                  const SizedBox(width: 21),
                  Expanded(
                      child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                                color: AppColors.yellowStatus,
                                borderRadius: BorderRadius.circular(1)),
                          ),
                          const SizedBox(width: 7.72),
                          Text(
                            '${S.of(context).money}:',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(),
                          )
                        ],
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                                color: AppColors.deActive,
                                borderRadius: BorderRadius.circular(1)),
                          ),
                          const SizedBox(width: 7.72),
                          Text(
                            '${S.of(context).stock}:',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(),
                          )
                        ],
                      ),
                    ],
                  ))
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  boxShadow: AppShadow.boxShadow, color: AppColors.white),
              child: Column(
                children: [
                  rowData(S.of(context).total_assets,
                      '${MoneyFormat.formatMoneyRound(assets.assets ?? "")}đ'),
                  const SizedBox(height: 16),
                  rowData(S.of(context).cash_balance,
                      '${MoneyFormat.formatMoneyRound(assets.cashBalance ?? "")}đ'),
                  const SizedBox(height: 16),
                  rowData(S.of(context).collaborative_assets,
                      '${MoneyFormat.formatMoneyRound(assets.avaiColla ?? "")}đ'),
                  const SizedBox(height: 16),
                  rowData(S.of(context).collaborative_assets_total,
                      '${MoneyFormat.formatMoneyRound(assets.avaiColla ?? "")}đ'),
                  const SizedBox(height: 16),
                  rowData(S.of(context).deposit_fee,
                      '${MoneyFormat.formatMoneyRound(assets.depositFee ?? "")}đ'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  boxShadow: AppShadow.boxShadow, color: AppColors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      S.of(context).money,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    height: 16,
                  ),
                  const SizedBox(height: 8),
                  rowData(S.of(context).total_assets,
                      '${MoneyFormat.formatMoneyRound(assets.assets ?? "")}đ'),
                  const SizedBox(height: 16),
                  rowData(S.of(context).cash_balance,
                      '${MoneyFormat.formatMoneyRound(assets.cashBalance ?? "")}đ'),
                  const SizedBox(height: 16),
                  rowData(S.of(context).collaborative_assets,
                      '${MoneyFormat.formatMoneyRound(assets.avaiColla ?? "")}đ'),
                  const SizedBox(height: 16),
                  rowData(S.of(context).collaborative_assets_total,
                      '${MoneyFormat.formatMoneyRound(assets.avaiColla ?? "")}đ'),
                  const SizedBox(height: 16),
                  rowData(S.of(context).deposit_fee,
                      '${MoneyFormat.formatMoneyRound(assets.depositFee ?? "")}đ'),
                ],
              ),
            ),
            const SizedBox(height: 32),
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
                .bodyText2!
                .copyWith(color: AppColors.textSecond)),
        Text(right,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontWeight: FontWeight.w700)),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
