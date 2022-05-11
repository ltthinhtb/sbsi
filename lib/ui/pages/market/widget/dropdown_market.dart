import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_images.dart';
import 'package:sbsi/common/app_text_styles.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/model/stock_company_data/stock_company_data.dart';
import 'package:sbsi/ui/commons/app_bottom_sheet.dart';
import 'package:sbsi/ui/commons/app_dialog.dart';
import 'package:sbsi/ui/commons/app_loading.dart';
import 'package:sbsi/ui/pages/home/home_logic.dart';
import 'package:sbsi/ui/pages/market/widget/stock_follow.dart';
import 'package:sbsi/ui/pages/search/search_logic.dart';
import 'package:sbsi/ui/widgets/button/button_filled.dart';
import 'package:sbsi/ui/widgets/textfields/app_text_field.dart';
import 'package:sbsi/utils/validator.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_images.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/textfields/app_text_typehead.dart';

class MarketOption extends StatelessWidget with Validator {
  MarketOption({Key? key}) : super(key: key);

  final logic = Get.find<HomeLogic>();
  final state = Get.find<HomeLogic>().state;
  final searchLogic = Get.put(SearchLogic());
  final searchState = Get.find<SearchLogic>().state;
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
    return Container(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Obx(() {
                      return AppTextFieldWidget(
                        hintTextStyle:
                            AppTextStyle.H6.copyWith(color: AppColors.grayB5),
                        readOnly: true,
                        onTap: () => showBottomSheetDialogEdit(context),
                        hintText: state.category.value.label.value,
                      );
                    }),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () async {
                      showDialogAddCategory(context);
                    },
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                          color: AppColors.yellow.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(AppImages.add_square),
                          const SizedBox(width: 5),
                          Text(
                            S.of(context).add,
                            style: headline6!.copyWith(color: AppColors.yellow),
                          )
                        ],
                      ),
                    ),
                  )
                ],
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
                style:
                    AppTextStyle.H6.copyWith(color: AppColors.white),
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
    var editController = TextEditingController();
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
                inputController: editController,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                      child: ButtonFill(
                    title: S.of(context).close, voidCallback: () {  },
                  )),
                  const SizedBox(width: 20),
                  Expanded(
                      child: ButtonFill(
                    title: S.of(context).add,
                    voidCallback: () async {
                      AppLoading.showLoading();
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

  void showBottomSheetDialogEdit(BuildContext context) {
    AppBottomSheet.show(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            S.of(context).menu,
            style: AppTextStyle.H5Bold.copyWith(color: AppColors.white),
          ),
          const SizedBox(
            height: 26,
          ),
          Flexible(
            child: Obx(() {
              return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, int index) {
                    return Obx(() {
                      return rowData(
                          context, state.listCategory[index].label.value,
                          deleteCategory: () {
                        logic.deleteCategory(state.listCategory[index].title);
                      }, choose: () async {
                        AppLoading.showLoading();
                        await logic.selectCategory(state.listCategory[index]);
                        AppLoading.disMissLoading();
                        Get.back();
                      }, editCategory: () {
                        final editController = TextEditingController(
                            text: state.listCategory[index].title);
                        AppDiaLog.showDialog(
                          title: S.of(context).edit_category,
                          content: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32),
                              child: Column(
                                children: [
                                  AppTextFieldWidget(
                                    hintText: S.of(context).edit_category,
                                    hintTextStyle:
                                        const TextStyle(color: AppColors.grayB5),
                                    inputController: editController,
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
                                        title: S.of(context).edit,
                                        voidCallback: () {
                                          logic.editCategory(
                                              state.listCategory[index].title,
                                              editController.text);
                                          editController.clear();
                                          Navigator.pop(context);
                                        },
                                      ))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                    });
                  },
                  itemCount: state.listCategory.length);
            }),
          )
        ],
      ),
    );
  }
}
