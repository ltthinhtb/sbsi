import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_images.dart';
import 'package:sbsi/common/app_text_styles.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/model/stock_company_data/stock_company_data.dart';
import 'package:sbsi/services/setting_service.dart';
import 'package:sbsi/ui/commons/app_snackbar.dart';
import 'package:sbsi/ui/commons/webview.dart';
import 'package:sbsi/ui/pages/stock_order/stock_order_logic.dart';
import 'package:sbsi/ui/pages/stock_order/stock_order_state.dart';
import 'package:sbsi/ui/pages/stock_order/widget/number_input.dart';
import 'package:sbsi/ui/pages/stock_order/widget/stock_order_appbar.dart';
import 'package:sbsi/ui/pages/stock_order/widget/stock_order_confirm.dart';
import 'package:sbsi/ui/widgets/animation_widget/price_row.dart';
import 'package:sbsi/ui/widgets/animation_widget/switch.dart';
import 'package:sbsi/ui/widgets/animation_widget/total_volumn_row.dart';
import 'package:sbsi/utils/extension.dart';
import 'package:sbsi/utils/order_utils.dart';
import 'package:sbsi/utils/stock_utils.dart';

// ignore: must_be_immutable
class StockOrderPage extends StatefulWidget {
  StockOrderPage({Key? key, this.selectedStock, this.isBuy = true})
      : super(key: key);
  bool isBuy;
  StockCompanyData? selectedStock;

  @override
  _StockOrderPageState createState() => _StockOrderPageState();
}

class _StockOrderPageState extends State<StockOrderPage> {
  final logic = Get.put(StockOrderLogic());
  final state = Get.find<StockOrderLogic>().state;

