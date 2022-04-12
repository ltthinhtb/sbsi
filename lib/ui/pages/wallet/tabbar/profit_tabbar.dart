import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_dimens.dart';
import 'package:sbsi/configs/app_configs.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/model/response/list_account_response.dart';
import 'package:sbsi/ui/pages/user/user_logic.dart';
import 'package:sbsi/ui/widgets/dropdown/app_drop_down.dart';
import 'package:sbsi/ui/widgets/textfields/app_text_field.dart';
import 'package:sbsi/utils/money_utils.dart';

import '../wallet_logic.dart';

class ProfitTabBar extends StatefulWidget {
  const ProfitTabBar({Key? key}) : super(key: key);

  @override
  _ProfitTabBarState createState() => _ProfitTabBarState();
}

class _ProfitTabBarState extends State<ProfitTabBar>
    with AutomaticKeepAliveClientMixin {
  final walletState = Get.find<WalletLogic>().state;
  final walletLogic = Get.find<WalletLogic>();

  final userState = Get.find<UserLogic>().state;

  @override
  Widget build(BuildContext context) {
    final headline8 =
        Theme.of(context).textTheme.headline6!.copyWith(fontSize: 10);
    final headline7 = Theme.of(context)
        .textTheme
        .headline6!
        .copyWith(fontSize: 12, fontWeight: FontWeight.w700);
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async => walletLogic.onReady(),
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.marginNormal),
        children: [
          Row(
            children: [
              Expanded(
                  child: AppTextFieldWidget(
                label: S.of(context).start_day,
                hintText: AppConfigs.dateAPIFormat,
              )),
              const SizedBox(width: 15),
              Expanded(
                  child: AppTextFieldWidget(
                label: S.of(context).end_day,
                hintText: AppConfigs.dateAPIFormat,
              )),
            ],
          ),
          const SizedBox(height: 20),
          AppDropDownWidget<Account>(
              label: S.of(context).account,
              value: userState.listAccount.firstWhere(
                  (element) => element.accCode == walletLogic.defAcc,
                  orElse: () {
                return Account(accCode: walletLogic.defAcc);
              }),
              onChanged: (value) {
                walletLogic.getPortfolio(account: value!.accCode);
                walletLogic.getAccountStatus(account: value.accCode);
              },
              items: userState.listAccount
                  .map((e) => DropdownMenuItem<Account>(
                        value: e,
                        onTap: () {},
                        child: Text(e.accCode ?? ""),
                      ))
                  .toList()),
          const SizedBox(height: 20),
          AppTextFieldWidget(
            label: S.of(context).profit_total,
            inputController: walletState.profitController,
          ),
          const SizedBox(height: 29),
          Obx(() {
            return ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            S.of(context).stock_code,
                            style: headline8,
                          )),
                          Expanded(
                              child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              S.of(context).volume_short,
                              style: headline8,
                            ),
                          )),
                          Expanded(
                              child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              S.of(context).gain_loss_percent,
                              style: headline8,
                            ),
                          )),
                          Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  S.of(context).gain_loss_value,
                                  style: headline8,
                                ),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            walletState.portfolioList[index].symbol ?? "",
                            style: headline7,
                          )),
                          Expanded(
                              child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              walletState.portfolioList[index].avaiableVol ??
                                  "",
                              style: headline7,
                            ),
                          )),
                          Expanded(
                              child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              walletState.portfolioList[index].gainLossPer ??
                                  "",
                              style: headline7.copyWith(
                                  color:
                                      walletState.portfolioList[index].glColor),
                            ),
                          )),
                          Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '${MoneyFormat.formatMoneyRound(walletState.portfolioList[index].gainLossValue ?? "")} đ',
                                  style: headline7.copyWith(
                                      color: walletState
                                          .portfolioList[index].glColor),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 10);
              },
              itemCount: walletState.portfolioList.length,
            );
          }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
