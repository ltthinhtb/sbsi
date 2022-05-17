import 'package:flutter/cupertino.dart';

import '../../../../generated/l10n.dart';

enum StockTab { over_view, news, analytics, finance }

extension StockExt on StockTab {
  String name(BuildContext context) {
    switch (this) {
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

enum StockTimeline { hour, day }

extension StockTimelineEXT on StockTimeline {
  String name(BuildContext context) {
    switch (this) {
      case StockTimeline.day:
        return "Theo ngày";
      case StockTimeline.hour:
        return "Theo giờ";
    }
  }

  get time {
    switch (this) {
      case StockTimeline.day:
        return "d";
      case StockTimeline.hour:
        return "h";
    }
  }
}
