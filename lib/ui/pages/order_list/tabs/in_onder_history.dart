import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_images.dart';
import '../../../../common/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/date_utils.dart';
import '../../../widgets/dropdown/app_drop_down.dart';
import '../../../widgets/textfields/app_text_field.dart';
import '../../../widgets/textfields/app_text_typehead.dart';
import '../enums/order_enums.dart';
import '../order_list_logic.dart';
import 'package:intl/intl.dart' as la;

import '../widget/history_widget.dart';

class InOrderHistory extends StatefulWidget {
  const InOrderHistory({Key? key}) : super(key: key);

  @override
  State<InOrderHistory> createState() => _InOrderHistoryState();
}

class _InOrderHistoryState extends State<InOrderHistory>
    with AutomaticKeepAliveClientMixin {
  final logic = Get.find<OrderListLogic>();
  final state = Get.find<OrderListLogic>().state;

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
    final body1 = Theme.of(context).textTheme.bodyText1;
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
                    state.startDateController.text =
                        DateTimeUtils.toDateString(date, format: "dd/MM/yyyy");
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
                      firstDate: statDate.add(const Duration(days: -90)),
                      lastDate: DateTime.now().add(const Duration(days: 30)),
                      initialDate: endDate);
                  if (date != null) {
                    state.endDateController.text =
                        DateTimeUtils.toDateString(date, format: "dd/MM/yyyy");
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
        Expanded(
          child: Container(
            decoration: const BoxDecoration(color: AppColors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    S.of(context).order_list_day_history,
                    style: body1?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                const Divider(
                  thickness: 1,
                  height: 16,
                ),
                const SizedBox(height: 10),
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
                inputController: state.stockHistoryController,
                hintText: "Thêm mã CK",
                suggestionsCallback: (String pattern) {
                  var list = logic.searchStockHistoryString(pattern);
                  return list;
                },
                onSuggestionSelected: (suggestion) {
                  state.stockHistoryController.text = suggestion;
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 10,
              child: AppDropDownWidget<inOrderHisTabs>(
                items: inOrderHisTabs.values.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Container(
                      child: Text(e.name),
                    ),
                  );
                }).toList(),
                value: state.singingCharacterHistory,
                onChanged: (inOrderHisTabs? _value) {
                  logic.changeOrderHistoryListStatus(_value!);
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
      padding: const EdgeInsets.only(
        left: 18,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 126,
            child: Text(
              S.of(context).code,
              style: caption?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            flex: 96,
            child: Text(
              'Đặt (KL/Giá)',
              style: caption?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            flex: 95,
            child: Text(
              'Khớp (KL/Giá)',
              style: caption?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            flex: 95,
            child: Text(
              S.of(context).time,
              style: caption?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListOrder() {
    return Obx(
      () {
        var list = logic.searchStockHistory(state.stockHistoryController.text);
        return ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: list.length,
          itemBuilder: (context, idx) {
            return HistoryWidget(
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
      logic.getOrderListHistory();
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
