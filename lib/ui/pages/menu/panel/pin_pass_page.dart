import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/ui/commons/appbar.dart';
import 'package:sbsi/ui/pages/menu/panel/setting/change_password_page/change_password_view.dart';

import '../../../../common/app_images.dart';
import '../../../../generated/l10n.dart';
import 'setting/change_pin_page/change_pin_view.dart';

class PinPassPage extends StatefulWidget {
  const PinPassPage({Key? key}) : super(key: key);

  @override
  State<PinPassPage> createState() => _PinPassPageState();
}

class _PinPassPageState extends State<PinPassPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: S.of(context).pin_pass,
        isCenter: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            rowButton(
                onTap: () {
                  Get.to(const ChangePasswordPage());
                },
                title: S.of(context).change_password,
                button: AppImages.key_icon),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                thickness: 1,
                height: 32,
              ),
            ),
            rowButton(
                onTap: () {
                  Get.to(const ChangePinPage());
                },
                title: S.of(context).change_pin,
                button: AppImages.lock),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                thickness: 1,
                height: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rowButton(
      {required String button,
      required String title,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 20),
        child: Row(
          children: [
            SvgPicture.asset(button),
            const SizedBox(width: 16),
            Expanded(
                child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(fontWeight: FontWeight.w700),
            )),
            SvgPicture.asset(AppImages.vector)
          ],
        ),
      ),
    );
  }
}
