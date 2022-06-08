import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_shadows.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/model/response/account_status.dart';
import 'package:sbsi/utils/money_utils.dart';
import '../wallet_logic.dart';
import '../widget/pie_chart_widget.dart';

class AssetsTabBar extends StatefulWidget {
  const AssetsTabBar({Key? key}) : super(key: key);

  @override
  State<AssetsTabBar> createState() => _AssetsTabBarState();
}

class _AssetsTabBarState extends State<AssetsTabBar>
    with AutomaticKeepAliveClientMixin {
  late AccountMStatus assets;

  final state = Get.find<WalletLogic>().state;
  final logic = Get.find<WalletLogic>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(() {
      assets = state.assets.value;

      return RefreshIndicator(
        onRefresh: () async => logic.refresh(),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(height: 16),
            const PieChartWidget(),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  boxShadow: AppShadow.boxShadow, color: AppColors.white),
              child: Column(
                children: [
                  rowData(S.of(context).cash_balance,
                      '${MoneyFormat.formatMoneyRound(assets.assets ?? "")} đ'),
                  const SizedBox(height: 16),
                  Visibility(
                    visible: state.account.value.lastCharacter == "6",
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: rowData(S.of(context).pp_1,
                          '${MoneyFormat.formatMoneyRound(assets.ee ?? "")} đ'),
                    ),
                  ),
                  Obx(() {
                    var portfolioTotal = state.portfolioTotal.value;
                    return rowData(S.of(context).total_transfer,
                        '${MoneyFormat.formatMoneyRound(portfolioTotal.marketValue ?? "")} đ');
                  }),
                  Visibility(
                    visible: state.account.value.lastCharacter == "6",
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: rowData(S.of(context).debt,
                          '${MoneyFormat.formatMoneyRound(assets.debt ?? "")} đ'),
                    ),
                  ),
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
                  // Visibility(
                  //   visible: state.account.value.lastCharacter == "6",
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(bottom: 16),
                  //     child: rowData(S.of(context).cash,
                  //         '${MoneyFormat.formatMoneyRound(assets.cashBalance ?? "")} đ'),
                  //   ),
                  // ),
                  rowData(S.of(context).withdraw_money,
                      '${MoneyFormat.formatMoneyRound(assets.cashAvai ?? "")} đ'),
                  const SizedBox(height: 16),
                  rowData(S.of(context).apT0,
                      '${MoneyFormat.formatMoneyRound(assets.apT0 ?? "")} đ'),
                  const SizedBox(height: 16),
                  rowData(S.of(context).cash_advance_avai,
                      '${MoneyFormat.formatMoneyRound(assets.cashAdvanceAvai ?? "")} đ'),
                  const SizedBox(height: 16),
                  rowData("Cổ tức tiền", '-'),
                ],
              ),
            ),
            Visibility(
              visible: state.account.value.lastCharacter == "6",
              child: Container(
                margin: const EdgeInsets.only(top: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    boxShadow: AppShadow.boxShadow, color: AppColors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        S.of(context).risk_management,
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
                    rowData(S.of(context).total_debt,
                        '${MoneyFormat.formatMoneyRound(assets.debt ?? "")} đ'),
                    const SizedBox(height: 16),
                    rowData("Lãi tạm tính",
                        '${MoneyFormat.formatMoneyRound("0")} đ'),
                    const SizedBox(height: 16),
                    rowData("Phí lưu ký",
                        '${MoneyFormat.formatMoneyRound(assets.depositFee ?? "")} đ'),
                    const SizedBox(height: 16),
                    rowData("Tỷ lệ an toàn", assets.marginRatio ?? ""),
                  ],
                ),
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
