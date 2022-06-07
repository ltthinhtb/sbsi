import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_images.dart';
import 'package:sbsi/ui/pages/order_list/widget/note_widget.dart';
import '../../../../common/app_colors.dart';
import '../../../../generated/l10n.dart';
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
              child: AppTextTypeHead<String>(
                inputController: state.stockCodeController,
                hintText: "Thêm mã CK",
                suggestionsCallback: (String pattern) {
                  var list = logic.searchStockString(pattern);
                  return list;
                },
                onSuggestionSelected: (suggestion) {
                  state.stockCodeController.text = suggestion;
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
            flex: 110,
            child: Text(
              S.of(context).code,
              style: caption?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            flex: 96,
            child: Text(
              'Đặt\n(KL/Giá)',
              textAlign: TextAlign.center,
              style: caption?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            flex: 95,
            child: Text(
              'Khớp\n(KL/Giá)',
              textAlign: TextAlign.center,
              style: caption?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            flex: 95,
            child: Text(
              'KL còn lại\nTrạng thái',
              textAlign: TextAlign.center,
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
        var list = logic.searchStock(state.stockCodeController.text);
        return ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: list.length,
          itemBuilder: (context, idx) {
            return NoteWidget(
              listOrder: list[idx],
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
