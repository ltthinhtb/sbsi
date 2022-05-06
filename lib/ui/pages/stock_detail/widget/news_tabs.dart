import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';

import 'package:sbsi/common/app_shadows.dart';
import 'package:sbsi/ui/pages/stock_detail/stock_detail_logic.dart';
import 'package:sbsi/ui/pages/stock_detail/widget/news_component.dart';

class NewsTab extends StatefulWidget {
  const NewsTab({Key? key}) : super(key: key);

  @override
  State<NewsTab> createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        boxShadow: AppShadow.boxShadow,
        color: AppColors.white
      ),
      child: ListView.separated(
        padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            var news = Get.find<StockDetailLogic>().state.listStockNews[index];
            return NewsComponent(
              news: news,
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              thickness: 1,
              height: 32,
            );
          },
          itemCount: Get.find<StockDetailLogic>().state.listStockNews.length),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
