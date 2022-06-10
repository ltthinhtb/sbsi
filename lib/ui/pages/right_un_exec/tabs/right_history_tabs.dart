import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/ui/pages/right_un_exec/right_un_exec_logic.dart';
import 'package:intl/intl.dart' as la;

import '../../../../common/app_colors.dart';
import '../../../../common/app_images.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/date_utils.dart';
import '../../../commons/app_snackbar.dart';
import '../../../widgets/textfields/app_text_field.dart';
import '../widget/right_history_widget.dart';

class RightHistoryTab extends StatefulWidget {
  const RightHistoryTab({Key? key}) : super(key: key);

  @override
  State<RightHistoryTab> createState() => _RightHistoryTabState();
}

class _RightHistoryTabState extends State<RightHistoryTab>
    with AutomaticKeepAliveClientMixin {
  final logic = Get.put(RightUnExecLogic());
  final state = Get.find<RightUnExecLogic>().state;

  DateTime get statDate {
    try {
      var format = la.DateFormat("dd/MM/yyyy");
      var date = format.parse(state.startDateController.text);
      return date;
    } catch (e) {
      return DateTime.now();
    }
  }

  DateTime get endDate {
    try {
      var format = la.DateFormat("dd/MM/yyyy");
      var date = format.parse(state.endDateController.text);
      return date;
    } catch (e) {
      return DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                    child: AppTextFieldWidget(
                  readOnly: true,
                  onTap: () async {
                    var date = await showDatePicker(
                        context: context,
                        locale: Get.locale,
                        firstDate:
                            DateTime.now().add(const Duration(days: -1000)),
                        lastDate: DateTime.now().add(const Duration(days: 30)),
                        initialDate: statDate);
                    if (date != null) {
                      state.startDateController.text =
                          DateTimeUtils.toDateString(date,
                              format: "dd/MM/yyyy");
                      checkTime();
                    }
                  },
                  inputController: state.startDateController,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: SvgPicture.asset(AppImages.calendar),
                  ),
                  hintText: "Từ ngày",
                )),
                const SizedBox(width: 16),
                Expanded(
                    child: AppTextFieldWidget(
                  readOnly: true,
                  onTap: () async {
                    var date = await showDatePicker(
                        context: context,
                        locale: Get.locale,
                        firstDate: statDate.add(const Duration(days: -1000)),
                        lastDate: DateTime.now().add(const Duration(days: 30)),
                        initialDate: endDate);
                    if (date != null) {
                      state.endDateController.text = DateTimeUtils.toDateString(
                          date,
                          format: "dd/MM/yyyy");
                      checkTime();
                    }
                  },
                  inputController: state.endDateController,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: SvgPicture.asset(AppImages.calendar),
                  ),
                  hintText: "Đến ngày",
                )),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
              child: Container(
            decoration: const BoxDecoration(color: AppColors.white),
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                buildHeader(),
                const SizedBox(height: 16),
                Expanded(
                  child: buildListOrder(),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget buildHeader() {
    final caption = Theme.of(context).textTheme.caption;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
              flex: 62,
              child: Text(
                S.of(context).stock_code,
                style: caption?.copyWith(fontWeight: FontWeight.w700),
              )),
          Expanded(
              flex: 130,
              child: Text(
                "Số CK hưởng quyền",
                style: caption?.copyWith(fontWeight: FontWeight.w700),
              )),
          Expanded(
              flex: 53,
              child: Text(
                S.of(context).rate,
                style: caption?.copyWith(fontWeight: FontWeight.w700),
              )),
          Expanded(
              flex: 94,
              child: Text(
                "Ngày thực hiện",
                style: caption?.copyWith(fontWeight: FontWeight.w700),
              )),
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
          itemCount: state.listRightHistory.length,
          itemBuilder: (context, idx) {
            return RightHistoryWidget(
              history: state.listRightHistory[idx],
              index: idx,
            );
          },
        );
      },
    );
  }

  void checkTime() {
    if (state.startDateController.text.isNotEmpty &&
        state.endDateController.text.isNotEmpty &&
        statDate.difference(endDate).inDays <= 0) {
      logic.getListRightHistory();
    }
    else{
      AppSnackBar.showError(message: S.of(context).day_error);
    }
  }

  @override
  bool get wantKeepAlive => true;
}
