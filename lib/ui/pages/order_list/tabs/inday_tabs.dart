import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_images.dart';
import 'package:sbsi/ui/pages/order_list/widget/note_widget.dart';
import 'package:sbsi/ui/widgets/button/button_filled.dart';
import '../../../../common/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../../model/order_data/inday_order.dart';
import '../../../widgets/dropdown/app_drop_down.dart';
import '../../../widgets/textfields/app_text_typehead.dart';
import '../enums/order_enums.dart';
import '../order_list_logic.dart';

class InDayTab extends StatefulWidget {
  const InDayTab({Key? key}) : super(key: key);

  @override
  State<InDayTab> createState() => _InDayTabState();
}

class _InDayTabState extends State<InDayTab>
    with AutomaticKeepAliveClientMixin {
  final logic = Get.find<OrderListLogic>();
  final state = Get.find<OrderListLogic>().state;

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
                    S.of(context).order_list_day,
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
        ),
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
              child: AppTextTypeHead<IndayOrder>(
                inputController: state.stockCodeController,
                hintText: "Thêm mã CK",
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
    final caption = Theme.of(context).textTheme.caption;
    return Container(
      padding: const EdgeInsets.only(
        left: 18,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              logic.selectAll();
            },
            child: Obx(() {
              return SvgPicture.asset(
                state.isSelectAll.value ? AppImages.tickActive : AppImages.tick,
                width: 24,
              );
            }),
          ),
          const SizedBox(width: 20),
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
          itemCount: state.listOrder.length,
          itemBuilder: (context, idx) {
            return NoteWidget(
              listOrder: state.listOrder[idx],
              index: idx,
            );
          },
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
