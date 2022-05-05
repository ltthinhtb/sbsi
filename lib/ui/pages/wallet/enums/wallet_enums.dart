import 'package:flutter/cupertino.dart';
import 'package:sbsi/generated/l10n.dart';

enum WalletEnum { assets, menu,profit }

extension WalletExt on WalletEnum {
  String title(BuildContext context) {
    switch (this) {
      case WalletEnum.assets:
        return S.of(context).assets;
      case WalletEnum.menu:
        return S.of(context).menu;
      case WalletEnum.profit:
        return S.of(context).profit;
    }
  }
}
