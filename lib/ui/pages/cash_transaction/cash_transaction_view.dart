import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/app_colors.dart';
import '../../../generated/l10n.dart';
import '../../../services/auth_service.dart';
import '../../commons/appbar.dart';
import 'cash_transaction_logic.dart';
import 'enum/transaction.dart';
import 'tabs/transaction_money.dart';
import 'tabs/transaction_stock.dart';

class CashTransactionPage extends StatefulWidget {
  const CashTransactionPage({Key? key}) : super(key: key);

  @override
  _CashTransactionPageState createState() => _CashTransactionPageState();
}

class _CashTransactionPageState extends State<CashTransactionPage> {
  final logic = Get.put(CashTransactionLogic());
  final state = Get.find<CashTransactionLogic>().state;

  @override
  Widget build(BuildContext context) {
    final body1 = Theme.of(context).textTheme.bodyText1;
    return Scaffold(
      appBar: AppBarCustom(
        title: S.of(context).cash_transaction,
        isCenter: true,
        action: [
          GestureDetector(
            onTap: () {
              logic.changeAccount();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              margin: const EdgeInsets.symmetric(vertical: 11),
              decoration: BoxDecoration(
                  color: AppColors.tabIn,
                  borderRadius: BorderRadius.circular(16)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() {
                    var auth = Get.find<AuthService>().token.value;
                    return Text(
                      '${auth?.data?.user ?? ""}',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          ?.copyWith(color: AppColors.buttonOrange),
                    );
                  }),
                  const SizedBox(width: 2),
                  Container(
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: AppColors.white, shape: BoxShape.circle),
                    child: Obx(() {
                      return Text(
                        state.account.value.lastCharacter,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            ?.copyWith(fontWeight: FontWeight.w700),
                      );
                    }),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(width: 14),
        ],
      ),
      backgroundColor: AppColors.whiteBack,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: RefreshIndicator(
          onRefresh: () async {},
          child: DefaultTabController(
            length: Transaction.values.length,
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
                        tabs: Transaction.values
                            .map((e) => Center(child: Text(e.name)))
                            .toList()),
                  ],
                ),
                const Expanded(
                  child: TabBarView(children: [TransactionMoney(), TransactionStock()]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<CashTransactionLogic>();
    super.dispose();
  }
}
