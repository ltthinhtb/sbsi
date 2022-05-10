import 'dart:ui';

import '../../common/app_colors.dart';


class MarketDepth {
  String? tYPE;
  int? sL;

  MarketDepth({this.tYPE, this.sL});

  MarketDepth.fromJson(Map<String, dynamic> json) {
    tYPE = json['TYPE'];
    sL = json['SL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TYPE'] = this.tYPE;
    data['SL'] = this.sL;
    return data;
  }

  Color get color => TypeMarketDepth().negativeInteger.contains(tYPE!)
      ? AppColors.decrease
      : tYPE == TypeMarketDepth().zero
          ? AppColors.yellow
          : AppColors.increase;
}

class TypeMarketDepth {
  List<String> get negativeInteger => [
        "<=-7%",
        "-7--5%",
        "-5--3%",
        "-3--1%",
        "-1--0%",
      ];

  String get zero => "0%";

  String get total => "Total";

  List<String> get integer => ["0-1%", "1-3%", "3-5%", "5-7%", ">=7%"];
}
