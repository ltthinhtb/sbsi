import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/ui/pages/right_un_exec/widget/deposit_expanded.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_images.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/money_utils.dart';
import '../right_un_exec_logic.dart';
import '../widget/money_expaneded.dart';
import '../widget/stock_expaned.dart';

class RightListTab extends StatefulWidget {
  const RightListTab({Key? key}) : super(key: key);

  @override
  State<RightListTab> createState() => _RightListTabState();
}

class _RightListTabState extends State<RightListTab>
    with AutomaticKeepAliveClientMixin {
  final state = Get.find<RightUnExecLogic>().state;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final body2 = Theme.of(context).textTheme.bodyText2;
    final headline6 = Theme.of(context).textTheme.headline6;
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),
          Container(
            height: 86 / 812 * MediaQuery.of(context).size.height,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  const BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 10,
                      color: Color.fromRGBO(0, 0, 0, 0.08))
                ],
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                SvgPicture.asset(AppImages.amount),
                const SizedBox(width: 15),
                Column(
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
                      var accountStatus = state.assets.value;
                      return Text(
                        MoneyFormat.formatMoneyRound(
                                '${accountStatus.assets}') +
                            " đ",
                        style: headline6?.copyWith(fontWeight: FontWeight.bold),
                      );
                    })
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          const StockExpanded(),
          const SizedBox(height: 5),
          const MoneyExpanded(),
          const SizedBox(height: 5),
          const DepositExpanded(),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
