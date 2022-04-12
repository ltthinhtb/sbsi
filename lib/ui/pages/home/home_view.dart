import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_images.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/model/stock_company_data/stock_company_data.dart';
import 'package:sbsi/router/route_config.dart';
import 'package:sbsi/ui/pages/enum/vnIndex.dart';
import 'package:sbsi/ui/pages/main/main_logic.dart';
import 'package:sbsi/ui/widgets/textfields/app_text_field.dart';
import 'package:sbsi/utils/logger.dart';

import 'home_logic.dart';
import 'widget/list_stock.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final logic = Get.put(HomeLogic());
  final state = Get.find<HomeLogic>().state;

  @override
  void dispose() {
    Get.delete<HomeLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
    final headline4 = Theme.of(context).textTheme.headline4;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        toolbarHeight: kToolbarHeight + 20,
        title: AppTextFieldWidget(
          readOnly: true,
          hintText: S.of(context).search,
          onTap: () async {
            await Get.toNamed(RouteConfig.search)?.then((value) {
              if (value is StockCompanyData) {
                logger.d(value.toJson());
                Get.find<MainLogic>().switchTap(2);
              }
            });
          },
          prefixIcon: SvgPicture.asset(
            AppImages.search_normal,
            color: AppColors.white,
          ),
        ),
        actions: [
          GestureDetector(
              onTap: () {
                Get.toNamed(RouteConfig.notification);
              },
              child: SvgPicture.asset(AppImages.notification)),
          const SizedBox(width: 15)
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            Future.delayed(const Duration(seconds: 1), () {}),
        child: Column(
          children: [
            const SizedBox(height: 15),
            SizedBox(
              height: 100,
              child: Obx(() {
                return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: AppColors.cardPortfolio,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.listIndexDetail[index].stockCode?.name ??
                                  "",
                              style:
                                  headline6!.copyWith(color: AppColors.white),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${state.listIndexDetail[index].cIndex}',
                              style: headline4!.copyWith(
                                  color: state.listIndexDetail[index].color),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${state.listIndexDetail[index].percentPrice}(${state.listIndexDetail[index].percent})',
                              style: headline6.copyWith(
                                  color: state.listIndexDetail[index].color),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 10);
                    },
                    itemCount: state.listIndexDetail.length);
              }),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                color: Colors.black,
                child: Column(
                  children: const [
                    // SizedBox(height: 20),
                    // MarketOption(),
                    SizedBox(height: 15),
                    ListStockView()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
