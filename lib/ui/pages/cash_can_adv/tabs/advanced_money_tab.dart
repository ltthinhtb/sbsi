import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';

import '../../../../generated/l10n.dart';
import '../cash_can_adv_logic.dart';
import '../widget/cash_widget.dart';

class AdvancedMoneyTab extends StatefulWidget {
  const AdvancedMoneyTab({Key? key}) : super(key: key);

  @override
  State<AdvancedMoneyTab> createState() => _AdvancedMoneyTabState();
}

class _AdvancedMoneyTabState extends State<AdvancedMoneyTab>
    with AutomaticKeepAliveClientMixin {
  final state = Get.find<CashCanAdvLogic>().state;
  final logic = Get.find<CashCanAdvLogic>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final caption = Theme.of(context).textTheme.caption;
    return Column(
      children: [
        const SizedBox(height: 11),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(color: AppColors.white),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 117,
                          child: Text(
                            S.of(context).sell_day,
                            style:
                                caption?.copyWith(fontWeight: FontWeight.w700),
                          )),
                      Expanded(
                          flex: 170,
                          child: Text(
                            "Số tiền có thể ứng",
                            style:
                                caption?.copyWith(fontWeight: FontWeight.w700),
                          )),
                      Expanded(
                          flex: 80,
                          child: Text(
                            S.of(context).action,
                            style:
                                caption?.copyWith(fontWeight: FontWeight.w700),
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(child: Obx(() {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return CashCanWidget(
                        index: index,
                        cash: state.listCashCan[index],
                      );
                    },
                    itemCount: state.listCashCan.length,
                  );
                }))
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
