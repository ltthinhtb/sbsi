import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';

import '../../../../common/app_images.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/date_utils.dart';
import '../../../commons/app_snackbar.dart';
import '../../../widgets/textfields/app_text_field.dart';
import '../cash_transaction_logic.dart';
import 'package:intl/intl.dart' as la;

import '../widget/transaction_widget.dart';

class TransactionMoney extends StatefulWidget {
  const TransactionMoney({Key? key}) : super(key: key);

  @override
  State<TransactionMoney> createState() => _TransactionMoneyState();
}

class _TransactionMoneyState extends State<TransactionMoney> {
  final logic = Get.put(CashTransactionLogic());
  final state = Get.find<CashTransactionLogic>().state;

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
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
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
                        locale: Get.locale,
                        firstDate:
                            DateTime.now().add(const Duration(days: -1000)),
                        lastDate: DateTime.now().add(const Duration(days: 30)),
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
                        locale: Get.locale,
                        firstDate: statDate.add(const Duration(days: -1000)),
                        lastDate: DateTime.now().add(const Duration(days: 30)),
                        initialDate: endDate);
                    if (date != null) {
                      state.endDateController.text = DateTimeUtils.toDateString(
                          date,
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
          const SizedBox(
            height: 16,
          ),
          Expanded(
              child: Container(
            decoration: const BoxDecoration(color: AppColors.white),
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                buildHeader(),
                const SizedBox(height: 16),
                Expanded(
                  child: buildListOrder(),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget buildHeader() {
    final caption = Theme.of(context).textTheme.caption;
    return Container(
      padding: const EdgeInsets.only(
        left: 18,
        right: 18
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              S.of(context).time,
              style: caption?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'PS tăng/giảm',
                style: caption?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Số dư cuối kỳ",
                style: caption?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListOrder() {
    return Obx(
      () {
        return ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: state.listTransaction.length,
          itemBuilder: (context, idx) {
            num endBalancer = state.content.value.cCASHFISRTBALANCE ?? 0;
            for (int i = 0; i <= idx; i++) {
              endBalancer = endBalancer + state.listTransaction[i].balancerEnd;
            }
            return TransactionWidget(
              transaction: state.listTransaction[idx],
              index: idx,
              endBalancer: endBalancer,
            );
          },
        );
      },
    );
  }

  void checkTime() {
    if (state.startDateController.text.isNotEmpty &&
        state.endDateController.text.isNotEmpty &&
        statDate.difference(endDate).inDays <= 0) {
      logic.getOrderList();
    }
    else{
      AppSnackBar.showError(message: S.of(context).day_error);
    }
  }
}
