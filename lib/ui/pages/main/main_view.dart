import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'main_logic.dart';
import 'tab/main_tab.dart';

final GlobalKey<NavigatorState> mainKey = GlobalKey();

class MainPage extends GetView<MainLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: mainKey,
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
      return ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.state.selectedIndex.value,
          items: List<BottomNavigationBarItem>.generate(MainTab.values.length,
              (int index) {
            return BottomNavigationBarItem(
              activeIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SvgPicture.asset(
                    MainTab.values[index].iconPurple,
                  )),
              icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SvgPicture.asset(
                    MainTab.values[index].iconGrey,
                  )),
              label: MainTab.values[index].label(context),
            );
          }),
          onTap: (index) {
            controller.switchTap(index);
          },
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
