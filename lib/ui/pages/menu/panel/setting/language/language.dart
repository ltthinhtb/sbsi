import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/app_dimens.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../services/index.dart';
import '../../../../../commons/appbar.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  State<LanguagePage> createState() => _LanguageState();
}

class _LanguageState extends State<LanguagePage> {
  final settingService = Get.find<SettingService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: S.of(context).language,
        isCenter: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(AppDimens.paddingNormal),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[_buildLanguageSection()],
        ),
      ),
    );
  }

  Widget _buildLanguageSection() {
    final theme = Theme.of(context);
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
