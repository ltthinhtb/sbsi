import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_images.dart';
import 'package:sbsi/common/app_shadows.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/utils/money_utils.dart';
import '../wallet_logic.dart';
import '../widget/portfolio_widget.dart';

class MenuTabBar extends StatefulWidget {
  const MenuTabBar({Key? key}) : super(key: key);

  @override
  _MenuTabBarState createState() => _MenuTabBarState();
}

class _MenuTabBarState extends State<MenuTabBar>
    with AutomaticKeepAliveClientMixin {
  final walletState = Get.find<WalletLogic>().state;
  final walletLogic = Get.find<WalletLogic>();

  final isPercent = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context)
        .textTheme
        .headline6!
        .copyWith(fontWeight: FontWeight.w700);
    final body2 = Theme.of(context)
        .textTheme
        .bodyText2!
        .copyWith(color: AppColors.textSecond);

    final caption = Theme.of(context).textTheme.caption!;
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async => walletLogic.refresh(),
      child: ListView(
        children: [
          const SizedBox(height: 16),
          Obx(() {
            return Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.white,
                  boxShadow: AppShadow.boxShadow),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(AppImages.assets_amount),
                  const SizedBox(width: 15),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).total_transfer,
                        style: body2.copyWith(height: 20 / 14),
                      ),
                      Text(
                        MoneyFormat.formatMoneyRound(
                            '${walletState.portfolioTotal.value.marketPriceValue}'),
                        style: headline6.copyWith(
                            height: 24 / 20, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 12),
                      Text(S.of(context).total_profit_loss,style: Theme.of(context).textTheme.bodyText2?.copyWith(color: AppColors.textSecond),),
                      const SizedBox(height: 6),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            MoneyFormat.formatMoneyRound('${walletState.portfolioTotal.value.gainLossValue.toString()}') +" ",
                            style: Theme.of(context).textTheme.button?.copyWith(
                                color:
                                walletState.portfolioTotal.value.glColor),
                          ),
                          const SizedBox(width: 30),

                          Text(
                            walletState.portfolioTotal.value.gainLossPer
                                ?.trim() ??
                                "",
                            style: Theme.of(context).textTheme.button?.copyWith(
                                color:
                                walletState.portfolioTotal.value.glColor),
                          ),
                          const SizedBox(width: 5.69),
                          SvgPicture.asset(
                              walletState.portfolioTotal.value.gl == "g"
                                  ? AppImages.increase
                                  : AppImages.decrease)
                        ],
                      )
                    ],
                  ))
                ],
              ),
            );
          }),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
                color: AppColors.white, boxShadow: AppShadow.boxShadow),
            child: Obx(() {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          S.of(context).stock_code,
                          style: caption.copyWith(
                              fontWeight: FontWeight.w700, height: 16 / 12),
                        )),
                        Expanded(
                            flex: 2,
                            child: Center(
                              child: Text(
                                S.of(context).volume_short,
                                style: caption.copyWith(
                                    fontWeight: FontWeight.w700,
                                    height: 16 / 12),
                              ),
                            )),
                        Expanded(
                            flex: 2,
                            child: Center(
                              child: Text(
                                S.of(context).avg_price_short,
                                style: caption.copyWith(
                                    fontWeight: FontWeight.w700,
                                    height: 16 / 12),
                              ),
                            )),
                        Expanded(
                            flex: 2,
                            child: Center(
                              child: Text(
                                S.of(context).price_tt,
                                style: caption.copyWith(
                                    fontWeight: FontWeight.w700,
                                    height: 16 / 12),
                              ),
                            )),
                        ValueListenableBuilder<bool>(
                          valueListenable: isPercent,
                          builder:
                              (BuildContext context, value, Widget? child) {
                            return Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  onTap: () {
                                    isPercent.value = !isPercent.value;
                                  },
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SvgPicture.asset(AppImages.down_arrow),
                                        const SizedBox(width: 3),
                                        Flexible(
                                          child: Text(
                                            value ? "%${S.of(context).increase_hole}" : "${S.of(context).increase_hole}",
                                            maxLines: 1,
                                            style: caption.copyWith(
                                                fontWeight: FontWeight.w700,
                                                overflow: TextOverflow.ellipsis,
                                                height: 16 / 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      var portfolio = walletState.portfolioList[index];
                      return PortfolioWidget(
                        portfolio: portfolio,
                        index: index,
                        isPercent: isPercent,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 0);
                    },
                    itemCount: walletState.portfolioList.length,
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
