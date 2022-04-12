import 'package:flutter/material.dart';
import 'package:sbsi/common/app_dimens.dart';
import 'package:sbsi/common/app_text_styles.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/services/index.dart';
import 'package:get/get.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final settingService = Get.find<SettingService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Container(
          child: Text(
            S.of(context).settings_language,
            style: AppTextStyle.H3,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(AppDimens.paddingNormal),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // _buildThemeSection(),
            _buildLanguageSection(),
          ],
        ),
      ),
    );
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

  Widget _buildLanguageSection() {
    final theme = Theme.of(context);
    // print("Language: ===> ${settingService.currentLocate.value}");
    return Obx(() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).settings_language,
            style: theme.textTheme.headline6,
          ),
          RadioListTile(
            title: Text(S.of(context).settings_languageEnglish),
            value: const Locale.fromSubtags(languageCode: 'en'),
            groupValue: settingService.currentLocate.value,
            onChanged: (Locale? value) {
              if (value != null) {
                settingService.updateLocale(value);
              }
            },
          ),
          RadioListTile(
            title: Text(S.of(context).settings_languageVietnamese),
            value: const Locale.fromSubtags(languageCode: 'vi'),
            groupValue: settingService.currentLocate.value,
            onChanged: (Locale? value) {
              if (value != null) {
                settingService.updateLocale(value);
              }
            },
          ),
        ],
      );
    });
  }
}
