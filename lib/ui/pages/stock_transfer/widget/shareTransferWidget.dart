import 'package:flutter/material.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/model/entities/share_transfer_history.dart';
import 'package:sbsi/utils/money_utils.dart';

import '../../../../generated/l10n.dart';

class ShareTransferWidget extends StatelessWidget {
  final ShareTransferHistory history;
  final int index;

  const ShareTransferWidget(
      {Key? key, required this.history, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final caption = Theme.of(context).textTheme.caption;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 0, 12),
      decoration: BoxDecoration(
          color: index % 2 == 0 ? AppColors.whiteF7 : AppColors.white),
      child: Row(
        children: [
          Expanded(
            flex: 87,
            child: Text(
              history.cCREATETIME?.split(" ").first ?? "",
              style: caption,
            ),
          ),
          Expanded(
            flex: 86,
            child: Center(
              child: Text(
                S.of(context).internal,
                style: caption,
              ),
            ),
          ),
          Expanded(
            flex: 86,
            child: Text(
              MoneyFormat.formatMoneyRound('${history.cSHAREVOLUME}'),
              style: caption,
            ),
          ),
          Expanded(
            flex: 96,
            child: Text(
              history.cSTATUSNAME ?? "",
              style: caption?.copyWith(
                  fontWeight: FontWeight.w600, color: history.statusColor),
            ),
          ),
        ],
      ),
    );
  }
}