  //Bỏ settingService đi
  final settingService = Get.find<SettingService>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      state.isBuy.value = widget.isBuy;
      state.priceController.text = state.price.toString();
      state.volController.text = state.vol.toString();
    });
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    //   StockCompanyData _data = state.allStockCompanyData
    //       .firstWhere((element) => element.stockCode == "AAA");
    //   changeStock(_data);
    // });
  }

  @override
  void didUpdateWidget(covariant StockOrderPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if ((widget.selectedStock != null &&
            widget.selectedStock != oldWidget.selectedStock) ||
        (widget.isBuy != oldWidget.isBuy)) {
      changeStock(widget.selectedStock);
      state.isBuy.value = widget.isBuy;
    }
  }

  @override
  void dispose() {
    Get.delete<StockOrderLogic>();
    super.dispose();
  }

  void changeStock(StockCompanyData? data) async {
    if (data != null) {
      await logic.getStockInfo(data);
    }
  }

  void unfocus() {
    return FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: StockOrderAppbar(
        onLeadingPress: () {},
        onSelectStockCode: (data) => changeStock(data),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: RefreshIndicator(
          onRefresh: () async {
            await logic.refreshPage();
          },
          child: ListView(
            children: [
              buildTopItem(),
              buildHeader(),
              build3Gia(),
              buildVolPercent(),
              buildBSButton(),
              buildPriceTypes(),
              buildPriceInput(),
              buildInfoColumn(),
            ],
          ),
        ),
      ),
      floatingActionButton: MaterialButton(
        minWidth: width - 30,
        height: 50,
        color: AppColors.primary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        onPressed: () async {
          try {
            await logic.validateInfo();
            bool? result = await Get.to(const StockOrderConfirm());
            print(result);
            if (result ?? false) {
              await logic.requestNewOrder();
            }
          } catch (e) {
            print(e);
            switch (e) {
              case 0:
                return AppSnackBar.showError(
                    message: S.of(context).empty_stockcode);
              case -1:
                return AppSnackBar.showError(
                    message: S.of(context).invalid_price);
              case -2:
                return AppSnackBar.showError(
                    message: S.of(context).invalid_volumn);
              case -3:
                return AppSnackBar.showError(
                    message: S.of(context).vol_is_not_positive);
              case -4:
                return AppSnackBar.showError(
                    message: S.of(context).vol_is_not_integer);
              default:
                return AppSnackBar.showError(message: e.toString());
            }
          }
        },
        child: Text(
          "Đặt lệnh",
          style: AppTextStyle.H5Bold.copyWith(color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildTopItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
        child: Obx(
          () => state.selectedStock.value.stockCode != null
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: state.selectedStock.value.stockCode! + "  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            TextSpan(
                              text: state.selectedStock.value.postTo!,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ]),
                        ),
                        MaterialButton(
                          onPressed: () {
                            Get.to(
                              WebViewPage(
                                  title: "Chart",
                                  url:
                                      "https://info.sbsi.vn/chart/?symbol=${state.selectedStock.value.stockCode}&language=vi&theme=light"),
                            );
                          },
                          shape: const CircleBorder(),
                          color: Theme.of(context)
                              .buttonTheme
                              .colorScheme!
                              .primaryContainer,
                          child: SvgPicture.asset(AppImages.switch_diagram),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RichText(
                            maxLines: 1,
                            text: TextSpan(children: [
                              TextSpan(
                                text: settingService.currentLocate.value ==
                                        const Locale.fromSubtags(
                                            languageCode: 'vi')
                                    ? state.selectedStock.value.nameVn
                                    : state.selectedStock.value.nameEn ??
                                        state.selectedStock.value.nameVn,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w200,
                                    ),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              : Column(
                  children: const [
                    Text('Chưa có cổ phiếu nào được chọn'),
                    Text('Vui lòng chọn cổ phiếu muốn đặt lệnh')
                  ],
                ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: state.selectedStockInfo.value.lastPrice != null
              ? AppColors.primary2
              : AppColors.primaryOpacity,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Text(
                state.selectedStockInfo.value.lastPrice != null
                    ? state.selectedStockInfo.value.lastPrice.toString()
                    : "0.0",
                style: AppTextStyle.H1.copyWith(
                  color: state.selectedStockInfo.value.lastPrice != null
                      ? StockUtil.itemColorWithColor(
                          state.selectedStockInfo.value.cl!)
                      : null,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.selectedStockInfo.value.ot != null
                        ? state.selectedStockInfo.value.ot!
                        : "0.0",
                    style: AppTextStyle.bodyText1.copyWith(
                      color: state.selectedStockInfo.value.ot != null
                          ? StockUtil.itemColorWithColor(
                              state.selectedStockInfo.value.cl!)
                          : null,
                    ),
                  ),
                  Text(
                    state.selectedStockInfo.value.ot != null
                        ? logic.getChangePc()
                        : "0.0%",
                    style: AppTextStyle.bodyText1.copyWith(
                      color: state.selectedStockInfo.value.ot != null
                          ? StockUtil.itemColorWithColor(
                              state.selectedStockInfo.value.cl!)
                          : null,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    S.of(context).volumn,
                    style: AppTextStyle.caption2,
                  ),
                  Text(
                    state.selectedStockInfo.value.lot != null
                        ? StockUtil.formatVol10(
                            state.selectedStockInfo.value.lot!)
                        : "0",
                    style: AppTextStyle.bodyText2,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RichText(
                    maxLines: 1,
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      text: S.of(context).ceil,
                      style:
                          AppTextStyle.caption2.copyWith(color: Colors.black),
                    ),
                  ),
                  RichText(
                    maxLines: 1,
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      text: state.selectedStockInfo.value.c != null
                          ? state.selectedStockInfo.value.c!.toString()
                          : "0",
                      style:
                          AppTextStyle.bodyText2.copyWith(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RichText(
                    maxLines: 1,
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      text: S.of(context).reference_short,
                      style:
                          AppTextStyle.caption2.copyWith(color: Colors.black),
                    ),
                  ),
                  RichText(
                    maxLines: 1,
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      text: state.selectedStockInfo.value.r != null
                          ? state.selectedStockInfo.value.r!.toString()
                          : "0",
                      style:
                          AppTextStyle.bodyText2.copyWith(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RichText(
                    maxLines: 1,
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      text: S.of(context).floor,
                      style:
                          AppTextStyle.caption2.copyWith(color: Colors.black),
                    ),
                  ),
                  RichText(
                    maxLines: 1,
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      text: state.selectedStockInfo.value.f != null
                          ? state.selectedStockInfo.value.f!.toString()
                          : "0",
                      style:
                          AppTextStyle.bodyText2.copyWith(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget build3Gia() {
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  PricePercentRow(
                    sum: state.sumBuyVol.value,
                    price: state.selectedStockInfo.value.g1?.price ?? "0.0",
                    value:
                        state.selectedStockInfo.value.g1?.volumn?.toDouble() ??
                            0,
                  ),
                  PricePercentRow(
                    sum: state.sumBuyVol.value,
                    price: state.selectedStockInfo.value.g2?.price ?? "0.0",
                    value:
                        state.selectedStockInfo.value.g2?.volumn?.toDouble() ??
                            0,
                  ),
                  PricePercentRow(
                    sum: state.sumBuyVol.value,
                    price: state.selectedStockInfo.value.g3?.price ?? "0.0",
                    value:
                        state.selectedStockInfo.value.g3?.volumn?.toDouble() ??
                            0,
                  )
                ],
              ),
            ),
            Container(
              width: 5,
            ),
            Expanded(
              child: Column(
                children: [
                  PricePercentRow(
                    isBuy: false,
                    sum: state.sumSellVol.value,
                    price: state.selectedStockInfo.value.g4?.price ?? "0.0",
                    value:
                        state.selectedStockInfo.value.g4?.volumn?.toDouble() ??
                            0,
                  ),
                  PricePercentRow(
                    isBuy: false,
                    sum: state.sumSellVol.value,
                    price: state.selectedStockInfo.value.g5?.price ?? "0.0",
                    value:
                        state.selectedStockInfo.value.g5?.volumn?.toDouble() ??
                            0,
                  ),
                  PricePercentRow(
                    isBuy: false,
                    sum: state.sumSellVol.value,
                    price: state.selectedStockInfo.value.g6?.price ?? "0.0",
                    value:
                        state.selectedStockInfo.value.g6?.volumn?.toDouble() ??
                            0,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildVolPercent() {
    return Obx(
      () => Container(
        // margin: const EdgeInsets.only(bottom: 5),
        child: TotalVolumnPercentRow(
          sum: state.sumBSVol.value,
          buyValue: state.sumBuyVol.value,
          sellValue: state.sumSellVol.value,
        ),
      ),
    );
  }

  Widget buildBSButton() {
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: AnimatedSwitch(
          trueLabel: S.of(context).buy,
          falseLabel: S.of(context).sell,
          value: state.isBuy.value,
          trueColor: AppColors.green,
          falseColor: AppColors.red,
          padding: 15,
          onChange: (val) {
            state.isBuy.value = val;
            if (val) {
              logic.getCashBalance();
            } else {
              logic.getShareBalance();
            }
          },
        ),
      ),
    );
  }

  Widget buildPriceTypes() {
    return Obx(() {
      if (state.loading.value) {
        return Container(
          child: Row(
            children: nullString.asMap().entries.map<Widget>((entry) {
              int idx = entry.key;
              return buidButtonPrice(nullString, idx);
            }).toList(),
          ),
        );
      } else {
        switch (state.stockExchange.value) {
          case StockExchange.HSX:
            return Container(
              child: Row(
                children: pricesHSX.asMap().entries.map<Widget>((entry) {
                  int idx = entry.key;
                  return buidButtonPrice(pricesHSX, idx);
                }).toList(),
              ),
            );
          case StockExchange.HNX:
            return Container(
              child: Row(
                children: pricesHNX.asMap().entries.map<Widget>((entry) {
                  int idx = entry.key;
                  return buidButtonPrice(pricesHNX, idx);
                }).toList(),
              ),
            );
          default:
            return Container(
              child: Row(
                children: pricesUPCOM.asMap().entries.map<Widget>((entry) {
                  int idx = entry.key;
                  return buidButtonPrice(pricesUPCOM, idx);
                }).toList(),
              ),
            );
        }
      }
    });
  }

  Widget buidButtonPrice(List<String> prices, int index) {
    return Obx(
      () => Expanded(
        child: Padding(
          padding: EdgeInsets.only(
            left: index == 0 ? 0 : 5,
            right: index == (prices.length - 1) ? 0 : 5,
          ),
          child: MaterialButton(
            onPressed: () {
              unfocus();
              state.priceType.value = prices[index];
              if (state.selectedStock.value.stockCode != null) {
                if (prices[index] == PriceType.LO) {
                  state.priceController.text =
                      state.selectedStockInfo.value.lastPrice!.toString();
                } else {
                  state.priceController.text = prices[index];
                }
                // state.price.value =
                //     state.selectedStockInfo.value.lastPrice!.toString();
                // state.priceController.text = prices[index];
                // state.priceController.text = state.price.value.toString();
              }
              if (state.selectedStock.value.stockCode != null) {
                logic.getCashBalance();
              }
            },
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: state.priceType.value == prices[index]
                ? AppColors.primary
                : AppColors.primary2,
            splashColor: state.priceType.value == prices[index]
                ? AppColors.primary2.withOpacity(0.5)
                : AppColors.background.withOpacity(0.5),
            child: Text(
              prices[index],
              style: AppTextStyle.H5Bold.copyWith(
                color: state.priceType.value == prices[index]
                    ? Colors.white
                    : AppColors.background,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPriceInput() {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(S.of(context).price),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    child: NumberInputField(
                      label: S.of(context).price,
                      editingController: state.priceController,
                      // dist: 0.1,
                      enabled: state.selectedStock.value.stockCode != null
                          ? true
                          : false,
                      onSubtractPress: () {
                        if (state.priceController.text.isMP) {
                          state
                            ..priceType.value = PriceType.LO
                            ..priceController.text = StockUtil.formatPrice(
                                (state.selectedStockInfo.value.lastPrice ?? 0) -
                                    0.1);
                        } else {
                          if (state.priceController.text.isANumber) {
                            state.priceController.text = StockUtil.formatPrice(
                              double.tryParse(state.priceController.text
                                      .replaceAll(",", ""))! -
                                  0.1,
                            );
                          }
                        }
                      },
                      onAddPress: () {
                        if (state.priceController.text == "MP") {
                          state
                            ..priceType.value = PriceType.LO
                            ..priceController.text = StockUtil.formatPrice(
                                (state.selectedStockInfo.value.lastPrice ?? 0) +
                                    0.1);
                        } else {
                          if (state.priceController.text.isANumber) {
                            state.priceController.text = StockUtil.formatPrice(
                              double.tryParse(state.priceController.text
                                      .replaceAll(",", ""))! +
                                  0.1,
                            );
                          }
                        }
                      },
                      onChange: () {
                        if (state.priceController.text.isATO) {
                          state.priceType.value = PriceType.ATO;
                        } else if (state.priceController.text.isATC) {
                          state.priceType.value = PriceType.ATC;
                        } else if (state.priceController.text.isMP) {
                          state.priceType.value = PriceType.MP;
                        }
                      },
                      onFocus: () {
                        if (state.priceController.text.isIn(pricesHSX) ||
                            state.priceController.text.isIn(pricesHNX)) {
                          state.priceController.clear();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(S.of(context).volumn),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    child: NumberInputField(
                      label: S.of(context).volumn,
                      editingController: state.volController,
                      // dist: 100,
                      enabled: state.selectedStock.value.stockCode != null
                          ? true
                          : false,
                      onSubtractPress: () {
                        if (state.volController.text.isAnInteger) {
                          state.volController.text = StockUtil.formatVol(
                            double.tryParse(state.volController.text
                                    .replaceAll(",", ""))! -
                                100,
                          );
                        }
                      },
                      onAddPress: () {
                        if (state.volController.text.isAnInteger) {
                          state.volController.text = StockUtil.formatVol(
                            double.tryParse(state.volController.text
                                    .replaceAll(",", ""))! +
                                100,
                          );
                        }
                      },
                      // onEditingComplete: () {
                      //   if (state.volController.text.isAnInteger) {
                      //     state.volController.text = StockUtil.formatVol(
                      //       double.tryParse(state.volController.text
                      //               .replaceAll(",", "")) ??
                      //           0,
                      //     );
                      //   }
                      // },
                      onUnfocus: () {
                        print(state.volController.text.isAnInteger);
                        if (state.volController.text.isAnInteger) {
                          state.volController.text = StockUtil.formatVol(
                            double.tryParse(state.volController.text
                                    .replaceAll(",", "")) ??
                                0,
                          );
                        }
                      },
                      // onChange: () {
                      //   if (state.volController.text.isANumber) {
                      //     state.volController.text = StockUtil.formatVol(
                      //       double.tryParse(state.volController.text
                      //               .replaceAll(",", ""))! +
                      //           100,
                      //     );
                      //   }
                      // },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInput(String label, TextEditingController controller, double dist,
      bool enabled) {
    return NumberInputField(
      label: label,
      editingController: controller,
      // dist: dist,
      enabled: enabled,
    );
  }

  Widget buildInfoColumn() {
    return Obx(() {
      if (state.loading.value) {
        return Container();
      } else {
        if (state.isBuy.value) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: const EdgeInsets.only(bottom: 60),
            decoration: BoxDecoration(
              color: state.selectedStockInfo.value.lastPrice != null
                  ? AppColors.primary2
                  : AppColors.primaryOpacity,
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        S.of(context).mr,
                        style: AppTextStyle.caption2,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        state.accountStatus.value.mr != null
                            ? StockUtil.formatMoney(double.tryParse(
                                    state.accountStatus.value.mr ?? "0") ??
                                0)
                            : "0",
                        style: AppTextStyle.bodyText2,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        S.of(context).ee,
                        style: AppTextStyle.caption2,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        state.selectedCashBalance.value.ee != null
                            ? StockUtil.formatMoney(double.tryParse(
                                    state.selectedCashBalance.value.ee ??
                                        "0") ??
                                0)
                            : "0",
                        style: AppTextStyle.bodyText2,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        S.of(context).pp,
                        style: AppTextStyle.caption2,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        state.selectedCashBalance.value.pp != null
                            ? StockUtil.formatMoney(double.tryParse(
                                    state.selectedCashBalance.value.pp ??
                                        "0") ??
                                0)
                            : "0",
                        style: AppTextStyle.bodyText2,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        S.of(context).volumn,
                        style: AppTextStyle.caption2,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        state.selectedCashBalance.value.volumeAvaiable != null
                            ? StockUtil.formatVol(
                                double.parse(state.selectedCashBalance.value
                                            .volumeAvaiable ==
                                        null
                                    ? "0"
                                    : state.selectedCashBalance.value
                                            .volumeAvaiable!.isEmpty
                                        ? "0"
                                        : state.selectedCashBalance.value
                                            .volumeAvaiable!),
                              )
                            : "0",
                        style: AppTextStyle.bodyText2,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: const EdgeInsets.only(bottom: 60),
            decoration: BoxDecoration(
              color: state.selectedStockInfo.value.lastPrice != null
                  ? AppColors.primary2
                  : AppColors.primaryOpacity,
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    S.of(context).volumn,
                    style: AppTextStyle.caption2,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    state.selectedShareBalance.value.shareBalance != null
                        ? StockUtil.formatVol(
                            state.selectedShareBalance.value.shareBalance ?? 0,
                          )
                        : "0",
                    style: AppTextStyle.bodyText2,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          );
        }
      }
    });
  }
}

List<String> pricesHSX = [
  PriceType.LO,
  PriceType.MP,
  PriceType.ATC,
  PriceType.ATO,
];
List<String> pricesHNX = [
  PriceType.LO,
  PriceType.MTL,
  PriceType.MAK,
  PriceType.MOK,
  PriceType.PLO,
];

List<String> pricesUPCOM = [
  PriceType.LO,
];
List<String> nullString = [""];
