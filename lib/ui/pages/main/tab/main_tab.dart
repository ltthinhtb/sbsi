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
        return S.of(context).stock_market;
      case MainTab.assets:
        return S.of(context).order;
      case MainTab.history:
        return S.of(context).order_note;
      case MainTab.profile:
        return S.of(context).assets;
    }
  }

  String get icon {
    switch (this) {
      case MainTab.home:
        return AppImages.home;
      case MainTab.product:
        return AppImages.market;
      case MainTab.assets:
        return AppImages.molecule;
      case MainTab.history:
        return AppImages.note;
      case MainTab.profile:
        return AppImages.wallet;
    }
  }

  String get iconActive {
    switch (this) {
      case MainTab.home:
        return AppImages.homeActive;
      case MainTab.product:
        return AppImages.marketActive;
      case MainTab.assets:
        return AppImages.moleculeActive;
      case MainTab.history:
        return AppImages.noteActive;
      case MainTab.profile:
        return AppImages.walletActive;
    }
  }

}
