import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_images.dart';
import 'package:sbsi/model/entities/economy.dart';
import 'package:sbsi/ui/pages/stock_detail/enums/stock_detail_tab.dart';
import 'package:sbsi/ui/pages/stock_detail/stock_detail_logic.dart';

import '../../../../generated/l10n.dart';

class AnalyticTab extends StatefulWidget {
  const AnalyticTab({Key? key}) : super(key: key);

  @override
  State<AnalyticTab> createState() => _AnalyticTabState();
}

class _AnalyticTabState extends State<AnalyticTab>
    with AutomaticKeepAliveClientMixin {
  final state = Get.find<StockDetailLogic>().state;

  List<EconomyRow> get listEco =>
      state.stockTimeLine.value == StockTimeline.hour
          ? state.listEconomyRowH
          : state.listEconomyRowD;

  EconomyRow get avgEco => listEco.firstWhere((element) => element.rowid == 2);

  EconomyRow get techEco => listEco.firstWhere((element) => element.rowid == 3);

  List<EconomyRow> get listTechnique {
    List<EconomyRow> list = [];
    for (int i = 0; i < listEco.length; i++) {
      if (listEco[i].rowid != null) {
        if (listEco[i].rowid! >= 25 &&
            listEco[i].rowid! <= 30 &&
            listEco[i].data!.length > 1) list.add(listEco[i]);
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final body1 = Theme.of(context).textTheme.bodyText1;
    final caption = Theme.of(context).textTheme.caption;

    super.build(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          topHeader(),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Khớp lệnh',
                    style: body1?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(
                    height: 16,
                    thickness: 1,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 114,
                          child: Text(
                            "Kỳ",
                            style:
                                caption?.copyWith(fontWeight: FontWeight.w700),
                          )),
                      Expanded(
                          flex: 145,
                          child: Text(
                            "Đơn giản",
                            style:
                                caption?.copyWith(fontWeight: FontWeight.w700),
                          )),
                      Expanded(
                          flex: 98,
                          child: Text(
                            "Lũy thừa",
                            style:
                                caption?.copyWith(fontWeight: FontWeight.w700),
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var key1 =
                        listTechnique[index].data?[1].split(" ").first ?? "";
                    var value1 =
                        listTechnique[index].data?[1].split(" ").last ?? "";

                    var key2 =
                        listTechnique[index].data?[2].split(" ").first ?? "";
                    var value2 =
                        listTechnique[index].data?[2].split(" ").last ?? "";

                    return Container(
                      padding: const EdgeInsets.fromLTRB(18, 12, 0, 12),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 114,
                              child: Text(
                                listTechnique[index].data?[0] ?? "",
                                style: caption?.copyWith(
                                    fontWeight: FontWeight.w700),
                              )),
                          Expanded(
                              flex: 145,
                              child: Row(
                                children: [
                                  Text(
                                    key1,
                                    style: caption,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "(${value1})",
                                    style: caption?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: getColor(value1)),
                                  ),
                                ],
                              )),
                          Expanded(
                              flex: 98,
                              child: Row(
                                children: [
                                  Text(
                                    key2,
                                    style: caption,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "(${value2})",
                                    style: caption?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: getColor(value2)),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    );
                  },
                  itemCount: listTechnique.length,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Color getColor(String text) {
    if (text.isEmpty) return AppColors.textBlack;
    if (text.contains("Bán")) {
      return AppColors.deActive;
    }
    return AppColors.active;
  }

  Widget topHeader() {
    final body2 = Theme.of(context).textTheme.bodyText2;
    final body1 = Theme.of(context).textTheme.bodyText1;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration:
          const BoxDecoration(color: AppColors.PastelSecond2, boxShadow: [
        BoxShadow(
            offset: Offset(0, -0.5),
            blurRadius: 8,
            color: Color.fromRGBO(0, 0, 0, 0.03)),
        BoxShadow(
            offset: Offset(0, -1),
            blurRadius: 10,
            color: Color.fromRGBO(0, 0, 0, 0.04))
      ]),
      child: Column(
        children: [
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: StockTimeline.values
                  .map((e) => GestureDetector(
                        onTap: () {
                          // change time line
                          state.stockTimeLine.value = e;
                        },
                        child: Text(
                          e.name(context),
                          style: body2?.copyWith(
                              fontWeight: e == state.stockTimeLine.value
                                  ? FontWeight.w700
                                  : FontWeight.w400),
                        ),
                      ))
                  .toList(),
            );
          }),
          const SizedBox(height: 12),
          Obx(() {
            String statusD = ""; // day
            String statusH = ""; // hours
            statusH = state.listEconomyRowH.first.data?.first ?? "";
            statusD = state.listEconomyRowD.first.data?.first ?? "";
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 32,
                  width: 117 / 375 * MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: state.listEconomyRowH.first.backGround,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    statusH,
                    style: body1?.copyWith(
                        color: state.listEconomyRowH.first.color),
                  ),
                ),
                Container(
                  height: 32,
                  width: 117 / 375 * MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: state.listEconomyRowD.first.backGround,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    statusD,
                    style: body1?.copyWith(
                        color: state.listEconomyRowD.first.color),
                  ),
                )
              ],
            );
          }),
          const SizedBox(height: 12),
          Obx(() {
            String text = avgEco.data?.first.replaceAll(":", "") ?? "";
            String buy =
                avgEco.data?[2].split("(").last.replaceAll(")", "") ?? "";
            String sell =
                avgEco.data?[3].split("(").last.replaceAll(")", "") ?? "";

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(child: Text(text, style: body2)),

                  SvgPicture.asset(AppImages.moreCircle),
                  Expanded(child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          Text(S.of(context).buy),
                          Text(buy,
                              style: body2?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.active)),
                        ],
                      ),
                      const SizedBox(width: 51),
                      Column(
                        children: [
                          Text(S.of(context).sell),
                          Text(sell,
                              style: body2?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.deActive)),
                        ],
                      ),
                    ],
                  ))
                ],
              ),
            );
          }),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              height: 32,
              thickness: 1,
              color: AppColors.grayF2,
            ),
          ),
          Obx(() {
            String text = techEco.data?.first.replaceAll(":", "") ?? "";
            String buy =
                techEco.data?[2].split("(").last.replaceAll(")", "") ?? "";
            String sell =
                techEco.data?[3].split("(").last.replaceAll(")", "") ?? "";

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(text, style: body2)),
                  SvgPicture.asset(AppImages.moreCircle),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            Text(S.of(context).buy),
                            Text(buy,
                                style: body2?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.active)),
                          ],
                        ),
                        const SizedBox(width: 51),
                        Column(
                          children: [
                            Text(S.of(context).sell),
                            Text(sell,
                                style: body2?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.deActive)),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
