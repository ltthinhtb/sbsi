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

enum keyIndicators { EPS, PE, PB }

extension keyIndicatorsExt on keyIndicators {
  String get name => this.toString().split(".").last;

  int get value => _mapValue[this]!;

  Map<keyIndicators, int> get _mapValue => {
        keyIndicators.EPS: 53,
        keyIndicators.PB: 57,
        keyIndicators.PE: 55,
      };
}

class ReportState {
  String name;
  int value;

  ReportState(this.name, this.value);
}

enum Tern { quarterly, year }

extension ternExt on Tern {
  get name {
    switch (this) {
      case Tern.quarterly:
        return "Theo quý";
      case Tern.year:
        return "Theo năm";
    }
  }

  get value {
    switch (this) {
      case Tern.quarterly:
        return "2";
      case Tern.year:
        return "1";
    }
  }
}
