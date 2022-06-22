import 'package:flutter/cupertino.dart';

import '../../../generated/l10n.dart';

enum StockFast { waiting, matching }

extension StockFastExt on StockFast {
  String name(BuildContext context) {
    switch (this) {
      case StockFast.waiting:
        return S.of(context).waiting;
      case StockFast.matching:
        return S.of(context).matched;
    }
  }

  String get value {
    switch (this) {
      case StockFast.waiting:
        return ",1,ALL";
      case StockFast.matching:
        return ',2,ALL';
    }
  }
}
