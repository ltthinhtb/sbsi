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

import '../widget/transactin_stock_widget.dart';

class TransactionStock extends StatefulWidget {
  const TransactionStock({Key? key}) : super(key: key);

  @override
  State<TransactionStock> createState() => _TransactionStockState();
}

class _TransactionStockState extends State<TransactionStock> {
  final logic = Get.put(CashTransactionLogic());
  final state = Get.find<CashTransactionLogic>().state;

  DateTime get statDate {
    try {
      var format = la.DateFormat("dd/MM/yyyy");
      var date = format.parse(state.startDateController1.text);
      return date;
    } catch (e) {
      return DateTime.now();
    }
  }

  DateTime get endDate {
    try {
      var format = la.DateFormat("dd/MM/yyyy");
      var date = format.parse(state.endDateController1.text);
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
                      hintText: "T??? ng??y",
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
                      hintText: "?????n ng??y",
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
            flex: 62,
            child: Text(
              S.of(context).time,
              style: caption?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            flex: 79,
            child: Center(
              child: Text(
                S.of(context).time,
                style: caption?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Expanded(
            flex: 79,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                S.of(context).deposit,
                style: caption?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Expanded(
            flex: 79,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                S.of(context).widthraw,
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
          itemCount: state.listShare.length,
          itemBuilder: (context, idx) {
            return TransactionHistoryWidget(
              transaction: state.listShare[idx],
              index: idx,
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
      // logic.getOrderListHistory();
    }
    else{
      AppSnackBar.showError(message: S.of(context).day_error);
    }
  }
}
