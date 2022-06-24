import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/ui/commons/appbar.dart';
import 'package:sbsi/ui/pages/stock_detail/widget/news_tabs.dart';
import '../../../generated/l10n.dart';
import '../../widgets/button/button_filled.dart';
import '../stock_order_detail/stock_order_detail_view.dart';
import 'enums/stock_detail_tab.dart';
import 'stock_detail_logic.dart';
import 'widget/analytic_tab.dart';
import 'widget/card_data_detail.dart';
import 'widget/over_view_tab.dart';
import 'widget/stock_report_tab.dart';

class StockDetailPage extends StatefulWidget {
  const StockDetailPage({Key? key}) : super(key: key);

  @override
  _StockDetailPageState createState() => _StockDetailPageState();
}

class _StockDetailPageState extends State<StockDetailPage> {
  final logic = Get.put(StockDetailLogic());
  final state = Get.find<StockDetailLogic>().state;

  @override
  Widget build(BuildContext context) {
    final body1 = Theme.of(context).textTheme.bodyText1;
    return Scaffold(
      appBar: AppBarCustom(
        title: S.of(context).stock_detail,
        isCenter: true,
      ),
      backgroundColor: AppColors.whiteBack,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              flexibleSpace: Obx(() {
                var stock = state.selectedStock.value;
                var stockInfo = state.selectedStockInfo.value;
                var stockData = state.stockData.value;
                Logger().d(stockData.toJson());
                return SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 16),
                    child: CardDetail(
                      stock: stock,
                      stockInfo: stockInfo,
                      stockData: stockData,
                    ));
              }),
              pinned: false,
              expandedHeight: 220,
            ),
          ];
        },
        body: DefaultTabController(
          length: StockTab.values.length,
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
                      tabs: StockTab.values
                          .map((e) => Center(child: Text(e.name(context))))
                          .toList()),
                ],
              ),
              const Expanded(
                child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      OverViewTab(),
                      NewsTab(),
                      AnalyticTab(),
                      StockReportTabs()
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                        child: ButtonFill(
                            voidCallback: () {
                              Get.to(const StockOrderPagePage(),
                                  arguments: state.stockCode);
                            },
                            title: S.of(context).buy,
                            style: Theme.of(context)
                                .elevatedButtonTheme
                                .style
                                ?.copyWith(
                                    backgroundColor: MaterialStateProperty.all(
                                        AppColors.active),
                                    padding: ButtonStyleButton.allOrNull<
                                            EdgeInsetsGeometry>(
                                        const EdgeInsets.symmetric(
                                            horizontal: 24, vertical: 10)),
                                    shape: ButtonStyleButton.allOrNull<
                                            OutlinedBorder>(
                                        const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                    ))))),
                    const SizedBox(width: 16),
                    Expanded(
                        child: ButtonFill(
                            voidCallback: () {
                              Get.to(const StockOrderPagePage(),
                                  arguments: state.stockCode);
                            },
                            title: S.of(context).sell,
                            style: Theme.of(context)
                                .elevatedButtonTheme
                                .style
                                ?.copyWith(
                                    padding: ButtonStyleButton.allOrNull<
                                            EdgeInsetsGeometry>(
                                        const EdgeInsets.symmetric(
                                            horizontal: 24, vertical: 10)),
                                    shape: ButtonStyleButton.allOrNull<
                                            OutlinedBorder>(
                                        const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                    ))))),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<StockDetailLogic>();
    super.dispose();
  }
}
