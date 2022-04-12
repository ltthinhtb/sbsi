import 'package:flutter/cupertino.dart';
import 'package:sbsi/generated/l10n.dart';

enum WalletEnum { assets, profit, menu, permission }

extension WalletExt on WalletEnum {
  String title(BuildContext context) {
    switch (this) {
      case WalletEnum.assets:
        return S.of(context).assets;
      case WalletEnum.profit:
        return S.of(context).profit;
      case WalletEnum.menu:
        return S.of(context).menu;
      case WalletEnum.permission:
        return S.of(context).permission_to_buy;
    }
  }
}
