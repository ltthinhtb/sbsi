import 'package:flutter/material.dart';
import 'package:sbsi/generated/l10n.dart';

enum StockTab { interested, increase, decrease, trade }

extension StockTabExtension on StockTab {
  String label(BuildContext context) {
    switch (this) {
      case StockTab.interested:
        return S.of(context).popular;
      case StockTab.increase:
        return S.of(context).increase;
      case StockTab.decrease:
        return S.of(context).decrease;
      case StockTab.trade:
        return S.of(context).volumn;
    }
  }
}
