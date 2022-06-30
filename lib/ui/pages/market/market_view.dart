import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/ui/commons/appbar.dart';
import 'package:sbsi/ui/pages/market/market_logic.dart';
import 'package:sbsi/ui/pages/market/widget/overview_tab.dart';
import '../../../generated/l10n.dart';
import 'enum/fork_enums.dart';
import 'widget/dropdown_market.dart';
import 'widget/world_tabs.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage>
    with SingleTickerProviderStateMixin {
  final logic = Get.find<MarketLogic>();
  final state = Get.find<MarketLogic>().state;

  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: ForkEnum.values.length, vsync: this);

  }

  @override
  void dispose() {
    _tabController?.dispose();
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
      body: Column(
        children: [
          const SizedBox(height: 16),
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
                  controller: _tabController,
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
            ],
          ),
          Expanded(
            child: TabBarView(controller: _tabController,physics: const NeverScrollableScrollPhysics(), children: [
              const OverviewView(),
              const MarketOption(),
              const WorldTabs(),
            ]),
          )
        ],
      ),
    );
  }
}
