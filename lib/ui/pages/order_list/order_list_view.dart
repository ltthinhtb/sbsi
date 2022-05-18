import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/ui/commons/app_snackbar.dart';
import 'package:sbsi/ui/commons/appbar.dart';
import 'package:sbsi/ui/pages/order_list/order_list_logic.dart';
import 'package:sbsi/ui/pages/order_list/tabs/inday_tabs.dart';
import 'package:sbsi/ui/widgets/dialog/custom_dialog.dart';
import '../../widgets/button/button_filled.dart';
import 'enums/order_enums.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({Key? key}) : super(key: key);

  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage>
    with SingleTickerProviderStateMixin {
  final logic = Get.find<OrderListLogic>();
  final state = Get.find<OrderListLogic>().state;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<OrderListLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final body1 = Theme.of(context).textTheme.bodyText1;
    return Scaffold(
      appBar: AppBarCustom(
          title: S.of(context).order_note,
          isCenter: true,
          automaticallyImplyLeading: false),
      backgroundColor: AppColors.whiteBack,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: RefreshIndicator(
          onRefresh: () async {
            logic.getOrderList();
          },
          child: DefaultTabController(
            length: OderType.values.length,
            child: Column(
              children: [
                Stack(
                  fit: StackFit.passthrough,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom:
                              BorderSide(color: AppColors.grayF2, width: 2.0),
                        ),
                      ),
                    ),
                    TabBar(
                        indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 3)),
                        labelStyle:
                            body1?.copyWith(fontWeight: FontWeight.w700),
                        labelColor: Theme.of(context).primaryColor,
                        unselectedLabelStyle: body1,
                        indicatorPadding: EdgeInsets.zero,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: Theme.of(context).primaryColor,
                        unselectedLabelColor: AppColors.textGrey,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        labelPadding: const EdgeInsets.only(bottom: 8),
                        indicatorWeight: 0,
                        onTap: (value) {},
                        tabs: OderType.values
                            .map((e) => Center(child: Text(e.name)))
                            .toList()),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                      children: [const InDayTab(), Container(), Container()]),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: AnimatedScale(
        scale: 1,
        duration: const Duration(milliseconds: 300),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ButtonFill(
                    voidCallback: () async {
                      bool? _r = await CustomDialog.showConfirmDialog(
                        context,
                        S.of(context).confirm_cancel_order,
                        [
                          S.of(context).are_you_sure_cancel_all_order,
                        ],
                        buttonColors: [AppColors.primary2, AppColors.primary],
                        textButtonColors: [AppColors.primary, AppColors.white],
                      );
                      if (_r ?? false) {
                        try {
                          await logic.cancelOrder();
                        } catch (e) {
                          AppSnackBar.showError(message: e.toString());
                        }
                      }
                    },
                    title: S.of(context).cancel_all_orders,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ButtonFill(
                    voidCallback: () async {
                      bool? _r = await CustomDialog.showConfirmDialog(
                        context,
                        S.of(context).confirm_cancel_order,
                        [
                          S.of(context).are_you_sure_cancel_this_order,
                        ],
                        buttonColors: [AppColors.primary2, AppColors.primary],
                        textButtonColors: [AppColors.primary, AppColors.white],
                      );
                      if (_r ?? false) {
                        try {
                          await logic.cancelOrder();
                        } catch (e) {
                          AppSnackBar.showError(message: e.toString());
                        }
                      }
                    },
                    title: S.of(context).cancel_chose_orders,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
