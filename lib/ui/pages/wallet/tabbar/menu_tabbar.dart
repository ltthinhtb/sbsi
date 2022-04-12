import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_dimens.dart';
import 'package:sbsi/common/app_images.dart';
import 'package:sbsi/configs/app_configs.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/model/response/list_account_response.dart';
import 'package:sbsi/ui/pages/user/user_logic.dart';
import 'package:sbsi/ui/widgets/dropdown/app_drop_down.dart';
import 'package:sbsi/ui/widgets/textfields/app_text_field.dart';
import 'package:sbsi/utils/money_utils.dart';

import '../wallet_logic.dart';

class MenuTabBar extends StatefulWidget {
  const MenuTabBar({Key? key}) : super(key: key);

  @override
  _MenuTabBarState createState() => _MenuTabBarState();
}

class _MenuTabBarState extends State<MenuTabBar>
    with AutomaticKeepAliveClientMixin {
  final walletState = Get.find<WalletLogic>().state;
  final walletLogic = Get.find<WalletLogic>();

  final userState = Get.find<UserLogic>().state;

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context)
        .textTheme
        .headline6!
        .copyWith(fontWeight: FontWeight.w700);
    final headline7 = Theme.of(context)
        .textTheme
        .headline6!
        .copyWith(fontSize: 12, fontWeight: FontWeight.w400);
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async => walletLogic.onReady(),
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.marginNormal),
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppImages.menuCard),
                        fit: BoxFit.cover)),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(S.of(context).total_transfer,
                              style:
                                  headline7.copyWith(color: AppColors.white)),
                          Text(
                              MoneyFormat.formatMoneyRound(
                                  walletState.portfolioTotal.value.value ?? ""),
                              style:
                                  headline6.copyWith(color: AppColors.white)),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(S.of(context).gain_loss_temporary,
                            style: headline7.copyWith(color: AppColors.white)),
                        Text(
                            MoneyFormat.formatMoneyRound(walletState
                                    .portfolioTotal.value.gainLossValue ??
                                ""),
                            style: headline6.copyWith(color: AppColors.white)),
                      ],
                    )
                  ],
                ),
              )),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                  child: AppTextFieldWidget(
                label: S.of(context).start_day,
                hintText: AppConfigs.dateAPIFormat,
              )),
              const SizedBox(width: 15),
              Expanded(
                  child: AppTextFieldWidget(
                label: S.of(context).end_day,
                hintText: AppConfigs.dateAPIFormat,
              )),
            ],
          ),
          const SizedBox(height: 20),
          AppDropDownWidget<Account>(
              label: S.of(context).account,
              value: userState.listAccount.firstWhere(
                  (element) => element.accCode == walletLogic.defAcc,
                  orElse: () {
                return Account(accCode: walletLogic.defAcc);
              }),
              onChanged: (value) {
                walletLogic.getPortfolio(account: value!.accCode);
                walletLogic.getAccountStatus(account: value.accCode);
              },
              items: userState.listAccount
                  .map((e) => DropdownMenuItem<Account>(
                        value: e,
                        onTap: () {},
                        child: Text(e.accCode ?? ""),
                      ))
                  .toList()),
          const SizedBox(height: 20),
          AppTextFieldWidget(
            hintText: S.of(context).search,
            prefixIcon: SvgPicture.asset(AppImages.search_normal),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Mã/TT",
                    style: headline7,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Tổng KD",
                        style: headline7,
                      ),
                      const SizedBox(height: 1),
                      SvgPicture.asset(AppImages.down_arrow)
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text(
                        "Giá TT/TB",
                        style: headline7,
                      ),
                      const SizedBox(height: 1),
                      SvgPicture.asset(AppImages.down_arrow)
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text(
                        "Tỉ trọng(%)",
                        style: headline7,
                      ),
                      const SizedBox(height: 1),
                      SvgPicture.asset(AppImages.down_arrow)
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text(
                        "Lãi/Lỗ tạm tính",
                        style: headline7,
                      ),
                      const SizedBox(height: 1),
                      SvgPicture.asset(AppImages.down_arrow)
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Obx(() {
            return ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text(
                                walletState.portfolioList[index].symbol ?? "",
                                style: headline6,
                              )),
                          Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  walletState
                                          .portfolioList[index].avaiableVol ??
                                      "",
                                  style: headline6,
                                ),
                              )),
                          Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  walletState.portfolioList[index].avgPrice ??
                                      "",
                                  style: headline6,
                                ),
                              )),
                          Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '${walletState.portfolioList[index].gainLossPer}',
                                  style: headline7.copyWith(
                                      color: walletState
                                          .portfolioList[index].glColor),
                                ),
                              )),
                          Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '${MoneyFormat.formatMoneyRound(walletState.portfolioList[index].gainLossValue ?? "")} đ',
                                  style: headline7.copyWith(
                                      color: walletState
                                          .portfolioList[index].glColor),
                                ),
                              )),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text(
                                S.of(context).sell_t0,
                                style: headline7,
                              )),
                          Expanded(
                              flex: 1,
                              child: Text(
                                S.of(context).sell_t1,
                                style: headline7,
                              )),
                          Expanded(
                              flex: 1,
                              child: Text(
                                S.of(context).sell_t2,
                                style: headline7,
                              )),
                          Expanded(
                              flex: 1,
                              child: Text(
                                S.of(context).sell_t_back,
                                style: headline7,
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text(
                                walletState.portfolioList[index].sellT0 ?? "",
                                style: headline6,
                              )),
                          Expanded(
                              flex: 1,
                              child: Text(
                                walletState.portfolioList[index].sellT1 ?? "",
                                style: headline6,
                              )),
                          Expanded(
                              flex: 1,
                              child: Text(
                                walletState.portfolioList[index].sellT2 ?? "",
                                style: headline6,
                              )),
                          Expanded(
                              flex: 1,
                              child: Text(
                                walletState
                                        .portfolioList[index].sellUnmatchVol ??
                                    "",
                                style: headline6,
                              )),
                        ],
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 10);
              },
              itemCount: walletState.portfolioList.length,
            );
          }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
