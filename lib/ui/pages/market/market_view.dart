import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/ui/commons/appbar.dart';
import 'package:sbsi/ui/pages/market/market_logic.dart';
import 'package:sbsi/ui/pages/market/widget/overview_tab.dart';
import 'package:sbsi/ui/pages/market/widget/stock_exchanges%20.dart';
import 'package:sbsi/ui/pages/wallet/wallet_logic.dart';
import '../../../generated/l10n.dart';
import 'enum/fork_enums.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  final logic = Get.put(MarketLogic());
  final w = Get.put(WalletLogic());
  final state = Get.find<MarketLogic>().state;
  late final Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 10), (Timer t) {
      // logic.getMarketDepth();
      // logic.getDetailStockBranch();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final body1 = Theme.of(context).textTheme.bodyText1;
    return Scaffold(
      appBar: AppBarCustom(
        title: S.of(context).stockMarket,
        isCenter: true,
      ),
      backgroundColor: AppColors.whiteBack,
      body: RefreshIndicator(
          onRefresh: () async => Future.delayed(const Duration(seconds: 1), () {
                logic.getMarketDepth();
                logic.getDetailStockBranch();
              }),
          child: DefaultTabController(
            length: ForkEnum.values.length,
            child: Column(
              children: [
                const SizedBox(height: 16),
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
                    tabs: ForkEnum.values
                        .map((e) => Center(child: Text(e.title(context))))
                        .toList()),
                Expanded(
                  child: TabBarView(children: [
                    OverviewView(),
                    OverviewView(),
                    OverviewView(),
                    OverviewView()
                  ]),
                )
              ],
            ),
          )),
    );
  }
}
