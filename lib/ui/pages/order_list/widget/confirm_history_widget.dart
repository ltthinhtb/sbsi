import 'package:flutter/material.dart';
import 'package:sbsi/model/entities/confirm_history_order.dart';
import 'package:sbsi/ui/widgets/animation_widget/expanded_widget.dart';

import '../../../../common/app_colors.dart';
import '../../../../generated/l10n.dart';

class ConfirmHistoryWidget extends StatefulWidget {
  final OrderConfirmHistory history;
  final int index;

  const ConfirmHistoryWidget(
      {Key? key, required this.history, required this.index})
      : super(key: key);

  @override
  State<ConfirmHistoryWidget> createState() => _ConfirmHistoryWidgetState();
}

class _ConfirmHistoryWidgetState extends State<ConfirmHistoryWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final caption = Theme.of(context).textTheme.caption;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
            decoration: BoxDecoration(
                color: isExpanded
                    ? AppColors.tableHover
                    : (widget.index % 2 == 0
                        ? AppColors.whiteF7
                        : AppColors.white)),
            child: Row(
              children: [
                Expanded(
                  flex: 80,
                  child: Text(
                    widget.history.cSHARECODE ?? "",
                    style: caption,
                  ),
                ),
                Expanded(
                  flex: 75,
                  child: Center(
                    child: Text(
                      '${widget.history.cORDERNO ?? ""}',
                      style: caption,
                    ),
                  ),
                ),
                Expanded(
                  flex: 80,
                  child: Center(
                    child: Text(
                      '${widget.history.cORDERVOLUME ?? ""}',
                      textAlign: TextAlign.center,
                      style: caption,
                    ),
                  ),
                ),
                Expanded(
                  flex: 80,
                  child: Center(
                    child: Text(
                      widget.history.cSHOWPRICE ?? "",
                      textAlign: TextAlign.center,
                      style: caption,
                    ),
                  ),
                ),
                Expanded(
                  flex: 85,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      widget.history.sideString(context),
                      style: caption?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: widget.history.colorBack),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ExpandedSection(
            expand: isExpanded,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.of(context).order_time, style: caption),
                      Text(widget.history.cORDERTIME ?? "",
                          style:
                              caption?.copyWith(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.of(context).confirm_time, style: caption),
                      Text(widget.history.cCONFIRMTIME ?? "",
                          style:
                          caption?.copyWith(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.of(context).status, style: caption),
                      Text(widget.history.cCONFIRMSTATUS ?? "",
                          style:
                          caption?.copyWith(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

              ],
            ))
      ],
    );
  }
}
