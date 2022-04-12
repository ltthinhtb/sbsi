import 'package:flutter/material.dart';
import 'package:sbsi/generated/l10n.dart';

enum StockEnum { popular, increase, decrease, weight }

extension StockExt on StockEnum {
  String title(BuildContext context) {
    switch (this) {
      case StockEnum.popular:
        return S.of(context).popular;
      case StockEnum.increase:
        return S.of(context).increase;
      case StockEnum.decrease:
        return S.of(context).decrease;
      case StockEnum.weight:
        return S.of(context).volumn;
    }
  }
}
