import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/model/stock_company_data/stock_company_data.dart';
import 'package:sbsi/services/auth_service.dart';
import 'package:sbsi/services/setting_service.dart';
import 'package:sbsi/ui/commons/appbar.dart';
import 'package:sbsi/ui/pages/stock_order/enums.dart';
import 'package:sbsi/ui/pages/stock_order/stock_order_logic.dart';

import 'widget/card_data.dart';
import 'widget/note.dart';
import 'widget/radio_button.dart';
import 'widget/stock_3_price.dart';
import 'widget/stock_cash_balance.dart';

// ignore: must_be_immutable
class StockOrderPage extends StatefulWidget {
  const StockOrderPage({Key? key}) : super(key: key);

  @override
  _StockOrderPageState createState() => _StockOrderPageState();
}

class _StockOrderPageState extends State<StockOrderPage> {
  final logic = Get.find<StockOrderLogic>();
  final state = Get.find<StockOrderLogic>().state;

  //Bỏ settingService đi
  final settingService = Get.find<SettingService>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchStockNodeListen();
  }

  /// lắng nghe textfield search mã chứng khoán
  void searchStockNodeListen() {
    state.stockNode.addListener(() {
      /// check xem có đang hiện bàn phím không
      if (state.stockNode.hasFocus) {
        /// scroll đến chõ mã search mã chứng khoán
        Scrollable.ensureVisible(state.searchCKKey.currentContext!);
      } else {
        /// kiểm tra ở trạng thái cuối trên bàn phím
        var index = state.allStockCompanyData.indexWhere((stock) =>
            stock.stockCode?.trim().toLowerCase() ==
            state.stockController.text.trim().toLowerCase());

        /// nếu mã đó hợp lệ thì load lại trang
        if (index >= 0) logic.selectStock(state.allStockCompanyData[index]);
      }
    });
  }

  /// customUI bàn phím nhập giá
  KeyboardActionsConfig buildConfig() {
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
        keyboardBarColor: AppColors.black,
        actions: [
          KeyboardActionsItem(
            focusNode: state.priceNode,
            displayActionBar: false,
            footerBuilder: (_) => PreferredSize(
              preferredSize: const Size.fromHeight(40),
              child: Obx(() {
                return Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  color: AppColors.blackKeyBoard1,
                  // margin: EdgeInsets.symmetric(vertical: 12),
                  child: Wrap(
                    runSpacing: 0,
                    spacing: 5,
                    children: List<Widget>.generate(
                        state.tradingOrderList.length, (index) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              state.tradingOrder.value =
                                  state.tradingOrderList[index];

                              /// phiên LO (Phiên LO là phiên nhập giá)
                              if (state.tradingOrder.value == "LO") {
                                state.priceController.text = state
                                        .selectedStockInfo.value.lastPrice
                                        ?.toStringAsFixed(2) ??
                                    "";
                              }

                              /// khác phiên LO
                              else {
                                state.priceController.text =
                                    state.tradingOrder.value;
                              }

                              /// update lại sức mua
                              logic.getCashBalance();
                              logic.changeTotal();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: state.tradingOrder ==
                                          state.tradingOrderList[index]
                                      ? AppColors.primary
                                      : AppColors.blackKeyBoard),
                              alignment: Alignment.center,
                              child: Text(
                                state.tradingOrderList[index],
                                style: TextStyle(
                                    color: state.tradingOrder == index
                                        ? AppColors.textBlack
                                        : AppColors.whiteBoard1),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                );
              }),
            ),
          ),
        ]);
  }

  @override
  void dispose() {
    Get.delete<StockOrderLogic>();
    super.dispose();
  }

  void changeStock(StockCompanyData? data) async {
    if (data != null) {
      state.selectedStock.value = data;
      await logic.getStockInfo();
    }
  }

  void unFocus() {
    return FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final body1 = Theme.of(context).textTheme.bodyText1;
    final caption = Theme.of(context).textTheme.caption;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarCustom(
        title: S.of(context).order,
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
      body: RefreshIndicator(
        onRefresh: () async {
          await logic.refreshPage();
        },
        child: KeyboardActions(
          config: buildConfig(),
          child: ListView(
            controller: state.scrollController,
            children: [
              const SizedBox(height: 16),
              Obx(() {
                var stock = state.selectedStock.value;
                var stockInfo = state.selectedStockInfo.value;
                return CardData(stock: stock, stockInfo: stockInfo);
              }),
              const SizedBox(height: 16),
              const Stock3Price(),
              const SizedBox(height: 16),
              const StockCashBalance(),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      S.of(context).order_note,
                      style: body1?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const Spacer(),
                    const RadioButton(stockFast: StockFast.waiting),
                    const SizedBox(
                      width: 24,
                    ),
                    const RadioButton(stockFast: StockFast.matching),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration:
                    const BoxDecoration(color: AppColors.white, boxShadow: [
                  BoxShadow(
                      offset: Offset(0, -1),
                      blurRadius: 10,
                      color: Color.fromRGBO(0, 0, 0, 0.03)),
                  BoxShadow(
                      offset: Offset(0, -0.5),
                      blurRadius: 8,
                      color: Color.fromRGBO(0, 0, 0, 0.04))
                ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 73,
                          child: Text(S.of(context).command,
                              style: caption?.copyWith(
                                  fontWeight: FontWeight.w700)),
                        ),
                        Expanded(
                          flex: 80,
                          child: Text(S.of(context).stock_code,
                              style: caption?.copyWith(
                                  fontWeight: FontWeight.w700)),
                        ),
                        Expanded(
                          flex: 61,
                          child: Text(S.of(context).price,
                              style: caption?.copyWith(
                                  fontWeight: FontWeight.w700)),
                        ),
                        Expanded(
                          flex: 61,
                          child: Text(S.of(context).volume_short,
                              style: caption?.copyWith(
                                  fontWeight: FontWeight.w700)),
                        ),
                        Expanded(
                          flex: 57,
                          child: Text(S.of(context).status,
                              style: caption?.copyWith(
                                  fontWeight: FontWeight.w700)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Obx(() {
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final note = state.listOrder[index];
                          return NoteWidgetOrder(
                            index: index,
                            note: note,
                          );
                        },
                        itemCount: state.listOrder.length,
                      );
                    })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
