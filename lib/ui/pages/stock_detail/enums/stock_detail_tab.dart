import 'package:flutter/cupertino.dart';

import '../../../../generated/l10n.dart';

enum StockTab { over_view, news, analytics, finance }

extension StockExt on StockTab {
  String name(BuildContext context){
    switch(this){
      case StockTab.over_view:
        return S.of(context).over_view;
      case StockTab.news:
        return S.of(context).news;
      case StockTab.analytics:
        return S.of(context).analytics;
      case StockTab.finance:
        return S.of(context).finance;
    }
  }
}
