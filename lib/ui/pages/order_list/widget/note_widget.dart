import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/ui/pages/order_list/order_list_logic.dart';
import 'package:sbsi/utils/money_utils.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_images.dart';
import '../../../../generated/l10n.dart';
import '../../../../model/order_data/change_order_data.dart';
import '../../../../model/order_data/inday_order.dart';
import '../../../../utils/error_message.dart';
import '../../../widgets/dialog/custom_dialog.dart';

class NoteWidget extends StatefulWidget {
  const NoteWidget({Key? key, required this.listOrder, required this.index})
      : super(key: key);

  final IndayOrder listOrder;
  final int index;

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  final state = Get.find<OrderListLogic>().state;
  final logic = Get.find<OrderListLogic>();

  bool _isSelect = false;

  @override
  void initState() {
    // listen select all note
    state.isSelectAll.listen((p0) {
      setState(() {
        _isSelect = p0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildItem(widget.listOrder);
  }

  Future<void> edit(BuildContext context) async {
    ChangeOrderData? _r = await CustomDialog.showChangeOrderDialog(
      context,
      S.of(context).confirm_change_order,
      [
        S.of(context).change_order,
      ],
      buttonColors: [AppColors.primary2, AppColors.primary],
      textButtonColors: [AppColors.primary, AppColors.white],
    );
    if (_r != null && _r.price.isNotEmpty && _r.vol.isNotEmpty) {
      // await changeOrder(_r);
    }
  }

  void cancel(BuildContext context) {
    logic.cancelOrder();
  }

  Widget buildItem(IndayOrder data) {
    String _status = MessageOrder.getStatusOrder(data);
    final caption = Theme.of(context).textTheme.caption;
    return Slidable(
      enabled: MessageOrder.canEdit(data),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            onPressed: edit,
            backgroundColor: const Color.fromRGBO(251, 122, 4, 1),
            foregroundColor: Colors.white,
            icon: null,
            label: 'Sửa lệnh',
          ),
          SlidableAction(
            onPressed: cancel,
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            icon: null,
            label: 'Hủy lệnh',
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 10, 0, 3),
        decoration: BoxDecoration(
            color: widget.index % 2 == 0 ? AppColors.whiteF7 : AppColors.white),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            !MessageOrder.canEdit(data)
                ? const SizedBox(width: 24)
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        _isSelect = !_isSelect;
                        if (_isSelect) {
                          logic.addSelectOrder(data);
                        } else {
                          logic.removeSelectOrder(data);
                        }
                      });
                    },
                    child: SvgPicture.asset(
                      _isSelect ? AppImages.tickActive : AppImages.tick,
                      width: 24,
                    )),
            const SizedBox(width: 20),
            Expanded(
              flex: 126,
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
                          data.sideString(context),
                          style: caption?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.white),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        data.symbol ?? "",
                        style: caption?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        "${data.orderTime ?? ""} |",
                        style: caption,
                      ),
                      const SizedBox(width: 1),
                      Text(
                        _status,
                        style: caption?.copyWith(
                            color: MessageOrder.getColorStatus(
                                MessageOrder.statusHuySua(data))),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 96,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    MoneyFormat.formatMoneyRound('${data.volume}'),
                    style: caption?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    data.showPrice ?? "",
                    style: caption?.copyWith(
                        fontWeight: FontWeight.w400, color: data.colorBack),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 95,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    MoneyFormat.formatMoneyRound('${data.matchVolume}'),
                    style: caption?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${data.matchPrice}',
                    style: caption?.copyWith(
                        fontWeight: FontWeight.w400, color: data.colorBack),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
