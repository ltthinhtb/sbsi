import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_images.dart';
import 'package:sbsi/ui/pages/money_transfer/money_transfer_logic.dart';
import 'package:sbsi/utils/money_utils.dart';

import '../../../../generated/l10n.dart';

class AvailabilityMoney extends StatelessWidget {
  const AvailabilityMoney({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final body2 = Theme.of(context).textTheme.bodyText2;
    final headline6 = Theme.of(context).textTheme.headline6;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            const BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 10,
                color: Color.fromRGBO(0, 0, 0, 0.08))
          ]),
      child: Row(
        children: [
          SvgPicture.asset(AppImages.ic_money),
          const SizedBox(width: 17),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).cash_availability,
                style: body2?.copyWith(
                    color: AppColors.textSecond, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Obx(() {
                final cashAccount =
                    Get.find<MoneyTransferLogic>().state.cashAccount.value;
                return Text(
                  MoneyFormat.formatMoneyRound("${cashAccount.cCASHBALANCE}") + " đ",
                  style: headline6?.copyWith(
                      color: AppColors.active, fontWeight: FontWeight.w700),
                );
              }),
            ],
          ))
        ],
      ),
    );
  }
}
