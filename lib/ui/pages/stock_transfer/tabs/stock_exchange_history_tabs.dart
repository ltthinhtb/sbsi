import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as la;
import '../../../../common/app_colors.dart';
import '../../../../common/app_images.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/date_utils.dart';
import '../../../widgets/textfields/app_text_field.dart';
import '../stock_transfer_logic.dart';
import '../widget/shareTransferWidget.dart';

class StockExchangeHistory extends StatefulWidget {
  const StockExchangeHistory({Key? key}) : super(key: key);

  @override
  State<StockExchangeHistory> createState() => _StockExchangeHistoryState();
}

class _StockExchangeHistoryState extends State<StockExchangeHistory> with AutomaticKeepAliveClientMixin{
  final logic = Get.put(StockTransferLogic());
  final state = Get.find<StockTransferLogic>().state;

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
    return Column(
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
                        DateTimeUtils.toDateString(date, format: "dd/MM/yyyy");
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
                    state.endDateController.text =
                        DateTimeUtils.toDateString(date, format: "dd/MM/yyyy");
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
                child: buildListTransfer(),
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget buildHeader() {
    final caption = Theme.of(context).textTheme.caption;
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 87,
            child: Text(
              S.of(context).time,
              style: caption?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            flex: 86,
            child: Center(
              child: Text(
                S.of(context).transfer_type,
                style: caption?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Expanded(
            flex: 86,
            child: Text(
              S.of(context).volume,
              style: caption?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            flex: 96,
            child: Text(
              S.of(context).status,
              style: caption?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListTransfer() {
    return Obx(
      () {
        return ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: state.listShareHistory.length,
          itemBuilder: (context, idx) {
            final shareHistory = state.listShareHistory[idx];
            return ShareTransferWidget(
              history: shareHistory,
              index: idx,
            );
          },
        );
      },
    );
  }

  void checkTime() {
    if (statDate.difference(endDate).inDays <= 0) {
      logic.getListShareTransfer();
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
