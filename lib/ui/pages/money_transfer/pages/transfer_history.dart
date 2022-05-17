import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_images.dart';
import 'package:sbsi/ui/commons/appbar.dart';
import 'package:sbsi/ui/widgets/textfields/app_text_field.dart';
import 'package:sbsi/utils/date_utils.dart';
import 'package:intl/intl.dart' as la;
import 'package:sbsi/utils/money_utils.dart';

import '../../../../common/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../../model/response/list_account_response.dart';
import '../../../../services/auth_service.dart';
import '../../../widgets/dropdown/app_drop_down.dart';
import '../money_transfer_logic.dart';

class TransferHistory extends StatefulWidget {
  const TransferHistory({Key? key}) : super(key: key);

  @override
  State<TransferHistory> createState() => _TransferHistoryState();
}

class _TransferHistoryState extends State<TransferHistory> {
  final state = Get.find<MoneyTransferLogic>().state;
  final logic = Get.find<MoneyTransferLogic>();

  DateTime get statDate {
    try {
      var format = la.DateFormat("dd/MM/yyyy");
      var date = format.parse(state.startDateController.text);
      return date;
    } catch (e) {
      return DateTime.now();
    }
  }

  DateTime get endDate {
    try {
      var format = la.DateFormat("dd/MM/yyyy");
      var date = format.parse(state.endDateController.text);
      return date;
    } catch (e) {
      return DateTime.now();
    }
  }

  @override
  void initState() {
    super.initState();
    checkTime();
  }

  @override
  Widget build(BuildContext context) {
    final body1 = Theme.of(context).textTheme.bodyText1;
    final caption = Theme.of(context).textTheme.bodyText1;

    return Scaffold(
      appBar: AppBarCustom(
        title: S.of(context).history_transfer,
        isCenter: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(() {
                var listAccount = Get.find<AuthService>().listAccount;
                return AppDropDownWidget<Account>(
                  items: listAccount
                      .map((e) => DropdownMenuItem<Account>(
                          child: Text(e.accCode ?? ""), value: e))
                      .toList(),
                  value: state.account.value,
                  onChanged: (account) {
                    logic.changeAccount(account!);
                    checkTime();
                  },
                );
              }),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                      child: AppTextFieldWidget(
                    readOnly: true,
                    onTap: () async {
                      var date = await showDatePicker(
                          context: context,
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                          locale: Get.locale,
                          firstDate:
                              DateTime.now().add(const Duration(days: -90)),
                          lastDate:
                              DateTime.now().add(const Duration(days: 30)),
                          initialDate: statDate);
                      if (date != null) {
                        state.startDateController.text =
                            DateTimeUtils.toDateString(date,
                                format: "dd/MM/yyyy");
                        checkTime();

                      }
                    },
                    inputController: state.startDateController,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: SvgPicture.asset(AppImages.calendar),
                    ),
                    hintText: "Từ ngày",
                  )),
                  const SizedBox(width: 16),
                  Expanded(
                      child: AppTextFieldWidget(
                    readOnly: true,
                    onTap: () async {
                      var date = await showDatePicker(
                          context: context,
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                          locale: Get.locale,
                          firstDate: statDate.add(const Duration(days: -90)),
                          lastDate:
                              DateTime.now().add(const Duration(days: 30)),
                          initialDate: endDate);
                      if (date != null) {
                        state.endDateController.text =
                            DateTimeUtils.toDateString(date,
                                format: "dd/MM/yyyy");
                        checkTime();
                      }
                    },
                    inputController: state.endDateController,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: SvgPicture.asset(AppImages.calendar),
                    ),
                    hintText: "Đến ngày",
                  )),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                S.of(context).list_history,
                style: body1?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                height: 16,
                color: AppColors.grayF2,
                thickness: 1,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Expanded(
                      flex: 87,
                      child: Text(
                        S.of(context).time,
                        style: caption?.copyWith(fontWeight: FontWeight.w700),
                      )),
                  Expanded(
                      flex: 86,
                      child: Text(
                        S.of(context).transfer_type,
                        style: caption?.copyWith(fontWeight: FontWeight.w700),
                      )),
                  Expanded(
                      flex: 86,
                      child: Text(
                        S.of(context).money_1,
                        style: caption?.copyWith(fontWeight: FontWeight.w700),
                      )),
                  Expanded(
                      flex: 95,
                      child: Text(
                        S.of(context).status,
                        style: caption?.copyWith(fontWeight: FontWeight.w700),
                      ))
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(child: Obx(() {
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  var history = state.listHistory[index];
                  return Container(
                    decoration: BoxDecoration(
                        color: index % 2 == 0
                            ? AppColors.whiteF7
                            : AppColors.white),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 12, bottom: 12),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 87,
                              child: Text(
                                history.timeString,
                                style: caption?.copyWith(),
                              )),
                          Expanded(
                              flex: 86,
                              child: Text(
                                history.type,
                                style: caption?.copyWith(),
                              )),
                          Expanded(
                              flex: 86,
                              child: Text(
                                MoneyFormat.formatMoneyRound(
                                    '${history.cCASHVOLUME}'),
                                style: caption?.copyWith(),
                              )),
                          Expanded(
                              flex: 95,
                              child: Text(
                                history.cSTATUSNAME ?? "",
                                style: caption?.copyWith(
                                    color: history.statusColor),
                              ))
                        ],
                      ),
                    ),
                  );
                },
                itemCount: state.listHistory.length,
              );
            })),
            const SizedBox(height: 16)
          ],
        ),
      ),
    );
  }

  void checkTime() {
    if(statDate.difference(endDate).inDays <= 0) {
      logic.getTransfersHistory();
    };
  }
}
