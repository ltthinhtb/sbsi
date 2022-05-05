import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/ui/pages/menu/menu_logic.dart';

import '../../../services/auth_service.dart';
import '../../commons/appbar.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final logic = Get.put(MenuLogic());
  final state = Get.find<MenuLogic>().state;


  @override
  void dispose() {
    Get.delete<MenuLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: S.of(context).wallet,
        isCenter: true,
        action: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            margin: const EdgeInsets.symmetric(vertical: 11),
            decoration: BoxDecoration(
                color: AppColors.tabIn,
                borderRadius: BorderRadius.circular(16)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() {
                  var auth = Get.find<AuthService>().token.value;
                  return Text('${auth?.data?.user ?? ""}');
                }),
                const SizedBox(width: 2),
                Container(
                  width: 24,
                  height: 24,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: AppColors.white, shape: BoxShape.circle),
                  child: Obx(() {
                    return Text(
                      state.account.value.lastCharacter,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          ?.copyWith(fontWeight: FontWeight.w700),
                    );
                  }),
                )
              ],
            ),
          ),
          const SizedBox(width: 14),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SingleChildScrollView(

        ),
      ),
    );
  }


}
