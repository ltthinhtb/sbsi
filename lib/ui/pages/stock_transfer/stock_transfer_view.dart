import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/app_colors.dart';
import '../../../generated/l10n.dart';
import '../../commons/appbar.dart';
import 'enums/stock_transfer.dart';
import 'stock_transfer_logic.dart';
import 'tabs/stock_exchange_history_tabs.dart';
import 'tabs/stock_exchange_tabs.dart';

class StockTransferPage extends StatefulWidget {
  const StockTransferPage({Key? key}) : super(key: key);

  @override
  _StockTransferPageState createState() => _StockTransferPageState();
}

class _StockTransferPageState extends State<StockTransferPage> {
  final logic = Get.put(StockTransferLogic());
  final state = Get.find<StockTransferLogic>().state;

  @override
  Widget build(BuildContext context) {
    final body1 = Theme.of(context).textTheme.bodyText1;
    return Scaffold(
      backgroundColor: AppColors.whiteBack,
      appBar: AppBarCustom(
        title: S.of(context).transfer_stock,
        isCenter: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: DefaultTabController(
          length: StockTransfer.values.length,
          child: Column(
            children: [
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
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Theme.of(context).primaryColor,
                      unselectedLabelColor: AppColors.textGrey,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      labelPadding: const EdgeInsets.only(bottom: 8),
                      indicatorWeight: 0,
                      onTap: (value) {},
                      tabs: StockTransfer.values
                          .map((e) => Center(child: Text(e.name)))
                          .toList()),
                ],
              ),
              const Expanded(
                child: TabBarView(children: [StockExchangeTab(), StockExchangeHistory()]),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<StockTransferLogic>();
    super.dispose();
  }
}
