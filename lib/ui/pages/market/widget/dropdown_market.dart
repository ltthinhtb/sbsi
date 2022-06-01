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
  final searchLogic = Get.find<SearchLogic>();
  final searchState = Get.find<SearchLogic>().state;
  final _searchController = TextEditingController();

  final store = Get.find<StoreService>();

  final dropdownKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final caption = Theme.of(context).textTheme.caption;

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
                          key: dropdownKey,
                          value: state.category.value,
                          onChanged: (categoryEntity) {
                            logic.selectCategory(categoryEntity!);
                          },
                          selectedItemBuilder: (_) {
                            return [
                              Text(categoryDefalut.title),
                              ...store.listCategoryUser
                                  .map((e) => Text(e.title))
                                  .toList(),
                            ];
                          },
                          items: [
                            DropdownMenuItem<CategoryStock>(
                                child: Text(categoryDefalut.title),
                                value: categoryDefalut),
                            ...store.listCategoryUser
                                .map((e) => DropdownMenuItem<CategoryStock>(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(e.title),
                                        GestureDetector(
                                            onTap: () {
                                              logic.deleteCategory(e.title);
                                              Navigator.pop(
                                                  dropdownKey.currentContext!);
                                            },
                                            child: SvgPicture.asset(
                                                AppImages.close))
                                      ],
                                    ),
                                    value: e))
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
                          height: 40,
                          decoration: BoxDecoration(
                              color: AppColors.PastelSecond2,
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(AppImages.add_square),
                              const SizedBox(width: 6),
                              Text(
                                S.of(context).add_category,
                                style: caption?.copyWith(
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

            ],
          ),
        ),
        const SizedBox(height: 16),
        // Cần điều chỉnh laị giá trị
        Container(
          decoration: const BoxDecoration(color: AppColors.white),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: buildSearchStock(context),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                        flex: 93,
                        child: Text(S.of(context).stock_code,
                            style: caption?.copyWith(
                                fontWeight: FontWeight.w700))),
                    Expanded(
                        flex: 93,
                        child: Center(
                          child: Text(
                            S.of(context).price,
                            style: caption?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        )),
                    Expanded(
                        flex: 93,
                        child: Center(
                          child: Text(
                            '+/-',
                            style: caption?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        )),
                    Expanded(
                        flex: 100,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            S.of(context).total_amount_1,
                            style: caption?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 13),
              StockFollowView(),
            ],
          ),
        )
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
                hintText: S.of(context).add_category_title,
                hintTextStyle: const TextStyle(color: AppColors.grayB5),
                inputController: state.categoryController,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                      child: ButtonFill(
                    title: S.of(context).cancel_short,
                    style: ElevatedButton.styleFrom(
                        onPrimary: AppColors.primary,
                        primary: const Color.fromRGBO(255, 238, 238, 1)),
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
