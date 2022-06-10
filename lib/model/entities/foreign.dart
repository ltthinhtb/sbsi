import 'package:flutter/material.dart';

import '../../common/app_colors.dart';

class ForeignTrade {
  String? sTOCKCODE;
  num? cFOREIGNBUY;
  num? cFOREIGNSELL;
  num? kLGD;
  num? gTGD;
  String? sTOCKNAME;
  num? cHANGE;
  num? pERCENTCHANGE;
  String? cOLOR;
  num? pRICE;

  ForeignTrade(
      {this.sTOCKCODE,
        this.cFOREIGNBUY,
        this.cFOREIGNSELL,
        this.kLGD,
        this.gTGD,
        this.sTOCKNAME,
        this.cHANGE,
        this.pERCENTCHANGE,
        this.cOLOR,
        this.pRICE});

  Color get color {
    if(cOLOR == null){
      return Colors.transparent;
    }
    return cOLOR == "red"
        ? AppColors.deActive
        : cOLOR == "green"
        ? AppColors.active
        : AppColors.yellow;
  }

  ForeignTrade.fromJson(Map<String, dynamic> json) {
    sTOCKCODE = json['STOCK_CODE'];
    cFOREIGNBUY = json['C_FOREIGN_BUY'];
    cFOREIGNSELL = json['C_FOREIGN_SELL'];
    kLGD = json['KLGD'];
    gTGD = json['GTGD'];
    sTOCKNAME = json['STOCK_NAME'];
    cHANGE = json['CHANGE'];
    pERCENTCHANGE = json['PERCENT_CHANGE'];
    cOLOR = json['COLOR'];
    pRICE = json['PRICE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STOCK_CODE'] = this.sTOCKCODE;
    data['C_FOREIGN_BUY'] = this.cFOREIGNBUY;
    data['C_FOREIGN_SELL'] = this.cFOREIGNSELL;
    data['KLGD'] = this.kLGD;
    data['GTGD'] = this.gTGD;
    data['STOCK_NAME'] = this.sTOCKNAME;
    data['CHANGE'] = this.cHANGE;
    data['PERCENT_CHANGE'] = this.pERCENTCHANGE;
    data['COLOR'] = this.cOLOR;
    data['PRICE'] = this.pRICE;
    return data;
  }
}
