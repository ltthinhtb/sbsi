import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sbsi/common/app_dimens.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/services/index.dart';
import 'package:get/get.dart';
import 'package:sbsi/ui/commons/appbar.dart';

import '../../../../../../common/app_colors.dart';
import '../../../../../../common/app_images.dart';
import '../../../../../../utils/validator.dart';
import '../../../../../widgets/button/button_filled.dart';
import '../../../../../widgets/textfields/app_text_field.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> with Validator {
  final settingService = Get.find<SettingService>();
  final keyPass = GlobalKey<FormState>();

  final passController = TextEditingController();

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
            rowButton(
                button: AppImages.faceID_setting,
                title: S.of(context).registration,
                onTap: () {})
          ],
        ),
      ),
    );
  }

  ValueNotifier<bool> isBiometrics =
      ValueNotifier<bool>(Get.find<AuthService>().isBiometricsSave);

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
            ValueListenableBuilder<bool>(
              builder: (BuildContext context, _isBiometrics, Widget? child) {
                return CupertinoSwitch(
                    value: _isBiometrics,
                    onChanged: (value) {
                      passController.clear();
                      changeBiometrics(value);
                    });
              },
              valueListenable: isBiometrics,
            )
          ],
        ),
      ),
    );
  }

  void changeBiometrics(bool _isBiometrics) {
    Get.dialog(Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: Builder(builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Text(
                S.of(context).registration,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),
              Form(
                key: keyPass,
                child: AppTextFieldWidget(
                  validator: (pin) {
                    var currentPass =
                        Get.find<AuthService>().token.value?.data?.pass ?? "";
                    return checkConfirmPass(pin!, currentPass);
                  },
                  hintText: S.of(context).password,
                  inputController: passController,
                  obscureText: true,
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                      child: ButtonFill(
                    voidCallback: () {
                      Get.back();
                    },
                    title: S.of(context).cancel_short,
                    style: ElevatedButton.styleFrom(
                        onPrimary: AppColors.primary,
                        primary: const Color.fromRGBO(255, 238, 238, 1)),
                  )),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: ButtonFill(
                          voidCallback: () async {
                            if (!keyPass.currentState!.validate()) return;
                            isBiometrics.value = _isBiometrics;
                            await Get.find<AuthService>()
                                .changeIsBiometricsSave(isBiometrics.value);
                            //close dialog
                            Get.back();
                          },
                          title: S.of(context).confirm))
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      }),
    ));
  }

// Widget _buildThemeSection() {
//   final theme = Theme.of(context);
//   return Obx(() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           S.of(context).settings_themeMode,
//           style: theme.textTheme.headline6,
//         ),
//         RadioListTile(
//           title: Text(S.of(context).settings_themeModeSystem),
//           value: ThemeMode.system,
//           groupValue: settingService.currentThemeMode.value,
//           onChanged: (ThemeMode? value) {
//             if (value != null) {
//               settingService.changeThemeMode(value);
//             }
//           },
//         ),
//         RadioListTile(
//           title: Text(S.of(context).settings_themeModeLight),
//           value: ThemeMode.light,
//           groupValue: settingService.currentThemeMode.value,
//           onChanged: (ThemeMode? value) {
//             if (value != null) {
//               settingService.changeThemeMode(value);
//             }
//           },
//         ),
//         RadioListTile(
//           title: Text(S.of(context).settings_themeModeDark),
//           value: ThemeMode.dark,
//           groupValue: settingService.currentThemeMode.value,
//           onChanged: (ThemeMode? value) {
//             if (value != null) {
//               settingService.changeThemeMode(value);
//             }
//           },
//         ),
//       ],
//     );
//   });
// }

// Widget _buildLanguageSection() {
//   final theme = Theme.of(context);
//   // print("Language: ===> ${settingService.currentLocate.value}");
//   return Obx(() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           S.of(context).settings_language,
//           style: theme.textTheme.headline6,
//         ),
//         RadioListTile(
//           title: Text(S.of(context).settings_languageEnglish),
//           value: const Locale.fromSubtags(languageCode: 'en'),
//           groupValue: settingService.currentLocate.value,
//           onChanged: (Locale? value) {
//             if (value != null) {
//               settingService.updateLocale(value);
//             }
//           },
//         ),
//         RadioListTile(
//           title: Text(S.of(context).settings_languageVietnamese),
//           value: const Locale.fromSubtags(languageCode: 'vi'),
//           groupValue: settingService.currentLocate.value,
//           onChanged: (Locale? value) {
//             if (value != null) {
//               settingService.updateLocale(value);
//             }
//           },
//         ),
//       ],
//     );
//   });
// }
}
