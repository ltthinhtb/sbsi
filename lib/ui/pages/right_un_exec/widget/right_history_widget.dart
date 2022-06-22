import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sbsi/model/entities/right_history.dart';

import '../../../../common/app_colors.dart';
import '../../../../utils/money_utils.dart';
import '../../../widgets/animation_widget/expanded_widget.dart';
import '../right_un_exec_logic.dart';

class RightHistoryWidget extends StatefulWidget {
  final RightHistory history;
  final int index;
  const RightHistoryWidget({Key? key, required this.history, required this.index}) : super(key: key);

  @override
  State<RightHistoryWidget> createState() => _RightHistoryWidgetState();
}

class _RightHistoryWidgetState extends State<RightHistoryWidget> {
  bool _isExpanded = false;

  final state = Get.find<RightUnExecLogic>().state;
  final logic = Get.find<RightUnExecLogic>();

  @override
  Widget build(BuildContext context) {
    final caption = Theme.of(context).textTheme.caption;
    final body2 = Theme.of(context).textTheme.caption;
    Logger().d(widget.history.toJson());
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 11, 16, 13),
            decoration: BoxDecoration(
                color: _isExpanded
                    ? const Color.fromRGBO(221, 221, 221, 1)
                    : (widget.index % 2 == 0
                    ? const Color.fromRGBO(247, 247, 247, 1)
                    : AppColors.white)),
            child: Row(
              children: [
                Expanded(
                    flex: 62,
                    child: Text(
                      widget.history.cSHARECODE ?? "",
                      style: caption?.copyWith(fontWeight: FontWeight.w700),
                    )),
                Expanded(
                    flex: 80,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        MoneyFormat.formatMoneyRound(
                            '${widget.history.cRIGHTVOLUME}'),
                        style: caption,
                      ),
                    )),
                Expanded(
                    flex: 62,
                    child: Align(
                      alignment: Alignment.centerRight,

                      child: Text(widget.history.cRIGHTRATE?.trim() ?? "",
                        style: caption,
                      ),
                    )),
                Expanded(
                    flex: 80,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(widget.history.cEXECUTEDATE ?? "",
                        style: caption,
                      ),
                    )),
              ],
            ),
          ),
        ),
        ExpandedSection(
          child: Container(
            decoration:
            const BoxDecoration(color: AppColors.whiteF7, boxShadow: [
              BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 10,
                  color: Color.fromRGBO(0, 0, 0, 0.08))
            ]),
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Giá mua", style: body2),
                    Text(MoneyFormat.formatMoneyRound('${widget.history.cBUYPRICE}'),
                      style: body2?.copyWith(fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Loại quyền", style: body2),
                    Text('${widget.history.cRIGHTTYPE}',
                      style: body2?.copyWith(fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                Visibility(
                  visible: !widget.history.ratePercent,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Mã CK được nhận / được mua", style: body2),
                        Text('${widget.history.cReceiverCode}',
                          style: body2?.copyWith(fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.history.ratePercent,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Số tiền được nhận", style: body2),
                        Text(MoneyFormat.formatMoneyRound('${widget.history.cCASHVOLUME}'),
                          style: body2?.copyWith(fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: !widget.history.ratePercent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Số chứng khoán được nhận", style: body2),
                      Text('${widget.history.cSHAREDIVIDENT}',
                        style: body2?.copyWith(fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),


              ],
            ),
          ),
          expand: _isExpanded,
        )
      ],
    );
  }
}
