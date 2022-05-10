import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_text_styles.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/ui/pages/home/home_logic.dart';
import 'package:sbsi/utils/money_utils.dart';

class StockFollowView extends StatelessWidget {
  StockFollowView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<HomeLogic>().state;
    final logic = Get.find<HomeLogic>();
    final headline6 = Theme.of(context).textTheme.headline6;
    int flex = 4;
    return Container(
      // child: Column(
      //   children: [
      //     // Container(
      //     //     margin: EdgeInsets.only(left: 16),
      //     //     child: Text(S.of(context).top_foreign_trade,
      //     //         style: AppTextStyle.H5Bold.copyWith(color: Colors.white)),
      //     //     width: MediaQuery.of(context).size.width),
      //     // Container(
      //     //     height: 1,
      //     //     margin: EdgeInsets.only(left: 16, right: 16, top: 8),
      //     //     color: AppColors.lineBlue),
      //     Container(
      //       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      //       decoration: const BoxDecoration(
      //           borderRadius: BorderRadius.only(
      //               topRight: Radius.circular(10),
      //               topLeft: Radius.circular(10))),
      //       child: Row(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Expanded(
      //             flex: flex,
      //             child: Text(
      //               S.of(context).stock_code,
      //               style: headline6,
      //             ),
      //           ),
      //           Expanded(
      //             flex: flex,
      //             child: Align(
      //               alignment: Alignment.centerLeft,
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.center,
      //                 children: [
      //                   Text(
      //                     S.of(context).value_money,
      //                     style: headline6,
      //                   )
      //                 ],
      //               ),
      //             ),
      //           ),
      //           Expanded(
      //             flex: flex,
      //             child: Align(
      //                 alignment: Alignment.center,
      //                 child: Text(
      //                   S.of(context).percent_gain_loss,
      //                   style: headline6,
      //                 )),
      //           ),
      //           Expanded(
      //             flex: flex,
      //             child: Align(
      //               alignment: Alignment.centerRight,
      //               child: Text(
      //                 S.of(context).sum_vol,
      //                 style: headline6,
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //     Obx(() {
      //       if (state.listStock.isNotEmpty) {
      //         return ListView.builder(
      //             shrinkWrap: true,
      //             physics: NeverScrollableScrollPhysics(),
      //             itemBuilder: (context, index) {
      //               return Slidable(
      //                 closeOnScroll: true,
      //                 endActionPane: ActionPane(
      //                   motion: ScrollMotion(),
      //                   extentRatio: 0.25,
      //                   dragDismissible: true,
      //                   children: [
      //                     SlidableAction(
      //                       onPressed: (context){
      //                         if (state.listStock[index].sym != null) {
      //                           logic.removeStockDB(
      //                               state.listStock[index].sym!);
      //                         }
      //                       },
      //                       backgroundColor: AppColors.red,
      //                       foregroundColor: Colors.white,
      //                       label: S.of(context).delete,
      //                     )
      //                   ],
      //                 ),
      //                 child: GestureDetector(
      //                     child: Container(
      //                       padding: EdgeInsets.symmetric(
      //                           horizontal: 16, vertical: 15),
      //                       color: index % 2 == 0
      //                           ? AppColors.backgroundTopStock
      //                           : Colors.transparent,
      //                       child: Row(
      //                         children: [
      //                           Expanded(
      //                               flex: flex,
      //                               child: Text(
      //                                   state.listStock[index].sym ?? "--",
      //                                   style: AppTextStyle.H7Bold.copyWith(
      //                                       color: Colors.white))),
      //                           Expanded(
      //                               flex: flex,
      //                               child: Container(
      //                                 decoration: BoxDecoration(
      //                                     color: state.listStock[index]
      //                                                     .mapColorChange[
      //                                                 'lastPrice'] ==
      //                                             true
      //                                         ? state.listStock[index].color!
      //                                             .withOpacity(0.4)
      //                                         : null),
      //                                 child: Text(
      //                                   '${state.listStock[index].lastPrice?.toStringAsFixed(2) ?? "--"}',
      //                                   style: AppTextStyle.H7Bold.copyWith(
      //                                       fontWeight: FontWeight.w700,
      //                                       color: state.listStock[index].color!
      //                                           .withOpacity(1)),
      //                                 ),
      //                               )),
      //                           Expanded(
      //                               flex: flex,
      //                               child: Align(
      //                                 alignment: Alignment.center,
      //                                 child: Text(
      //                                   '${state.listStock[index].ot ?? "--"}',
      //                                   style: AppTextStyle.H7Bold.copyWith(
      //                                       fontWeight: FontWeight.w700,
      //                                       color:
      //                                           state.listStock[index].color),
      //                                 ),
      //                               )),
      //                           Expanded(
      //                               flex: flex,
      //                               child: Container(
      //                                 decoration: BoxDecoration(
      //                                     color: state.listStock[index]
      //                                                     .mapColorChange[
      //                                                 'lastVolume'] ==
      //                                             true
      //                                         ? state.listStock[index].color!
      //                                             .withOpacity(0.4)
      //                                         : null),
      //                                 child: Align(
      //                                   alignment: Alignment.centerRight,
      //                                   child: Text(
      //                                     MoneyFormat.formatVolumn10(
      //                                         '${state.listStock[index].lot?.toInt() ?? "0"}'),
      //                                     style: AppTextStyle.H7Bold.copyWith(
      //                                         fontWeight: FontWeight.w700,
      //                                         color:
      //                                             state.listStock[index].color),
      //                                   ),
      //                                 ),
      //                               )),
      //                         ],
      //                       ),
      //                     ),
      //                     onTap: () {
      //                       Navigator.push(
      //                         context,
      //                         MaterialPageRoute(
      //                             builder: (context) => StockDetailPage(
      //                                 stockCode:
      //                                     state.listStock[index].sym ?? "--")),
      //                       );
      //                     }),
      //               );
      //             },
      //             itemCount: state.listStock.length);
      //       } else {
      //         return SingleChildScrollView(
      //           child: Column(
      //             children: [
      //               Text(S.of(context).not_found,
      //                   style: AppTextStyle.H6Bold.copyWith(
      //                       color: AppColors.white))
      //             ],
      //           ),
      //         );
      //       }
      //     })
      //   ],
      // ),
    );
  }
}
