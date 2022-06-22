import 'package:flutter/material.dart';
import 'package:sbsi/common/app_colors.dart';

import '../../../../generated/l10n.dart';
import 'stock_exchanges .dart';
import 'top_foreign_trade.dart';

class WorldTabs extends StatefulWidget {
  const WorldTabs({Key? key}) : super(key: key);

  @override
  State<WorldTabs> createState() => _WorldTabsState();
}

class _WorldTabsState extends State<WorldTabs>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final caption = Theme.of(context).textTheme.caption;
    return SingleChildScrollView(
        child: Column(
      children: [
        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: StockExchangesView(),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: const BoxDecoration(color: AppColors.white),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      flex: 50,
                      child: Text(
                        S.of(context).stock_code,
                        style: caption?.copyWith(
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Expanded(
                      flex: 93,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          S.of(context).amount_2,
                          style: caption?.copyWith(
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 93,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          S.of(context).price,
                          style: caption?.copyWith(
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 90,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          S.of(context).increase_decrease,
                          style: caption?.copyWith(
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const TopForeignTrade()

            ],
          ),
        ),
      ],
    ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
