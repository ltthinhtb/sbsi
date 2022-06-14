import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../configs/app_configs.dart';

extension ThemeModeExtension on ThemeMode {
  String get code {
    switch (this) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      default:
        return 'system';
    }
  }

  static ThemeMode fromCode(String code) {
    switch (code) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}

class SettingService extends GetxService {
  // Theme
  final Rx<ThemeMode> currentThemeMode = ThemeMode.system.obs;

  // Language
  final Rx<Locale> currentLocate = window.locale.obs;

  late SharedPreferences prefs;

  late Rx<Flavor> flavor = Flavor.TEST.obs;

  Future<SettingService> init() async {
    prefs = await SharedPreferences.getInstance();

    ///Flavor
    String flavorString = prefs.getString("flavor") ?? Flavor.TEST.name;
    flavor.value = Flavor.values.firstWhere((element) => element.name == flavorString,
        orElse: () {
      return Flavor.TEST;
    });

    ///ThemeMode
    String themeModeCode =
        prefs.getString("themeModeCode") ?? ThemeMode.light.code;
    final themeMode = ThemeModeExtension.fromCode(themeModeCode);
    currentThemeMode.value = themeMode;
    Get.changeThemeMode(themeMode);

    ///Language
    String languageCode = prefs.getString("languageCode") ?? 'vi';
    var locale = S.delegate.supportedLocales.firstWhere(
      (element) => element.languageCode == languageCode,
      orElse: () => const Locale.fromSubtags(languageCode: "en"),
    );
    currentLocate.value = locale;
    await Get.updateLocale(locale);

    return this;
  }

  void changeFlavor(Flavor _flavor) async {
    await prefs.setString('flavor', _flavor.name);
    flavor.value = _flavor;
  }

  void changeThemeMode(ThemeMode themeMode) async {
    await prefs.setString('themeModeCode', themeMode.code);
    currentThemeMode.value = themeMode;
    Get.changeThemeMode(themeMode);
  }

  void updateLocale(Locale locale) async {
    var newLocale = S.delegate.supportedLocales.firstWhere(
      (element) => element.languageCode == locale.languageCode,
      orElse: () => const Locale.fromSubtags(languageCode: "en"),
    );
    await prefs.setString('languageCode', newLocale.languageCode);
    currentLocate.value = newLocale;
    await Get.updateLocale(newLocale);
  }
}
