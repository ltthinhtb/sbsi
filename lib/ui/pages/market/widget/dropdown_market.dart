import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_images.dart';
import 'package:sbsi/common/app_text_styles.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/model/stock_company_data/stock_company_data.dart';
import 'package:sbsi/services/index.dart';
import 'package:sbsi/ui/commons/app_dialog.dart';
import 'package:sbsi/ui/pages/market/widget/stock_follow.dart';
import 'package:sbsi/ui/pages/search/search_logic.dart';
import 'package:sbsi/ui/widgets/button/button_filled.dart';
import 'package:sbsi/ui/widgets/dropdown/app_drop_down.dart';
import 'package:sbsi/ui/widgets/textfields/app_text_field.dart';
import 'package:sbsi/utils/validator.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_images.dart';
import '../../../../generated/l10n.dart';
import '../../../../model/entities/category_stock.dart';
import '../../../widgets/textfields/app_text_typehead.dart';
import '../market_logic.dart';

class MarketOption extends StatelessWidget with Validator {
  MarketOption({Key? key}) : super(key: key);

  final logic = Get.find<MarketLogic>();
  final state = Get.find<MarketLogic>().state;
  final searchLogic = Get.put(SearchLogic());
  final searchState = Get.find<SearchLogic>().state;
  final _searchController = TextEditingController();

  final store = Get.find<StoreService>();

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;

    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      flex: 199,
                      child: Obx(() {
                        var categoryDefalut = state.category_default;
                        return AppDropDownWidget<CategoryStock>(
                          value: state.category.value,
                          onChanged: (categoryEntity) {
                            logic.selectCategory(categoryEntity!);
                          },
                          items: [
                            DropdownMenuItem<CategoryStock>(
                                child: Text(categoryDefalut.title),
                                value: categoryDefalut),
                            ...store.listCategoryUser
                                .map((e) => DropdownMenuItem<CategoryStock>(
                                    child: Text(e.title), value: e))
                                .toList()
                          ],
                        );
                      }),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 128,
                      child: GestureDetector(
                        onTap: () async {
                          showDialogAddCategory(context);
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: AppColors.PastelSecond2,
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 16),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(AppImages.add_square),
                              const SizedBox(width: 6),
                              Text(
                                S.of(context).add,
                                style: headline6?.copyWith(
                                    color:
                                        const Color.fromRGBO(251, 122, 4, 1)),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              buildSearchStock(context),
            ],
          ),
        ),
        // Cần điều chỉnh laị giá trị
        const SizedBox(height: 16),
        StockFollowView(),
      ]),
    );
  }

  Widget buildSearchStock(BuildContext context) {
    return Container(
      child: AppTextTypeHead<StockCompanyData>(
        inputController: _searchController,
        suggestionsCallback: (String pattern) {
          return searchLogic.searchStockCompany(pattern);
        },
        hintText: "Thêm mã CK",
        onSuggestionSelected: (suggestion) {
          FocusScope.of(context).unfocus();
          if (suggestion.stockCode != null) {
            logic.addStockDB(suggestion.stockCode!);
            _searchController.clear();
          }
        },
      ),
    );
  }

  Widget rowData(
    BuildContext context,
    String title, {
    VoidCallback? deleteCategory,
    VoidCallback? editCategory,
    required VoidCallback choose,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: choose,
              child: Text(
                title,
                style: AppTextStyle.H6.copyWith(color: AppColors.white),
              ),
            ),
          ),
          GestureDetector(
              onTap: editCategory,
              child: SvgPicture.asset(
                AppImages.pencil_2,
                color: AppColors.grayF4,
              )),
          const SizedBox(width: 30),
          GestureDetector(
              onTap: deleteCategory,
              child: SvgPicture.asset(
                AppImages.trash,
                color: AppColors.grayF4,
              )),
        ],
      ),
    );
  }

  void showDialogAddCategory(BuildContext context) {
    AppDiaLog.showDialog(
      title: S.of(context).add_category,
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              AppTextFieldWidget(
                hintText: S.of(context).add_category,
                hintTextStyle: const TextStyle(color: AppColors.grayB5),
                inputController: state.categoryController,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                      child: ButtonFill(
                    title: S.of(context).close,
                    voidCallback: () {
                      Get.back();
                    },
                  )),
                  const SizedBox(width: 20),
                  Expanded(
                      child: ButtonFill(
                    title: S.of(context).add,
                    voidCallback: () async {
                      logic.addCategory();
                    },
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
