import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sbsi/common/app_dimens.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:get/get.dart';
import 'package:sbsi/ui/commons/appbar.dart';
import 'package:sbsi/ui/pages/menu/panel/setting/language/language.dart';

import '../../../../../../common/app_images.dart';
import '../../../../../../utils/validator.dart';


class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> with Validator {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: S.of(context).settings,
        isCenter: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(AppDimens.paddingNormal),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            rowButton1(
                button: AppImages.internet,
                title: S.of(context).language,
                onTap: () {
                  Get.to(const LanguagePage());
                }),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }



  Widget rowButton1(
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
