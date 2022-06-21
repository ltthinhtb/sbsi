import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/ui/pages/right_un_exec/widget/right_widget.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_images.dart';
import '../../../../generated/l10n.dart';
import '../../../../model/entities/right_exc.dart';
import '../../../widgets/animation_widget/expanded_widget.dart';
import '../right_un_exec_logic.dart';

class MoneyExpanded extends StatefulWidget {
  const MoneyExpanded({Key? key}) : super(key: key);

  @override
  State<MoneyExpanded> createState() => _MoneyExpandedState();
}

class _MoneyExpandedState extends State<MoneyExpanded> {
  bool _isExpanded = false;

  final state = Get.find<RightUnExecLogic>().state;

  @override
  Widget build(BuildContext context) {
    final caption = Theme.of(context).textTheme.caption;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
                color: _isExpanded ? AppColors.tableHover : AppColors.white,
                boxShadow: [
                  const BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 20,
                      color: Color.fromRGBO(0, 0, 0, 0.05))
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Quyền cổ tức bằng tiền',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                SvgPicture.asset(AppImages.down)
              ],
            ),
          ),
        ),
        ExpandedSection(
          expand: _isExpanded,
          child: Container(
            decoration: const BoxDecoration(color: AppColors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 62,
                          child: Text(
                            S.of(context).stock_code,
                            style:
                                caption?.copyWith(fontWeight: FontWeight.w700),
                          )),
                      Expanded(
                          flex: 130,
                          child: Text(
                            "Số CK hưởng quyền",
                            style:
                                caption?.copyWith(fontWeight: FontWeight.w700),
                          )),
                      Expanded(
                          flex: 53,
                          child: Text(
                            '%${S.of(context).rate}',
                            style:
                                caption?.copyWith(fontWeight: FontWeight.w700),
                          )),
                      Expanded(
                          flex: 94,
                          child: Text(
                            "Số tiền nhận được",
                            style:
                                caption?.copyWith(fontWeight: FontWeight.w700),
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Obx(() {
                  List<RightExc> listRight = [];
                  state.listRightExt.forEach((element) {
                    if (element.cRIGHTTYPENAMEEN != "Right buy" && element.cCASHVOLUME !=0) {
                      listRight.add(element);
                    }
                  });
                  return ListView.builder(
                      itemCount: listRight.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return RightWidget(
                          index: index,
                          right: listRight[index],
                          isMoney: true,
                        );
                      });
                })
              ],
            ),
          ),
        ),
      ],
    );
  }
}
