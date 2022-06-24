import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/model/stock_data/stock_data.dart';
import 'package:sbsi/model/stock_data/stock_info.dart';
import 'package:sbsi/ui/commons/webview.dart';
import 'package:sbsi/utils/money_utils.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_images.dart';
import '../../../../generated/l10n.dart';
import '../../../../model/stock_company_data/stock_company_data.dart';

class CardDetail extends StatelessWidget {
  final StockCompanyData stock;
  final StockInfo stockInfo;
  final StockData stockData;

  const CardDetail(
      {Key? key,
      required this.stock,
      required this.stockInfo,
      required this.stockData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    final caption = Theme.of(context).textTheme.caption;
    final headline4 = Theme.of(context).textTheme.headline4;
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                      style: bodyText1?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "${stock.nameVn ?? ""}",
                      style: caption?.copyWith(color: AppColors.textSecond),
                    ),
                  ],
                )),
                GestureDetector(
                    onTap: () {
                      Get.to(WebViewPage(
                              title: "Trading",
                              url:
                                  'https://info.sbsi.vn/chart/?symbol=${stock.stockCode}&language=vi&theme=light'))!
                          .then((value) {
                        SystemChrome.setPreferredOrientations([
                          DeviceOrientation.portraitDown,
                          DeviceOrientation.portraitUp,
                        ]);
                      });
                    },
                    child: SvgPicture.asset(AppImages.chart))
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 18),
              Text(
                '${stockInfo.lastPrice ?? ""}',
                style: headline4?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: stockInfo.color,
                    fontSize: 40),
              ),
              const SizedBox(width: 13),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stockData.changePercent,
                    style: caption?.copyWith(
                        fontWeight: FontWeight.w700, color: stockInfo.color),
                  ),
                  Text(
                    stockData.ot ?? "",
                    style: caption?.copyWith(
                        fontWeight: FontWeight.w700, color: stockInfo.color),
                  ),
                ],
              ),
              const Spacer(),
              Column(
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
              ),
              const SizedBox(width: 24),
              Column(
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
                        fontWeight: FontWeight.w700, color: AppColors.yellow),
                  ),
                ],
              ),
              const SizedBox(width: 24),
              Column(
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
                        fontWeight: FontWeight.w700, color: AppColors.floor),
                  ),
                ],
              ),
              const SizedBox(width: 10)
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).aver_short,
                      style: caption?.copyWith(color: AppColors.textGrey4),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${('${stockInfo.avePrice ?? ""}')}',
                      style: caption?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).long_short,
                      style: caption?.copyWith(color: AppColors.textGrey4),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${stockInfo.lowPrice ?? ""} - ${stockInfo.highPrice ?? ""}',
                      style: caption?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).total_amount,
                      style: caption?.copyWith(color: AppColors.textGrey4),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      MoneyFormat.formatVol10('${stockInfo.lot}'),
                      style: caption?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
