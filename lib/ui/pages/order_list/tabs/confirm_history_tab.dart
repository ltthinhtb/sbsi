import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as la;
import '../../../../common/app_colors.dart';
import '../../../../common/app_images.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/date_utils.dart';
import '../../../commons/app_snackbar.dart';
import '../../../widgets/dropdown/app_drop_down.dart';
import '../../../widgets/textfields/app_text_field.dart';
import '../../../widgets/textfields/app_text_typehead.dart';
import '../enums/order_enums.dart';
import '../order_list_logic.dart';
import '../widget/confirm_history_widget.dart';

class ConfirmHistoryTab extends StatefulWidget {
  const ConfirmHistoryTab({Key? key}) : super(key: key);

  @override
  State<ConfirmHistoryTab> createState() => _ConfirmHistoryTabState();
}

class _ConfirmHistoryTabState extends State<ConfirmHistoryTab>
    with AutomaticKeepAliveClientMixin {
  final logic = Get.find<OrderListLogic>();
  final state = Get.find<OrderListLogic>().state;

  DateTime get statDate {
    try {
      var format = la.DateFormat("dd/MM/yyyy");
      var date = format.parse(state.startDateController2.text);
      return date;
    } catch (e) {
      return DateTime.now();
    }
  }

  DateTime get endDate {
    try {
      var format = la.DateFormat("dd/MM/yyyy");
      var date = format.parse(state.endDateController2.text);
      return date;
    } catch (e) {
      return DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: buildFilter(),
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
                      locale: Get.locale,
                      firstDate: DateTime.now().add(const Duration(days: -90)),
                      lastDate: DateTime.now().add(const Duration(days: 30)),
                      initialDate: statDate);
                  if (date != null) {
                    state.startDateController2.text =
                        DateTimeUtils.toDateString(date, format: "dd/MM/yyyy");
                    checkTime();
                  }
                },
                inputController: state.startDateController2,
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
                      firstDate: statDate.add(const Duration(days: -90)),
                      lastDate: DateTime.now().add(const Duration(days: 30)),
                      initialDate: endDate);
                  if (date != null) {
                    state.endDateController2.text =
                        DateTimeUtils.toDateString(date, format: "dd/MM/yyyy");
                    checkTime();
                  }
                },
                inputController: state.endDateController2,
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: SvgPicture.asset(AppImages.calendar),
                ),
                hintText: "Đến ngày",
              )),
            ],
          ),
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(color: AppColors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                buildHeader(),
                const SizedBox(height: 16),
                Expanded(
                  child: buildListOrder(),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildFilter() {
    return Container(
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              flex: 10,
              child: AppTextTypeHead<String>(
                inputController: state.stockCodeConfirmHistoryController,
                hintText: S.of(context).add_stock_1,
                suggestionsCallback: (String pattern) {
                  var list = logic.searchStockConfirmHistoryString(pattern);
                  return list;
                },
                onSuggestionSelected: (suggestion) {
                  state.stockCodeConfirmHistoryController.text = suggestion;
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 10,
              child: AppDropDownWidget<OderCmd>(
                items: OderCmd.values.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Container(
                      child: Text(e.name(context)),
                    ),
                  );
                }).toList(),
                value: state.cmd1,
                onChanged: (OderCmd? _value) {
                  logic.changeOrderHistoryListStatusHistory(_value!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    final caption = Theme.of(context).textTheme.caption;
    return Container(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: Row(
        children: [
          Expanded(
            flex: 80,
            child: Text(
              S.of(context).code,
              style: caption?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            flex: 75,
            child: Center(
              child: Text(
                S.of(context).order_no,
                style: caption?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Expanded(
            flex: 80,
            child: Center(
              child: Text(
                S.of(context).volume_short,
                textAlign: TextAlign.center,
                style: caption?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Expanded(
            flex: 80,
            child: Center(
              child: Text(
                S.of(context).price,
                textAlign: TextAlign.center,
                style: caption?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Expanded(
            flex: 85,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                S.of(context).orderType,
                textAlign: TextAlign.center,
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
        var list = logic.searchStockConfirmHistory(
            state.stockCodeConfirmHistoryController.text);
        return ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: list.length,
          itemBuilder: (context, idx) {
            return ConfirmHistoryWidget(
              history: list[idx],
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
      logic.getConfirmOrderListHistory();
    } else {
      AppSnackBar.showError(message: S.of(context).day_error);
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
