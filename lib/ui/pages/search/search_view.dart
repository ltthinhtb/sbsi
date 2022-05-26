import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_images.dart';
import 'package:sbsi/model/stock_company_data/stock_company_data.dart';
import 'package:sbsi/services/setting_service.dart';
import 'package:sbsi/ui/commons/appbar.dart';
import 'package:sbsi/ui/pages/search/search_logic.dart';
import 'package:sbsi/ui/pages/stock_detail/stock_detail_view.dart';
import 'package:sbsi/ui/widgets/textfields/app_text_field.dart';

import '../../../generated/l10n.dart';
import '../../../router/route_config.dart';

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

  @override
  void dispose() {
    Get.delete<SearchLogic>();
    super.dispose();
  }

  ValueNotifier<bool> isShowClose = ValueNotifier<bool>(false);

  @override
  void initState() {
    state.stockCodeController.addListener(() {
      if (state.stockCodeController.text.isNotEmpty) {
        isShowClose.value = true;
      } else {
        isShowClose.value = false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(
        title: "Tìm kiếm mã",
        isCenter: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AppTextFieldWidget(
              inputController: state.stockCodeController,
              fillColor: AppColors.white,
              filled: true,
              hintText: "Nhập mã CK",
              onChanged: (stockCode) {
                logic.searchStock(stockCode);
              },
              prefixIcon: SvgPicture.asset(
                AppImages.search_normal,
                color: AppColors.gray7E,
              ),
              suffixIcon: ValueListenableBuilder<bool>(
                builder: (BuildContext context, isShow, Widget? child) {
                  return Visibility(
                    visible: isShow,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () {
                          state.stockCodeController.clear();
                        },
                        child: SvgPicture.asset(
                          AppImages.close,
                        ),
                      ),
                    ),
                  );
                },
                valueListenable: isShowClose,
              ),
              focusBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                      color: AppColors.textFieldEnabledBorder, width: 1)),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Obx(
              () => ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: state.foundStock.length,
                itemBuilder: (context, index) =>
                    buildItem(state.foundStock[index]),
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 10);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(StockCompanyData data) {
    bool _isLike = false;
    return GestureDetector(
      onTap: (){
        Get.toNamed(RouteConfig.stockDetail,
            arguments: data.stockCode);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                    .bodyText2!
                                    .copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                              TextSpan(
                                text: data.postTo!,
                                style:
                                    Theme.of(context).textTheme.caption!.copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                              )
                            ]),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                        child: (settingService.currentLocate.value ==
                                const Locale.fromSubtags(languageCode: 'vi'))
                            ? Text(
                                data.nameVn!,
                                style: Theme.of(context).textTheme.caption,
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
}
