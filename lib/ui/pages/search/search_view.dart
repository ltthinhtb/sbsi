import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_images.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/model/stock_company_data/stock_company_data.dart';
import 'package:sbsi/services/setting_service.dart';
import 'package:sbsi/ui/pages/market/market_logic.dart';
import 'package:sbsi/ui/pages/search/search_logic.dart';
import 'package:sbsi/ui/widgets/textfields/app_text_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final logic = Get.put(SearchLogic());
  final state = Get.find<SearchLogic>().state;

  // bỏ setting service đi
  final settingService = Get.find<SettingService>();

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    Get.delete<SearchLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _customAppbar(),
      body: Obx(
        () => ListView.builder(
          itemCount: state.foundStock.length,
          itemBuilder: (context, index) => buildItem(state.foundStock[index]),
        ),
      ),
    );
  }

  Widget buildItem(StockCompanyData data) {
    bool _isLike = false;
    return MaterialButton(
      onPressed: () => Get.back(result: data, canPop: false),
      shape: const RoundedRectangleBorder(),
      animationDuration: const Duration(microseconds: 100),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: RichText(
                        text: TextSpan(
                            style: const TextStyle(wordSpacing: 5, height: 1.5),
                            children: <TextSpan>[
                              TextSpan(
                                text: data.stockCode! + " ",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                              TextSpan(
                                text: data.postTo!,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                              )
                            ]),
                      ),
                    ),
                    Container(
                        child: (settingService.currentLocate.value ==
                                const Locale.fromSubtags(languageCode: 'vi'))
                            ? Text(
                                data.nameVn!,
                                style: Theme.of(context).textTheme.headline6,
                              )
                            : Text(data.nameEn ?? data.nameVn!)),
                  ],
                )),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                // tạo thêm 1 common icon button nhé
                child: MaterialButton(
                  onPressed: () {
                    _isLike = !_isLike;
                    Get.find<MarketLogic>().addStockDB(data.stockCode!);
                  },
                  animationDuration: const Duration(microseconds: 100),
                  elevation: 0,
                  highlightElevation: 0,
                  color: Theme.of(context).buttonTheme.colorScheme!.primary,
                  shape: const CircleBorder(),
                  child: SvgPicture.asset(AppImages.dislike_star),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // chuyển thành common widget nhé
  PreferredSizeWidget _customAppbar() {
    return AppBar(
      elevation: 0,
      titleSpacing: 15,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Expanded(
              child: Material(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
              side: BorderSide.none,
            ),
            color: Theme.of(context).buttonTheme.colorScheme!.primary,
            child: RawMaterialButton(
              onPressed: () => Get.back(),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
                side: BorderSide.none,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 25,
              ),
            ),
          )),
          Expanded(
            flex: 5,
            child: AppTextFieldWidget(
              autoFocus: true,
              hintText: S.of(context).search,
              inputController: _textEditingController,
              onChanged: (value) => logic.searchStock(value),
              prefixIcon: SvgPicture.asset(AppImages.search_normal),
            ),
          ),
        ],
      ),
    );
  }
}
