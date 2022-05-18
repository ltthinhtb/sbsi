import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/ui/pages/stock_detail/enums/stock_detail_tab.dart';
import 'package:sbsi/ui/widgets/dropdown/app_drop_down.dart';

import '../../../../generated/l10n.dart';
import '../../../widgets/chart/bar_chart.dart';
import '../stock_detail_logic.dart';

class StockReportTabs extends StatefulWidget {
  const StockReportTabs({Key? key}) : super(key: key);

  @override
  State<StockReportTabs> createState() => _StockReportTabsState();
}

class _StockReportTabsState extends State<StockReportTabs>
    with AutomaticKeepAliveClientMixin {
  int _indexIndicators = 0;

  int _indexIncomeState = 0;

  bool checkValueIndicators(int index) => _indexIndicators == index;

  final state = Get
      .find<StockDetailLogic>()
      .state;
  final logic = Get.find<StockDetailLogic>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final caption = Theme
        .of(context)
        .textTheme
        .caption;
    final body1 = Theme
        .of(context)
        .textTheme
        .bodyText1;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                  color: AppColors.white, boxShadow: [
                BoxShadow(
                    offset: Offset(0, -0.5),
                    blurRadius: 8,
                    color: Color.fromRGBO(0, 0, 0, 0.03)),
                BoxShadow(
                    offset: Offset(0, -1),
                    blurRadius: 10,
                    color: Color.fromRGBO(0, 0, 0, 0.04)),
              ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    return AppDropDownWidget<Tern>(
                      value: state.tern.value,
                      items: Tern.values
                          .map((e) =>
                          DropdownMenuItem(
                            child: Text(e.name),
                            value: e,
                          ))
                          .toList(),
                      onChanged: (value) {
                        state.tern.value = value!;
                        logic.getStockReport();
                      },
                    );
                  }),
                  const SizedBox(height: 16),
                  Text(
                    S
                        .of(context)
                        .Financial_details,
                    style: body1?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const Divider(
                    thickness: 1,
                    height: 16,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 234,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(242, 242, 242, 1),
                        border: Border.all(color: AppColors.grayF2, width: 1.5),
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      children: [
                        const SizedBox(height: 3),
                        Container(
                          height: 24,
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Row(
                            children: List<Widget>.generate(
                                keyIndicators.values.length, (int index) {
                              return Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _indexIndicators = index;
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: index == 0 ? 0 : 10),
                                    child: Text(
                                      keyIndicators.values[index].name,
                                      style: caption?.copyWith(
                                          color: _indexIndicators == index
                                              ? AppColors.white
                                              : AppColors.textBlack),
                                    ),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: _indexIndicators == index
                                            ? const Color.fromRGBO(
                                            249, 179, 0, 1)
                                            : null),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Obx(() {
                              return SimpleBarChart(
                                List<StockData>.generate(state.headList.length,
                                        (int index) {
                                      List<double> value = state.contentList
                                          .firstWhere((element) =>
                                      element.reportNormID ==
                                          keyIndicators
                                              .values[_indexIndicators].value)
                                          .value;
                                      return StockData(
                                          state.headList[index].termYear,
                                          value[index]);
                                    }),
                              );
                            }),
                          ),
                        ),
                        const SizedBox(height: 15)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                  color: AppColors.white, boxShadow: [
                BoxShadow(
                    offset: Offset(0, -0.5),
                    blurRadius: 8,
                    color: Color.fromRGBO(0, 0, 0, 0.03)),
                BoxShadow(
                    offset: Offset(0, -1),
                    blurRadius: 10,
                    color: Color.fromRGBO(0, 0, 0, 0.04)),
              ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S
                        .of(context)
                        .Profitability,
                    style: body1?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const Divider(
                    thickness: 1,
                    height: 16,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 234,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(242, 242, 242, 1),
                        border: Border.all(color: AppColors.grayF2, width: 1.5),
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      children: [
                        const SizedBox(height: 3),
                        Container(
                          height: 24,
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Obx(() {
                            return Row(
                              children: List<Widget>.generate(
                                  state.listIncomeState.length, (int index) {
                                return Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _indexIncomeState = index;
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: index == 0 ? 0 : 10),
                                      child: Text(
                                        state.listIncomeState[index].name,
                                        style: caption?.copyWith(
                                            color: _indexIncomeState == index
                                                ? AppColors.white
                                                : AppColors.textBlack),
                                      ),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              4),
                                          color: _indexIncomeState == index
                                              ? const Color.fromRGBO(
                                              249, 179, 0, 1)
                                              : null),
                                    ),
                                  ),
                                );
                              }),
                            );
                          }),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Obx(() {
                              return SimpleBarChart(
                                List<StockData>.generate(state.headList.length,
                                        (int index) {
                                      List<double> value = state.contentList
                                          .firstWhere((element) =>
                                      element.reportNormID ==
                                          state
                                              .listIncomeState[_indexIncomeState]
                                              .value)
                                          .value;
                                      return StockData(
                                          state.headList[index].termYear,
                                          value[index]);
                                    }),
                              );
                            }),
                          ),
                        ),
                        const SizedBox(height: 15)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
