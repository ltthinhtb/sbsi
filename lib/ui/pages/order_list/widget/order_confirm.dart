import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/model/entities/confirm_order.dart';
import 'package:sbsi/utils/validator.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_images.dart';
import '../../../../utils/money_utils.dart';

import '../order_list_logic.dart';

class ConfirmOrderWidget extends StatefulWidget {
  final OrderConfirm listOrder;
  final int index;

  const ConfirmOrderWidget(
      {Key? key, required this.listOrder, required this.index})
      : super(key: key);

  @override
  State<ConfirmOrderWidget> createState() => _ConfirmOrderWidgetState();
}

class _ConfirmOrderWidgetState extends State<ConfirmOrderWidget>
    with Validator {
  final state = Get.find<OrderListLogic>().state;
  final logic = Get.find<OrderListLogic>();

  ValueNotifier<bool> _isSelect = ValueNotifier<bool>(false);

  final priceController = TextEditingController();
  final volumeController = TextEditingController();

  @override
  void initState() {
    // listen select all note
    state.isSelectAllConfirmOrder.listen((p0) {
      _isSelect.value = p0;
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return buildItem(widget.listOrder);
  }

  Widget buildItem(OrderConfirm data) {
    //String _status = data.cCONFIRMSTATUS ?? "";
    final caption = Theme.of(context).textTheme.caption;
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 3),
      decoration: BoxDecoration(
          color: widget.index % 2 == 0 ? AppColors.whiteF7 : AppColors.white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
              onTap: () {
                _isSelect.value = !_isSelect.value;
                if (_isSelect.value) {
                  logic.addSelectOrderConfirm(data);
                } else {
                  logic.removeSelectConfirm(data);
                }
              },
              child: ValueListenableBuilder<bool>(
                valueListenable: _isSelect,
                builder: (BuildContext context, bool value, Widget? child) {
                  return SvgPicture.asset(
                    value ? AppImages.tickActive : AppImages.tick,
                    width: 24,
                  );
                },
              )),
          const SizedBox(width: 10),
          Expanded(
            flex: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 16,
                      width: 16,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: data.colorBack,
                          borderRadius: BorderRadius.circular(4)),
                      child: Text(
                        data.sideString,
                        style: caption?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.white),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      data.cSHARECODE ?? "",
                      style: caption?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      "${data.cORDERDATE ?? ""}",
                      style: caption?.copyWith(fontSize: 10),
                    ),
                    const SizedBox(
                        height: 8,
                        child: VerticalDivider(
                          color: AppColors.divider,
                          thickness: 1,
                          width: 6,
                        )),
                    Text(
                      data.time,
                      style: caption?.copyWith(fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 75,
            child: Center(
              child: Text(
                data.cORDERNO?.toStringAsFixed(0) ?? "",
                style: caption?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Expanded(
            flex: 80,
            child: Center(
              child: Text(
                MoneyFormat.formatMoneyRound('${data.cORDERVOLUME}'),
                style: caption?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Expanded(
            flex: 80,
            child: Center(
              child: Text(
                data.cSHOWPRICE ?? "",
                style: caption?.copyWith(
                    fontWeight: FontWeight.w400, color: data.colorBack),
              ),
            ),
          ),
          Expanded(
            flex: 95,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "-",
                textAlign: TextAlign.center,
                style: caption,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
