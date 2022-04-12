import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_text_styles.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/router/route_config.dart';
import 'package:sbsi/ui/pages/menu/menu_logic.dart';
import 'package:sbsi/ui/pages/menu/panel/cust_info/cust_info_view.dart';
import 'package:sbsi/ui/pages/menu/panel/setting/setting.dart';
import 'package:sbsi/ui/pages/user/user_logic.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final logic = Get.put(MenuLogic());
  final state = Get.find<MenuLogic>().state;

  final userLogic = Get.put(UserLogic());

  @override
  void dispose() {
    Get.delete<MenuLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Container(
          child: Text(
            "Menu",
            style: AppTextStyle.H3,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [buildInfoRow(), buildListButton()],
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow() {
    return Obx(
      () => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            GetPageRoute(
              page: () => const CustomInfo(),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: const BoxDecoration(
            color: AppColors.grayF2,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Row(
            children: [
              const CircleAvatar(
                maxRadius: 27,
                backgroundColor: AppColors.primary,
              ),
              Container(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.name.value,
                    style:
                        AppTextStyle.H5Bold.copyWith(color: AppColors.primary),
                  ),
                  Text(
                    state.acc.value,
                    style:
                        AppTextStyle.H5Bold.copyWith(color: AppColors.primary),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListButton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          buildButton("Smart OTP"),
          buildButton(S.of(context).stockMarket),
          buildButton(S.of(context).money_exchange),
          buildButton(S.of(context).warning),
          buildButton(S.of(context).margin_product),
          buildButton(S.of(context).order_confirm),
          buildButton(S.of(context).user_guide),
          buildButton(S.of(context).statement),
          buildButton(
            S.of(context).settings_title,
            onPush: () => Get.to(const Setting()),
          ),
          buildButton(
            S.of(context).logout,
            onPush: () => Get.offNamed(RouteConfig.login),
          ),
        ],
      ),
    );
  }

  Widget buildButton(String label, {Function()? onPush}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: MaterialButton(
        onPressed: onPush ?? () {},
        color: AppColors.grayF2,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(
                label,
                style: AppTextStyle.H5Bold,
              ),
            ),
            const Icon(
              Icons.east_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
