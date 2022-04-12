import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_images.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/ui/commons/app_bottom_sheet.dart';
import 'package:sbsi/ui/commons/app_dialog.dart';
import 'package:sbsi/ui/widgets/button/button_filled.dart';
import 'package:sbsi/ui/widgets/textfields/app_text_field.dart';
import 'package:sbsi/utils/validator.dart';
import '../home_logic.dart';

class MarketOption extends StatelessWidget with Validator {
  const MarketOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<HomeLogic>();
    final state = Get
        .find<HomeLogic>()
        .state;
    final headline6 = Theme
        .of(context)
        .textTheme
        .headline6;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                AppBottomSheet.show(
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        S
                            .of(context)
                            .menu,
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline3,
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      rowData(context, 'HSX30', choose: () {
                        logic.selectCategory(state.category_default);
                      }),
                      Flexible(
                        child: Obx(() {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (context, int index) {
                                return Obx(() {
                                  return rowData(
                                      context, state.listCategory[index].label.value,
                                      deleteCategory: () {
                                        logic.deleteCategory(
                                            state.listCategory[index].title);
                                      }, choose: () {
                                    logic.selectCategory(
                                        state.listCategory[index]);
                                  }, editCategory: () {
                                    final editController = TextEditingController(
                                        text: state.listCategory[index].title);
                                    AppDiaLog.showDialog(
                                      title: S
                                          .of(context)
                                          .edit_category,
                                      content: SizedBox(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 32),
                                          child: Column(
                                            children: [
                                              AppTextFieldWidget(
                                                hintText:
                                                S
                                                    .of(context)
                                                    .edit_category,
                                                inputController: editController,
                                              ),
                                              const SizedBox(height: 20),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: ButtonFill(
                                                        title: S
                                                            .of(context)
                                                            .close,
                                                        voidCallback: () {
                                                          Get.back();
                                                        },
                                                      )),
                                                  const SizedBox(width: 20),
                                                  Expanded(
                                                      child: ButtonFill(
                                                        title: S
                                                            .of(context)
                                                            .edit,
                                                        voidCallback: () {
                                                          logic.editCategory(
                                                              state
                                                                  .listCategory[index]
                                                                  .title,
                                                              editController
                                                                  .text);
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
              },
              child: Container(
                height: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: AppColors.grayF2,
                    borderRadius: BorderRadius.circular(15)),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      return Text(
                        state.category.value.title,
                        style: headline6!.copyWith(fontWeight: FontWeight.w700),
                      );
                    }),
                    SvgPicture.asset(AppImages.chevron_down)
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              AppDiaLog.showDialog(
                title: S
                    .of(context)
                    .add_category,
                content: SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      children: [
                        AppTextFieldWidget(
                          hintText: S
                              .of(context)
                              .add_category,
                          inputController: state.categoryController,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                                child: ButtonFill(
                                  title: S
                                      .of(context)
                                      .close,
                                  voidCallback: () {
                                    Get.back();
                                  },
                                )),
                            const SizedBox(width: 20),
                            Expanded(
                                child: ButtonFill(
                                  title: S
                                      .of(context)
                                      .add,
                                  voidCallback: () {
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
            },
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .primaryColor,
                  borderRadius: BorderRadius.circular(15)),
              padding: const EdgeInsets.symmetric(horizontal: 8.5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(AppImages.add_square),
                  const SizedBox(width: 5),
                  Text(
                    S
                        .of(context)
                        .code,
                    style: headline6!.copyWith(color: AppColors.white),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget rowData(BuildContext context,
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
                style: Theme
                    .of(context)
                    .textTheme
                    .headline5,
              ),
            ),
          ),
          GestureDetector(
              onTap: editCategory, child: SvgPicture.asset(AppImages.pencil_2)),
          const SizedBox(width: 30),
          GestureDetector(
              onTap: deleteCategory, child: SvgPicture.asset(AppImages.trash)),
        ],
      ),
    );
  }
}
