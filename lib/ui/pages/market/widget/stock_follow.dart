import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_text_styles.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/ui/pages/market/market_logic.dart';
import 'package:sbsi/utils/money_utils.dart';

import '../../../commons/app_dialog.dart';
import '../../../widgets/button/button_filled.dart';

class StockFollowView extends StatelessWidget {
  StockFollowView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<MarketLogic>().state;
    final caption = Theme.of(context).textTheme.caption;
    return Obx(() {
      if (state.listStock.isNotEmpty) {
        return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Slidable(
                closeOnScroll: true,
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  extentRatio: 0.25,
                  dragDismissible: true,
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        deleteStock(context, index);
                      },
                      backgroundColor: AppColors.red,
                      foregroundColor: Colors.white,
                      label: S.of(context).delete,
                    )
                  ],
                ),
                child: GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      color: index % 2 == 0
                          ? AppColors.whiteF7
                          : Colors.transparent,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 93,
                              child: Text(state.listStock[index].sym ?? "--",
                                  style: caption?.copyWith(
                                      fontWeight: FontWeight.w700))),
                          Expanded(
                              flex: 93,
                              child: Center(
                                child: Text(
                                  '${state.listStock[index].lastPrice?.toStringAsFixed(2) ?? "--"}',
                                  style: AppTextStyle.H7Bold.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: state.listStock[index].color!
                                          .withOpacity(1)),
                                ),
                              )),
                          Expanded(
                              flex: 93,
                              child: Center(
                                child: Text(
                                  '${state.listStock[index].ot ?? "--"}',
                                  style: AppTextStyle.H7Bold.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: state.listStock[index].color),
                                ),
                              )),
                          Expanded(
                              flex: 100,
                              child: Container(
                                alignment: Alignment.centerRight,
                                decoration: BoxDecoration(
                                    color: state.listStock[index]
                                                .mapColorChange['lastVolume'] ==
                                            true
                                        ? state.listStock[index].color!
                                            .withOpacity(0.4)
                                        : null),
                                child: Text(
                                  MoneyFormat.formatVol10(
                                      '${state.listStock[index].lot?.toInt() ?? "0"}'),
                                  style: AppTextStyle.H7Bold.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: state.listStock[index].color),
                                ),
                              )),
                        ],
                      ),
                    ),
                    onTap: () {}),
              );
            },
            itemCount: state.listStock.length);
      } else {
        return SingleChildScrollView(
          child: Column(
            children: [
              Text(S.of(context).not_found,
                  style: AppTextStyle.H6Bold.copyWith(color: AppColors.white))
            ],
          ),
        );
      }
    });
  }

  void deleteStock(BuildContext context, int index) {
    final state = Get.find<MarketLogic>().state;
    final logic = Get.find<MarketLogic>();

    AppDiaLog.showDialog(
      title: "Xác nhận xóa",
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              Text(
                'Bạn có chắc chắn muốn xoá mã?',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                      child: ButtonFill(
                    style: ElevatedButton.styleFrom(
                        onPrimary: AppColors.primary,
                        primary: const Color.fromRGBO(255, 238, 238, 1)),
                    title: S.of(context).cancel_short,
                    voidCallback: () {
                      Get.back();
                    },
                  )),
                  const SizedBox(width: 20),
                  Expanded(
                      child: ButtonFill(
                    title: S.of(context).delete,
                    voidCallback: () async {
                      if (state.listStock[index].sym != null) {
                        logic
                            .removeStockDB(state.listStock[index].sym!)
                            .then((value) => Get.back());
                      }
                    },
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
