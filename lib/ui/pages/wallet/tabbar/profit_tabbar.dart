import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/generated/l10n.dart';
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
        padding: EdgeInsets.zero,
        children: [
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
