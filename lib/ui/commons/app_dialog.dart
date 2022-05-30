import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_text_styles.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/ui/widgets/button/button_filled.dart';

import 'app_loading.dart';

class AppDiaLog {
  static void showDialog({String? title, String? middleText, Widget? content}) {
    Get.defaultDialog(
      radius: 15,
      title: title ?? "",
      middleText: middleText ?? "",
      titleStyle: AppTextStyle.H4Bold,
      middleTextStyle: AppTextStyle.H6.copyWith(color: AppColors.black),
      content: content,
      contentPadding: EdgeInsets.zero,
    );
  }

  static Future<void> showNoticeDialog(
      {String? title, String? middleText, VoidCallback? onConfirm}) async {
    AppLoading.disMissLoading();
    await Get.defaultDialog(
        title: title ?? "Thông báo",
        middleText: middleText ?? " ",
        titleStyle: AppTextStyle.H3.copyWith(fontSize: 18),
        middleTextStyle: AppTextStyle.bodyText1,
        barrierDismissible: false,
        confirm: ButtonFill(
          title: "OK",
          style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 5)),
          voidCallback: onConfirm ??
              () {
                Get.back();
              },
        ));
  }

  static Future<void> showConfirmDialog(
      {String? title, String? middleText, VoidCallback? onConfirm}) async {
    AppLoading.disMissLoading();
    await Get.defaultDialog(
        title: title ?? S.current.notice,
        middleText: middleText ?? " ",
        titleStyle: AppTextStyle.H3.copyWith(fontSize: 18),
        middleTextStyle: AppTextStyle.bodyText1,
        barrierDismissible: false,
        textConfirm: "Xác nhận",
        textCancel: "Hủy",
        buttonColor: AppColors.primary,
        cancelTextColor: AppColors.primary,
        confirmTextColor: AppColors.white,
        onConfirm: onConfirm);
  }
}
