import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_text_styles.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/ui/pages/home/home_logic.dart';

class StockForeignView extends StatelessWidget {
  StockForeignView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<HomeLogic>().state;
    return Container(
      // child: Column(
      //   children: [
      //     Obx(() {
      //       if (state.listStockForeign.isNotEmpty) {
      //         return ListView.builder(
      //             shrinkWrap: true,
      //             physics: NeverScrollableScrollPhysics(),
      //             itemBuilder: (context, index) {
      //               return buildStockItem(
      //                   state.listStockForeign[index], index, context);
      //             },
      //             itemCount: state.listStockForeign.length);
      //       } else {
      //         return Center(child: Text(S.of(context).not_found));
      //       }
      //     })
      //   ],
      // ),
    );
  }

  // Widget buildStockItem(StockForeign data, int index, BuildContext context) {
  //   int flex = 4;
  //   return GestureDetector(
  //       child: Container(
  //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
  //     color: index % 2 == 0 ? AppColors.backgroundTopStock : Colors.transparent,
  //     child: Row(
  //       children: [
  //         Expanded(
  //             flex: flex,
  //             child: Row(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 SvgPicture.asset("assets/icon_svg/${data.iDSYMBOL}.svg"),
  //                 SizedBox(width: 4),
  //                 Text(
  //                   '${data.nAME ?? "--"}',
  //                   style: AppTextStyle.H7Bold.copyWith(
  //                       fontWeight: FontWeight.w700, color: data.color),
  //                 )
  //               ],
  //             )),
  //         Expanded(
  //           flex: flex*2~/3,
  //           child: Align(
  //             alignment: Alignment.centerRight,
  //             child: Text(
  //               data.lASTPOINT ?? "0",
  //               style: AppTextStyle.H7Bold.copyWith(
  //                   fontWeight: FontWeight.w700, color: data.color),
  //             ),
  //           ),
  //         ),
  //         Expanded(
  //             flex: flex,
  //             child: Align(
  //               alignment: Alignment.centerRight,
  //               child: Text(
  //                 '${data.cHANGE ?? "--"} (${data.pERCENTCHANGE ?? "--"})',
  //                 style: AppTextStyle.H7Bold.copyWith(
  //                     color: data.color, fontWeight: FontWeight.w700),
  //               ),
  //             )),
  //       ],
  //     ),
  //   ));
  // }
}
