import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_images.dart';
import 'package:sbsi/ui/pages/stock_order/stock_order_logic.dart';
import 'package:sbsi/utils/money_utils.dart';
import '../../../../generated/l10n.dart';
import '../../../../model/stock_company_data/stock_company_data.dart';
import '../../../../model/stock_data/stock_info.dart';
import '../../../widgets/textfields/app_text_typehead.dart';

class CardData extends StatelessWidget {
  final StockCompanyData stock;
  final StockInfo stockInfo;

  const CardData({Key? key, required this.stock, required this.stockInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    final caption = Theme.of(context).textTheme.caption;
    final headline4 = Theme.of(context).textTheme.headline4;
    final state = Get.find<StockOrderLogic>().state;
    final logic = Get.find<StockOrderLogic>();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            const BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), blurRadius: 4),
            const BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), blurRadius: 20)
          ]),
      child: Column(
        children: [
          Obx(() {
            return Visibility(
              visible: state.isSearch,
              child: Padding(
                padding: const EdgeInsets.only(left: 6, right: 6, bottom: 16),
                child: AppTextTypeHead<StockCompanyData>(
                  key: state.searchCKKey,
                  hintText: S.of(context).stock_code,
                  inputController: state.stockController,
                  focusNode: state.stockNode,
                  suggestionsCallback: (String pattern) {
                    return logic.searchStock(pattern);
                  },
                  onSuggestionSelected: (suggestion) {
                    return logic.selectStock(suggestion);
                  },
                ),
              ),
            );
          }),
          Obx(() {
            return Visibility(
              visible: !state.isSearch,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.grayF2.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          stock.stockCode != null
                              ? "${stock.stockCode ?? ""} ( ${stock.postTo ?? ""} )"
                              : "",
                          style:
                              bodyText1?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "${stock.nameVn ?? ""}",
                          style: caption?.copyWith(color: AppColors.textSecond),
                        ),
                      ],
                    )),
                    GestureDetector(
                      onTap: (){
                        logic.cleanStock();
                      },
                        child: SvgPicture.asset(AppImages.close))
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 18),
              Expanded(
                  flex: 82,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${stockInfo.lastPrice ?? ""}',
                        style: headline4?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: stockInfo.color),
                      ),
                      const SizedBox(height: 1),
                      Row(
                        children: [
                          Text(
                            '',
                            style: caption?.copyWith(color: stockInfo.color),
                          ),
                        ],
                      ),
                    ],
                  )),
              Expanded(
                  flex: 57,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).volume_short,
                        style: caption?.copyWith(color: AppColors.textSecond),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        '${MoneyFormat.formatVol10('${stockInfo.lot ?? ""}')}',
                        style: caption?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  )),
              Expanded(
                  flex: 25,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).ceil,
                        style: caption?.copyWith(color: AppColors.textSecond),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        '${('${stockInfo.c ?? ""}')}',
                        style: caption?.copyWith(
                            fontWeight: FontWeight.w700, color: AppColors.ceil),
                      ),
                    ],
                  )),
              Expanded(
                  flex: 25,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).reference_short,
                        style: caption?.copyWith(color: AppColors.textSecond),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        '${('${stockInfo.r ?? ""}')}',
                        style: caption?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.yellow),
                      ),
                    ],
                  )),
              Expanded(
                  flex: 25,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).floor,
                        style: caption?.copyWith(color: AppColors.textSecond),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        '${('${stockInfo.f ?? ""}')}',
                        style: caption?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.floor),
                      ),
                    ],
                  )),
            ],
          )
        ],
      ),
    );
  }
}
