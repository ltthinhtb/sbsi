import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../generated/l10n.dart';
import '../../../../model/order_data/inday_order.dart';
import '../../../../utils/error_message.dart';
import '../../../../utils/stock_utils.dart';
import '../../../widgets/animation_widget/expanded_widget.dart';
import '../../../widgets/dropdown/app_drop_down.dart';
import '../../../widgets/textfields/app_text_typehead.dart';
import '../enums/order_enums.dart';
import '../order_list_logic.dart';
import '../page/order_detail.dart';

class InDayTab extends StatefulWidget {
  const InDayTab({Key? key}) : super(key: key);

  @override
  State<InDayTab> createState() => _InDayTabState();
}

class _InDayTabState extends State<InDayTab> {

  final logic = Get.find<OrderListLogic>();
  final state = Get.find<OrderListLogic>().state;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 16),
          buildFilter(),
          const SizedBox(height: 16),
          buildHeader(),
          Expanded(
            child: buildListOrder(),
          ),
        ],
      ),
    );
  }

  Widget buildFilter() {
    return Container(
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              flex: 10,
              child: AppTextTypeHead<IndayOrder>(
                inputController: state.stockCodeController,
                suggestionsCallback: (String pattern) {
                  var list = logic.searchStock(pattern);
                  return list;
                },
                onSuggestionSelected: (suggestion) {
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 10,
              child: AppDropDownWidget<SingingCharacter>(
                items: SingingCharacter.values.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Container(
                      child: Text(e.name),
                    ),
                  );
                }).toList(),
                value: state.singingCharacter,
                onChanged: (SingingCharacter? _value) {
                  logic.changeOrderListStatus(_value!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: const BoxDecoration(
        color: AppColors.primary2,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              "${S.of(context).code}/${S.of(context).account_short}",
              style: AppTextStyle.caption,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "${S.of(context).orderType}/${S.of(context).status_short}",
              style: AppTextStyle.caption,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "${S.of(context).match}/${S.of(context).total}",
              style: AppTextStyle.caption,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "${S.of(context).match_price}/${S.of(context).price}",
              style: AppTextStyle.caption,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              S.of(context).order_number_short,
              textAlign: TextAlign.right,
              style: AppTextStyle.caption,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListOrder() {
    return Obx(
          () => ListView.builder(
        shrinkWrap: true,
        primary: false,
        // reverse: true,
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: state.listOrder.length,
        itemBuilder: (context, idx) => buildItem(state.listOrder[idx]),
      ),
    );
  }

  Widget buildItem(IndayOrder data) {
    String _status = MessageOrder.getStatusOrder(data);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: MaterialButton(
        onPressed: () {
          // Get.to(OrderDetail(data: data));
          Navigator.push(
            context,
            GetPageRoute(
              page: () => OrderDetail(data: data),
            ),
          );
        },
        onLongPress: () {
          if (!state.selectedMode.value) {
            state.selectedMode.value = true;
          }
        },
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        color: AppColors.primary2,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Row(
            children: [
              Obx(
                    () => ExpandedSection(
                  expand: state.selectedMode.value,
                  axis: Axis.horizontal,
                  child: Transform.scale(
                    scale: 1.2,
                    child: showCheckBox(_status)
                        ? Checkbox(
                      // hoverColor: AppColors.green,
                      fillColor: MaterialStateProperty.resolveWith(
                              (states) => getColor(states)),
                      checkColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(3)),
                        side: BorderSide(
                          color: logic.itemIsChecked(data.orderNo!)
                              ? Colors.black
                              : AppColors.green,
                        ),
                      ),
                      side: const BorderSide(),
                      value: logic.itemIsChecked(data.orderNo!),
                      onChanged: (value) {
                        if (value!) {
                          state.selectedListOrder.add(data);
                        } else {
                          state.selectedListOrder.removeWhere((element) =>
                          element.orderNo == data.orderNo);
                        }
                      },
                    )
                        : Container(
                      width: 18,
                      height: 18,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.symbol ?? "null",
                      style: AppTextStyle.bodyText2,
                    ),
                    Text(
                      data.accountCode ?? "null",
                      style: AppTextStyle.bodyText1,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.side == "B" ? S.of(context).buy : S.of(context).sell,
                      style: AppTextStyle.bodyText2.copyWith(
                        color:
                        data.side == "B" ? AppColors.green : AppColors.red,
                      ),
                    ),
                    Text(
                      _status,
                      style: AppTextStyle.bodyText1,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.matchVolume.toString(),
                      style: AppTextStyle.bodyText2,
                    ),
                    Text(
                      data.volume.toString(),
                      style: AppTextStyle.bodyText1,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      StockUtil.formatPrice(data.matchPrice),
                      style: AppTextStyle.bodyText2,
                    ),
                    Text(
                      data.showPrice.toString(),
                      style: AppTextStyle.bodyText1,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      data.orderNo!,
                      style: AppTextStyle.bodyText2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool showCheckBox(String status) {
    switch (status) {
      case "Khớp 1 phần":
        return true;
      case "Chờ khớp":
        return true;
      default:
        return false;
    }
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
      MaterialState.scrolledUnder,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.transparent;
    }
    return AppColors.green;
  }
}
