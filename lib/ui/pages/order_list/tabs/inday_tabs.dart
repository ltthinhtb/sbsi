import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_images.dart';
import 'package:sbsi/ui/pages/order_list/widget/note_widget.dart';
import 'package:sbsi/ui/widgets/button/button_filled.dart';
import 'package:sbsi/utils/money_utils.dart';
import 'package:sbsi/utils/validator.dart';
import '../../../../common/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/dropdown/app_drop_down.dart';
import '../../../widgets/textfields/app_text_field.dart';
import '../../../widgets/textfields/app_text_typehead.dart';
import '../enums/order_enums.dart';
import '../order_list_logic.dart';

class InDayTab extends StatefulWidget {
  const InDayTab({Key? key}) : super(key: key);

  @override
  State<InDayTab> createState() => _InDayTabState();
}

class _InDayTabState extends State<InDayTab>
    with AutomaticKeepAliveClientMixin, Validator {
  final logic = Get.find<OrderListLogic>();
  final state = Get.find<OrderListLogic>().state;

  final TextEditingController pinController = TextEditingController();

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
        Obx(() {
          return Visibility(
            visible: state.selectedListOrder.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: ButtonFill(
                      voidCallback: () {
                        pinController.clear();
                        logic.selectAll(isSelect: true);
                        cancelAllOrder();
                      },
                      title: S.of(context).cancel_all_orders,
                      style: ElevatedButton.styleFrom(
                          primary: AppColors.grey_cancel_order),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: ButtonFill(
                      voidCallback: () {
                        pinController.clear();
                        if (state.selectedListOrder.isNotEmpty)
                          cancelAllOrder();
                      },
                      title: S.of(context).cancel_chose_orders,
                    ),
                  ),
                ],
              ),
            ),
          );
        })
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
                hintText: S.of(context).add_stock_1,
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
                      child: Text(e.name(context)),
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
        left: 18,right: 18
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
            flex: 96,
            child: Text(
              S.of(context).code,
              style: caption?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            flex: 96,
            child: Center(
              child: Text(
                S.of(context).order_1,
                textAlign: TextAlign.center,
                style: caption?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Expanded(
            flex: 95,
            child: Center(
              child: Text(
                S.of(context).match_1,
                textAlign: TextAlign.center,
                style: caption?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Expanded(
            flex: 95,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                S.of(context).remain_status,
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

  void cancelAllOrder() {
    Get.dialog(Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: Builder(builder: (context) {
        final body2 = Theme.of(context).textTheme.bodyText2;
        final body1 = Theme.of(context).textTheme.bodyText1;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Text(
                S.of(context).cancel_all_orders,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).number_of_order_buy,
                    style: body2?.copyWith(color: AppColors.textSecond),
                  ),
                  Text(
                    '${state.buyOrder.length}',
                    style: body1?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).buy_price,
                    style: body2?.copyWith(color: AppColors.textSecond),
                  ),
                  Text(
                    MoneyFormat.formatMoneyRound('${state.totalBuy}') + " đ",
                    style: body1?.copyWith(
                        fontWeight: FontWeight.w700, color: AppColors.active),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).number_of_order_sell,
                    style: body2?.copyWith(color: AppColors.textSecond),
                  ),
                  Text(
                    '${state.sellOrder.length}',
                    style: body1?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).sell_price,
                    style: body2?.copyWith(color: AppColors.textSecond),
                  ),
                  Text(
                    MoneyFormat.formatMoneyRound('${state.totalSell}') + " đ",
                    style: body1?.copyWith(
                        fontWeight: FontWeight.w700, color: AppColors.deActive),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).price_cancel_order,
                    style: body2?.copyWith(color: AppColors.textSecond),
                  ),
                  Text(
                    MoneyFormat.formatMoneyRound('${state.totalAmount}') + " đ",
                    style: body1,
                  ),
                ],
              ),
              const SizedBox(height: 5),
              AppTextFieldWidget(
                validator: (pin) => checkPin(pin!),
                hintText: S.of(context).input_pin,
                inputController: pinController,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                      child: ButtonFill(
                    voidCallback: () {
                      Get.back();
                    },
                    title: S.of(context).cancel_short,
                    style: ElevatedButton.styleFrom(
                        onPrimary: AppColors.primary,
                        primary: const Color.fromRGBO(255, 238, 238, 1)),
                  )),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: ButtonFill(
                          voidCallback: () {
                            logic.cancelAll(pinController.text);
                          },
                          title: S.of(context).confirm))
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      }),
    ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
