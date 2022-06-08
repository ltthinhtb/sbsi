import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/generated/l10n.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_shadows.dart';
import '../wallet_logic.dart';
import '../widget/debt_widget.dart';

class ProfitTabBar extends StatefulWidget {
  const ProfitTabBar({Key? key}) : super(key: key);

  @override
  _ProfitTabBarState createState() => _ProfitTabBarState();
}

class _ProfitTabBarState extends State<ProfitTabBar>
    with AutomaticKeepAliveClientMixin {
  final walletState = Get.find<WalletLogic>().state;
  final walletLogic = Get.find<WalletLogic>();

  @override
  Widget build(BuildContext context) {
    final caption = Theme.of(context).textTheme.caption!;
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async => walletLogic.refresh(),
      child: ListView(
        children: [
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
                color: AppColors.white, boxShadow: AppShadow.boxShadow),
            child: Obx(() {
              if(walletState.account.value.lastCharacter == "1") {
                return Center(
                  child: Text(S.of(context).not_found,style: Theme.of(context).textTheme.bodyText1,),
                );
              }
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          "STT",
                          style: caption.copyWith(
                              fontWeight: FontWeight.w700, height: 16 / 12),
                        )),
                        Expanded(
                            flex: 2,
                            child: Center(
                              child: Text(
                                S.of(context).interest,
                                style: caption.copyWith(
                                    fontWeight: FontWeight.w700,
                                    height: 16 / 12),
                              ),
                            )),
                        Expanded(
                            flex: 2,
                            child: Center(
                              child: Text(
                                "Tổng nợ phải trả",
                                style: caption.copyWith(
                                    fontWeight: FontWeight.w700,
                                    height: 16 / 12),
                              ),
                            )),
                        Expanded(
                            flex: 2,
                            child: Center(
                              child: Text(
                                "Ngày hết hạn",
                                style: caption.copyWith(
                                    fontWeight: FontWeight.w700,
                                    height: 16 / 12),
                              ),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      var portfolio = walletState.debtList[index];
                      return DebtWidget(
                          debt: portfolio, index: index);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 0);
                    },
                    itemCount: walletState.debtList.length,
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
