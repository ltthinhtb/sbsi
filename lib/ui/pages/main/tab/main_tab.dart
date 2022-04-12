import 'package:flutter/cupertino.dart';
import 'package:sbsi/common/app_images.dart';
import 'package:sbsi/generated/l10n.dart';

enum MainTab {
  home,
  product,
  assets,
  history,
  profile,
}

extension MainTabExtension on MainTab {
  String label(BuildContext context) {
    switch (this) {
      case MainTab.home:
        return S.of(context).home;
      case MainTab.product:
        return S.of(context).wallet;
      case MainTab.assets:
        return S.of(context).order;
      case MainTab.history:
        return S.of(context).order_note;
      case MainTab.profile:
        return S.of(context).category;
    }
  }

  String get iconPurple {
    switch (this) {
      case MainTab.home:
        return AppImages.status_up_1;
      case MainTab.product:
        return AppImages.wallet_1;
      case MainTab.assets:
        return AppImages.judge_1;
      case MainTab.history:
        return AppImages.document_text_1;
      case MainTab.profile:
        return AppImages.category_1;
    }
  }

  String get iconGrey {
    switch (this) {
      case MainTab.home:
        return AppImages.status_up_0;
      case MainTab.product:
        return AppImages.wallet_0;
      case MainTab.assets:
        return AppImages.judge_0;
      case MainTab.history:
        return AppImages.document_text_0;
      case MainTab.profile:
        return AppImages.category_0;
    }
  }
}
