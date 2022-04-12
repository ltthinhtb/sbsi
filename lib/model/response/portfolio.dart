import 'package:flutter/material.dart';
import 'package:sbsi/common/app_colors.dart';

class Portfolio {
  String? cmd;
  String? oID;
  int? rc;
  String? rs;
  List<PortfolioStatus>? data;

  Portfolio({this.cmd, this.oID, this.rc, this.rs, this.data});

  Portfolio.fromJson(Map<String, dynamic> json) {
    cmd = json['cmd'];
    oID = json['oID'];
    rc = json['rc'];
    rs = json['rs'];
    if (json['data'] != null) {
      data = <PortfolioStatus>[];
      json['data'].forEach((v) {
        data!.add(PortfolioStatus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cmd'] = cmd;
    data['oID'] = oID;
    data['rc'] = rc;
    data['rs'] = rs;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PortfolioStatus {
  String? symbol;
  String? actualVol;
  String? avaiableVol;
  String? repoVol;
  String? rightVol;
  String? marginRate;
  String? buyT1;
  String? sellT1;
  String? buyT2;
  String? sellT2;
  String? buyT0;
  String? sellT0;
  String? account;
  String? sellUnmatchVol;
  String? avgPrice;
  String? value;
  String? marketPrice;
  String? marketValue;
  String? gainLossValue;
  String? gl;
  String? gainLossPer;
  String? relized;
  String? plg;

  Color get glColor =>  gl == "g" ? AppColors.increase : AppColors.decrease;

  PortfolioStatus(
      {this.symbol,
      this.actualVol,
      this.avaiableVol,
      this.repoVol,
      this.rightVol,
      this.marginRate,
      this.buyT1,
      this.sellT1,
      this.buyT2,
      this.sellT2,
      this.buyT0,
      this.sellT0,
      this.account,
      this.sellUnmatchVol,
      this.avgPrice,
      this.value,
      this.marketPrice,
      this.marketValue,
      this.gainLossValue,
      this.gl,
      this.gainLossPer,
      this.relized,
      this.plg});

  PortfolioStatus.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    actualVol = json['actual_vol'];
    avaiableVol = json['avaiable_vol'];
    repoVol = json['repo_vol'];
    rightVol = json['right_vol'];
    marginRate = json['margin_rate'];
    buyT1 = json['buy_t1'];
    sellT1 = json['sell_t1'];
    buyT2 = json['buy_t2'];
    sellT2 = json['sell_t2'];
    buyT0 = json['buy_t0'];
    sellT0 = json['sell_t0'];
    account = json['account'];
    sellUnmatchVol = json['sell_unmatch_vol'];
    avgPrice = json['avg_price'];
    value = json['value'];
    marketPrice = json['market_price'];
    marketValue = json['market_value'];
    gainLossValue = json['gain_loss_value'];
    gl = json['gl'];
    gainLossPer = json['gain_loss_per'];
    relized = json['relized'];
    plg = json['plg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['actual_vol'] = actualVol;
    data['avaiable_vol'] = avaiableVol;
    data['repo_vol'] = repoVol;
    data['right_vol'] = rightVol;
    data['margin_rate'] = marginRate;
    data['buy_t1'] = buyT1;
    data['sell_t1'] = sellT1;
    data['buy_t2'] = buyT2;
    data['sell_t2'] = sellT2;
    data['buy_t0'] = buyT0;
    data['sell_t0'] = sellT0;
    data['account'] = account;
    data['sell_unmatch_vol'] = sellUnmatchVol;
    data['avg_price'] = avgPrice;
    data['value'] = value;
    data['market_price'] = marketPrice;
    data['market_value'] = marketValue;
    data['gain_loss_value'] = gainLossValue;
    data['gl'] = gl;
    data['gain_loss_per'] = gainLossPer;
    data['relized'] = relized;
    data['plg'] = plg;
    return data;
  }
}
