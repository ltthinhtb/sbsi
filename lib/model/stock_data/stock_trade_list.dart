import 'package:flutter/material.dart' as material;
import 'package:sbsi/common/app_colors.dart';

import '../../utils/date_utils.dart';

class ListStockTrade {
  int? rc;
  String? rs;
  List<StockTrade>? data;

  ListStockTrade({this.rc, this.rs, this.data});

  ListStockTrade.fromJson(Map<String, dynamic> json) {
    rc = json['rc'];
    rs = json['rs'];
    if (json['data'] != null) {
      data = <StockTrade>[];
      json['data'].forEach((v) {
        data!.add(new StockTrade.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rc'] = this.rc;
    data['rs'] = this.rs;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StockTrade {
  num? pKID;
  String? sTOCKCODE;
  num? lASTPRICE;
  num? lASTVOL;
  num? uPDATEDTIME;
  num? tOTALVOL;
  String? cOLOR;

  material.Color get color {
    if(cOLOR == null){
      return material.Colors.transparent;
    }
    return cOLOR == "red"
      ? AppColors.active
      : cOLOR == "green"
          ? AppColors.deActive
          : AppColors.yellow;
  }

  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(uPDATEDTIME!.toInt());

  String get time => DateTimeUtils.toDateAPIString(dateTime, format: "HH:mm");

  StockTrade(
      {this.pKID,
      this.sTOCKCODE,
      this.lASTPRICE,
      this.lASTVOL,
      this.uPDATEDTIME,
      this.tOTALVOL,
      this.cOLOR});

  StockTrade.fromJson(Map<String, dynamic> json) {
    pKID = json['PK_ID'];
    sTOCKCODE = json['STOCK_CODE'];
    lASTPRICE = json['LAST_PRICE'];
    lASTVOL = json['LAST_VOL'];
    uPDATEDTIME = json['UPDATED_TIME'];
    tOTALVOL = json['TOTAL_VOL'];
    cOLOR = json['COLOR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PK_ID'] = this.pKID;
    data['STOCK_CODE'] = this.sTOCKCODE;
    data['LAST_PRICE'] = this.lASTPRICE;
    data['LAST_VOL'] = this.lASTVOL;
    data['UPDATED_TIME'] = this.uPDATEDTIME;
    data['TOTAL_VOL'] = this.tOTALVOL;
    data['COLOR'] = this.cOLOR;
    return data;
  }
}
