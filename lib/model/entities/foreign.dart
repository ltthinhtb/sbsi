import 'package:flutter/material.dart';

import '../../common/app_colors.dart';

class ForeignTrade {
  String? nAME;
  String? lASTPOINT;
  String? cHANGE;
  String? pERCENTCHANGE;
  String? cOLOR;
  num? iSSHOW;
  num? sTT;
  num? iDSYMBOL;
  num? iSDEFAULT;

  ForeignTrade(
      {this.nAME,
        this.lASTPOINT,
        this.cHANGE,
        this.pERCENTCHANGE,
        this.cOLOR,
        this.iSSHOW,
        this.sTT,
        this.iDSYMBOL,
        this.iSDEFAULT});

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
    nAME = json['NAME'];
    lASTPOINT = json['LAST_POINT'];
    cHANGE = json['CHANGE'];
    pERCENTCHANGE = json['PERCENT_CHANGE'];
    cOLOR = json['COLOR'];
    iSSHOW = json['IS_SHOW'];
    sTT = json['STT'];
    iDSYMBOL = json['ID_SYMBOL'];
    iSDEFAULT = json['IS_DEFAULT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NAME'] = this.nAME;
    data['LAST_POINT'] = this.lASTPOINT;
    data['CHANGE'] = this.cHANGE;
    data['PERCENT_CHANGE'] = this.pERCENTCHANGE;
    data['COLOR'] = this.cOLOR;
    data['IS_SHOW'] = this.iSSHOW;
    data['STT'] = this.sTT;
    data['ID_SYMBOL'] = this.iDSYMBOL;
    data['IS_DEFAULT'] = this.iSDEFAULT;
    return data;
  }
}
