import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/ui/commons/appbar.dart';
import 'package:sbsi/ui/pages/stock_detail/widget/news_tabs.dart';
import '../../../common/app_images.dart';
import '../../../generated/l10n.dart';
import 'enums/stock_detail_tab.dart';
import 'stock_detail_logic.dart';
import 'widget/card_data_detail.dart';
import 'widget/over_view_tab.dart';

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
        action: [
          GestureDetector(
              onTap: () {}, child: SvgPicture.asset(AppImages.search_normal)),
          const SizedBox(width: 20),
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              flexibleSpace: Obx(() {
                var stock = state.selectedStock.value;
                var stockInfo = state.selectedStockInfo.value;
                return SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 16),
                    child: CardDetail(stock: stock, stockInfo: stockInfo));
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
                      OverViewTab(),
                      OverViewTab()
                    ]),
              )
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
