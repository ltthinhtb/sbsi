import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_images.dart';
import 'package:sbsi/common/app_shadows.dart';
import 'package:sbsi/ui/commons/appbar.dart';

import '../../../generated/l10n.dart';
import '../../../router/route_config.dart';
import 'utilities_logic.dart';

class UtilitiesPage extends StatefulWidget {
  const UtilitiesPage({Key? key}) : super(key: key);

  @override
  _UtilitiesPageState createState() => _UtilitiesPageState();
}

class _UtilitiesPageState extends State<UtilitiesPage> {
  final logic = Get.put(UtilitiesLogic());
  final state = Get.find<UtilitiesLogic>().state;

  @override
  Widget build(BuildContext context) {
    final body1 = Theme.of(context).textTheme.bodyText1;
    return Scaffold(
      appBar: AppBarCustom(
        title: S.of(context).utilities,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            //
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  boxShadow: AppShadow.boxShadow, color: AppColors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      S.of(context).money_exchange,
                      style: body1?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Divider(
                      thickness: 1,
                      height: 32,
                    ),
                  ),
                  rowButton(
                      onTap: () {
                      },
                      title: S.of(context).advance_money,
                      button: AppImages.cash_wallet),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Divider(
                      thickness: 1,
                      height: 32,
                    ),
                  ),
                  rowButton(
                      onTap: () {
                        Get.toNamed(RouteConfig.money_transfer);

                      },
                      title: S.of(context).transfer,
                      button: AppImages.cash_wallet_green),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Divider(
                      thickness: 1,
                      height: 32,
                    ),
                  ),
                  rowButton(
                      onTap: () {},
                      title: S.of(context).instructions_payment,
                      button: AppImages.internet),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const SizedBox(height: 16),
            //
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  boxShadow: AppShadow.boxShadow, color: AppColors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      S.of(context).stock_exchange,
                      style: body1?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Divider(
                      thickness: 1,
                      height: 32,
                    ),
                  ),
                  rowButton(
                      onTap: () {},
                      title: S.of(context).transfer_stock,
                      button: AppImages.trade_increase),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Divider(
                      thickness: 1,
                      height: 32,
                    ),
                  ),
                  rowButton(
                      onTap: () {},
                      title: S.of(context).advance_action,
                      button: AppImages.communicate),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Divider(
                      thickness: 1,
                      height: 32,
                    ),
                  ),
                  rowButton(
                      onTap: () {},
                      title: S.of(context).statement,
                      button: AppImages.not_book),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const SizedBox(height: 16),
            //
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  boxShadow: AppShadow.boxShadow, color: AppColors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      S.of(context).profile_info,
                      style: body1?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Divider(
                      thickness: 1,
                      height: 32,
                    ),
                  ),
                  rowButton(
                      onTap: () {},
                      title: S.of(context).account_info,
                      button: AppImages.user_circle),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Divider(
                      thickness: 1,
                      height: 32,
                    ),
                  ),
                  rowButton(
                      onTap: () {},
                      title: S.of(context).change_password,
                      button: AppImages.lock),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Divider(
                      thickness: 1,
                      height: 32,
                    ),
                  ),
                  rowButton(
                      onTap: () {
                        Get.toNamed(RouteConfig.settings);
                      },
                      title: S.of(context).settings,
                      button: AppImages.setting),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Divider(
                      thickness: 1,
                      height: 32,
                    ),
                  ),
                  rowButton(
                      onTap: () {
                        Get.offAllNamed(RouteConfig.login);
                      },
                      title: S.of(context).logout,
                      button: AppImages.logout),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rowButton(
      {required String button,
      required String title,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 20),
        child: Row(
          children: [
            SvgPicture.asset(button),
            const SizedBox(width: 16),
            Expanded(
                child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(fontWeight: FontWeight.w700),
            )),
            SvgPicture.asset(AppImages.vector)
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<UtilitiesLogic>();
    super.dispose();
  }
}
