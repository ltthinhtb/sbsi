import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/ui/pages/home/home_logic.dart';
import 'package:sbsi/ui/pages/notification/notification_logic.dart';
import 'package:sbsi/ui/pages/search/search_view.dart';
import 'package:sbsi/ui/pages/wallet/wallet_logic.dart';
import 'package:sbsi/utils/money_utils.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_images.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/route_config.dart';
import '../../main/main_logic.dart';

class AppBarHome extends StatelessWidget {
  const AppBarHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final body2 = Theme.of(context).textTheme.bodyText2;
    final headline6 = Theme.of(context).textTheme.headline6;

    return Container(
      height: 207 / 812 * MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(16),
                bottomLeft: Radius.circular(16)),
            child: SvgPicture.asset(
              AppImages.appbar,
              alignment: Alignment.center,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: 164 / 812 * MediaQuery.of(context).size.height,
            ),
          ),
          Container(
            height: 164 / 812 * MediaQuery.of(context).size.height,
            child: Padding(
              padding: EdgeInsets.zero,
              child: Row(
                children: [
                  const SizedBox(width: 17),
                  GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Get.find<HomeLogic>()
                            .state
                            .key
                            .currentState
                            ?.openDrawer();
                      },
                      child: SvgPicture.asset(AppImages.user)),
                  const SizedBox(width: 12),
                  Expanded(child: Obx(() {
                    return Text(
                      Get.find<HomeLogic>()
                              .authService
                              .token
                              .value
                              ?.data
                              ?.name ??
                          "",
                      style: body2?.copyWith(color: AppColors.white),
                    );
                  })),
                  GestureDetector(
                      onTap: () {
                        Get.to(const SearchPage());
                      },
                      child: SvgPicture.asset(AppImages.search_normal)),
                  const SizedBox(width: 20),
                  GestureDetector(onTap: () {
                    Get.toNamed(RouteConfig.notification);
                  }, child: Obx(() {
                    var count = Get.find<NotificationLogic>().state.count;
                    return Badge(
                        position: const BadgePosition(bottom: 8, start: 10),
                        badgeContent: Text('${count}',
                            style: Theme.of(context).textTheme.caption),
                        badgeColor: AppColors.yellow,
                        child: SvgPicture.asset(AppImages.notification));
                  })),
                  const SizedBox(width: 15),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                Get.find<MainLogic>().switchTap(4);
              },
              child: Container(
                height: 86 / 812 * MediaQuery.of(context).size.height,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    boxShadow: [
                      const BoxShadow(
                          blurRadius: 0, color: Color.fromRGBO(0, 0, 0, 0.08)),
                      const BoxShadow(
                          blurRadius: 4, color: Color.fromRGBO(0, 0, 0, 0.08)),
                      const BoxShadow(
                          blurRadius: 10, color: Color.fromRGBO(0, 0, 0, 0.08))
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    SvgPicture.asset(AppImages.amount),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).total_assets,
                            style: body2?.copyWith(
                              color: AppColors.textSecond,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Obx(() {
                            var accountStatus =
                                Get.find<WalletLogic>().state.totalAssets.value;
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  MoneyFormat.formatMoneyRound(
                                          '${accountStatus.totalNav}') +
                                      " ??",
                                  style: headline6?.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                Text(
                                  '(${accountStatus.vmEnquityPer ?? ""}%)',
                                  style: Theme.of(context)
                                      .textTheme
                                      .button
                                      ?.copyWith(color: accountStatus.color),
                                ),
                                const SizedBox(width: 5.69),
                                SvgPicture.asset(accountStatus.isIncrease
                                    ? AppImages.increase
                                    : AppImages.decrease)
                                //Text(accountStatus)
                              ],
                            );
                          })
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
