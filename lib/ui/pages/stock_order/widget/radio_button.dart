import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/ui/pages/stock_order/stock_order_logic.dart';

import '../enums.dart';

class RadioButton extends StatefulWidget {
  final StockFast stockFast;

  const RadioButton({Key? key, required this.stockFast}) : super(key: key);

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  bool get _isSelect =>
      widget.stockFast == Get.find<StockOrderLogic>().state.stockFast.value;
  final state = Get.find<StockOrderLogic>().state;
  final logic = Get.find<StockOrderLogic>();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          state.stockFast.value = widget.stockFast;
          logic.getOrderList();
        },
        child: Row(
          children: [
            Container(
              height: 16,
              width: 16,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary)),
              padding: const EdgeInsets.all(4),
              child: Visibility(
                visible: _isSelect,
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppColors.primary, shape: BoxShape.circle),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              widget.stockFast.name,
              style: Theme.of(context).textTheme.bodyText2,
            )
          ],
        ),
      );
    });
  }
}
