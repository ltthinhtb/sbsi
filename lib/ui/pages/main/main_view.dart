import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_shadows.dart';

import 'main_logic.dart';
import 'tab/main_tab.dart';

class MainPage extends GetView<MainLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageView(),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildPageView() {
    // return
    return Obx(() {
      return IndexedStack(
        index: controller.state.selectedIndex.value,
        children: controller.state.pageList,
      );
    });
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          boxShadow: AppShadow.boxShadow,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20)
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: AppShadow.boxShadow,
              color: AppColors.red
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColors.white,
              elevation: 10,
              currentIndex: controller.state.selectedIndex.value,
              items: List<BottomNavigationBarItem>.generate(MainTab.values.length,
                  (int index) {
                return BottomNavigationBarItem(
                  activeIcon: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: SvgPicture.asset(
                        MainTab.values[index].iconActive,
                      )),
                  icon: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: SvgPicture.asset(
                        MainTab.values[index].icon,
                      )),
                  label: MainTab.values[index].label(context),
                );
              }),
              onTap: (index) {
                controller.switchTap(index);
              },
            ),
          ),
        ),
      );
    });
  }

// @override
// void dispose() {
//   Get.delete<MainLogic>();
//   super.dispose();
// }
}
