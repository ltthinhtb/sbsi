import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/utils/validator.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_images.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/money_utils.dart';
import '../../../widgets/button/button_filled.dart';
import '../../../widgets/dropdown/app_drop_down.dart';
import '../../../widgets/textfields/app_text_field.dart';
import '../../../widgets/textfields/app_text_typehead.dart';
import '../enums/order_enums.dart';
import '../order_list_logic.dart';
import '../widget/order_confirm.dart';

class ConfirmTab extends StatefulWidget {
  const ConfirmTab({Key? key}) : super(key: key);

  @override
  State<ConfirmTab> createState() => _ConfirmTabState();
}

class _ConfirmTabState extends State<ConfirmTab>
    with AutomaticKeepAliveClientMixin, Validator {
  final logic = Get.find<OrderListLogic>();
  final state = Get.find<OrderListLogic>().state;

  final _pinController = TextEditingController();


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
            visible: state.selectedListConfirmOrder.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ButtonFill(
                      voidCallback: () {
                        _pinController.clear();
                        confirmOrder();
                      },
                      title: S.of(context).confirm_select,
                      style: ElevatedButton.styleFrom(
                          primary: AppColors.active,
                          padding: const EdgeInsets.symmetric(vertical: 5)),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ButtonFill(
                      voidCallback: () {
                        _pinController.clear();
                        confirmOrder();
                      },
                      title: S.of(context).confirm_all,
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 5)),
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
                inputController: state.stockCodeConfirmController,
                hintText: S.of(context).add_stock_1,
                suggestionsCallback: (String pattern) {
                  var list = logic.searchStockConfirmString(pattern);
                  return list;
                },
                onSuggestionSelected: (suggestion) {
                  state.stockCodeConfirmController.text = suggestion;
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
                  // logic.changeOrderListStatus(_value!);
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
          GestureDetector(
            onTap: () {
              logic.selectAllConfirm();
            },
            child: Obx(() {
              return SvgPicture.asset(
                state.isSelectAllConfirmOrder.value
                    ? AppImages.tickActive
                    : AppImages.tick,
                width: 24,
              );
            }),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 120,
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
            flex: 95,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                S.of(context).cancel_time,
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
        var list =
            logic.searchStockConfirm(state.stockCodeConfirmController.text);
        return ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: list.length,
          itemBuilder: (context, idx) {
            return ConfirmOrderWidget(
              listOrder: list[idx],
              index: idx,
            );
          },
        );
      },
    );
  }

  void confirmOrder() {
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
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       S.of(context).number_of_order_buy,
              //       style: body2?.copyWith(color: AppColors.textSecond),
              //     ),
              //     Text(
              //       '${state.buyOrder.length}',
              //       style: body1?.copyWith(fontWeight: FontWeight.w700),
              //     ),
              //   ],
              // ),
              AppTextFieldWidget(
                validator: (pin) => checkPin(pin!),
                hintText: S.of(context).input_pin,
                inputController: _pinController,
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
                            logic.cancelAllOrderConfirm(_pinController.text);
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
