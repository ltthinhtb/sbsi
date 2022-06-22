import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/ui/pages/money_transfer/money_transfer_logic.dart';
import 'package:sbsi/ui/widgets/button/button_filled.dart';
import 'package:sbsi/utils/date_utils.dart';

import '../../../../common/app_images.dart';
import '../../../../generated/l10n.dart';
import '../enums/transfer_type.dart';

class TransferSuccess extends StatefulWidget {
  const TransferSuccess({Key? key}) : super(key: key);

  @override
  State<TransferSuccess> createState() => _TransferSuccessState();
}

class _TransferSuccessState extends State<TransferSuccess> {
  final state = Get.find<MoneyTransferLogic>().state;

  String get receiver => state.type == TransfersType.bank
      ? state.userNameController.text
      : (state.accountReceiver.value.accName ?? "");

  String get account => state.type == TransfersType.bank
      ? state.userAccountController.text
      : (state.accountReceiver.value.accCode ?? "");

  var date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
    final headline5 = Theme.of(context).textTheme.headline5;
    final body2 = Theme.of(context).textTheme.bodyText2;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 68),
                Center(child: SvgPicture.asset(AppImages.tick_success)),
                const SizedBox(height: 24),
                Center(
                    child: Text(
                  S.of(context).transfer_momey_success,
                  style: headline6?.copyWith(fontWeight: FontWeight.w700),
                )),
                const SizedBox(height: 16),
                Center(
                    child: Text(
                  state.moneyController.text + "VNĐ",
                  style: headline5?.copyWith(height: 32 / 26),
                )),
                const SizedBox(height: 16),
                Text(
                  S.of(context).account_receiver,
                  style: body2?.copyWith(
                      color: const Color.fromRGBO(225, 137, 150, 1)),
                ),
                const SizedBox(height: 12),
                Text(
                  receiver,
                  style: body2?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(
                  account,
                  style: body2?.copyWith(fontWeight: FontWeight.w400),
                ),
                const Divider(
                  height: 32,
                ),
                Text(
                  S.of(context).time_1,
                  style: body2?.copyWith(
                      color: const Color.fromRGBO(225, 137, 150, 1)),
                ),
                const SizedBox(height: 12),
                Text(
                  DateTimeUtils.toDateString(date,
                      format: "HH:mm:ss dd/MM/yyyy"),
                  style: body2?.copyWith(fontWeight: FontWeight.w700),
                ),
                const Divider(
                  height: 32,
                ),
                Text(
                  S.of(context).transfer_content,
                  style: body2?.copyWith(
                      color: const Color.fromRGBO(225, 137, 150, 1)),
                ),
                const SizedBox(height: 12),
                Text(
                  state.transferContentController.text,
                  style: body2?.copyWith(),
                ),
                const Spacer(),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ButtonFill(
                      voidCallback: () {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                      title: S.of(context).back_to_home),
                ),
                const SizedBox(
                  height: 32,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
