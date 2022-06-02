import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import '../../../../common/app_images.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/date_utils.dart';
import '../../../../utils/money_utils.dart';
import '../../../widgets/textfields/app_text_field.dart';
import '../cash_can_adv_logic.dart';
import 'package:intl/intl.dart' as la;

class HistoryCashTab extends StatefulWidget {
  const HistoryCashTab({Key? key}) : super(key: key);

  @override
  State<HistoryCashTab> createState() => _HistoryCashTabState();
}

class _HistoryCashTabState extends State<HistoryCashTab>
    with AutomaticKeepAliveClientMixin {
  final state = Get.find<CashCanAdvLogic>().state;
  final logic = Get.find<CashCanAdvLogic>();

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
    return Container(
      padding: const EdgeInsets.only(left: 18),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              S.of(context).time,
              style: caption?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                S.of(context).advance_amount,
                style: caption?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              S.of(context).status,
              style: caption?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListOrder() {
    final caption = Theme.of(context).textTheme.caption;
    return Obx(
      () {
        return ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: state.listAdvance.length,
          itemBuilder: (context, idx) {
            var advance = state.listAdvance[idx];
            return Container(
              padding: const EdgeInsets.only(left: 18, top: 12, bottom: 12),
              decoration: BoxDecoration(
                  color: idx % 2 == 0 ? AppColors.whiteF7 : AppColors.white),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      advance.cWITHDRAWDATE ?? "",
                      style: caption?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        MoneyFormat.formatMoneyRound('${advance.cCASHNET}'),
                        style: caption?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      advance.cSTATUSNAME ?? "",
                      style: caption?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
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
      logic.getListCashHistory();
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
