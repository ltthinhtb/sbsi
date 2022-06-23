import 'package:flutter/material.dart';

import '../../common/app_colors.dart';

class OrderConfirm {
  num? rOWNUM;
  String? pKORDER;
  num? cORDERNO;
  String? cACCOUNTCODE;
  String? cSHARECODE;
  String? cSIDE;
  String? cSIDETYPE;
  String? cCHANEL;
  String? cCHANELNAME;
  String? cORDERDATE;
  String? cORDERTIME;
  num? cORDERVOLUME;
  num? cORDERPRICE;
  String? cORDERSTATUS;
  String? cSHOWPRICE;
  String? cSETORDERTYPE;
  String? cCONFIRMSTATUS;
  String? cCONFIRMTIME;
  String? cCANCELTIME;
  num? cTOTALRECORD;

  String get time {
    return cORDERTIME?.split(" ").last ?? "";
  }

  OrderConfirm(
      {this.rOWNUM,
      this.pKORDER,
      this.cORDERNO,
      this.cACCOUNTCODE,
      this.cSHARECODE,
      this.cSIDE,
      this.cSIDETYPE,
      this.cCHANEL,
      this.cCHANELNAME,
      this.cORDERDATE,
      this.cORDERTIME,
      this.cORDERVOLUME,
      this.cORDERPRICE,
      this.cORDERSTATUS,
      this.cSHOWPRICE,
      this.cSETORDERTYPE,
      this.cCONFIRMSTATUS,
      this.cCONFIRMTIME,
      this.cCANCELTIME,
      this.cTOTALRECORD});

  String get sideString {
    if (cSIDE == "B") return "M";
    return "B";
  }

  Color get colorBack {
    if (cSIDE == "B") return AppColors.active;
    return AppColors.deActive;
  }

  OrderConfirm.fromJson(Map<String, dynamic> json) {
    rOWNUM = json['ROW_NUM'];
    pKORDER = json['PK_ORDER'];
    cORDERNO = json['C_ORDER_NO'];
    cACCOUNTCODE = json['C_ACCOUNT_CODE'];
    cSHARECODE = json['C_SHARE_CODE'];
    cSIDE = json['C_SIDE'];
    cSIDETYPE = json['C_SIDE_TYPE'];
    cCHANEL = json['C_CHANEL'];
    cCHANELNAME = json['C_CHANEL_NAME'];
    cORDERDATE = json['C_ORDER_DATE'];
    cORDERTIME = json['C_ORDER_TIME'];
    cORDERVOLUME = json['C_ORDER_VOLUME'];
    cORDERPRICE = json['C_ORDER_PRICE'];
    cORDERSTATUS = json['C_ORDER_STATUS'];
    cSHOWPRICE = json['C_SHOW_PRICE'];
    cSETORDERTYPE = json['C_SET_ORDER_TYPE'];
    cCONFIRMSTATUS = json['C_CONFIRM_STATUS'];
    cCONFIRMTIME = json['C_CONFIRM_TIME'];
    cCANCELTIME = json['C_CANCEL_TIME'];
    cTOTALRECORD = json['C_TOTAL_RECORD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ROW_NUM'] = this.rOWNUM;
    data['PK_ORDER'] = this.pKORDER;
    data['C_ORDER_NO'] = this.cORDERNO;
    data['C_ACCOUNT_CODE'] = this.cACCOUNTCODE;
    data['C_SHARE_CODE'] = this.cSHARECODE;
    data['C_SIDE'] = this.cSIDE;
    data['C_SIDE_TYPE'] = this.cSIDETYPE;
    data['C_CHANEL'] = this.cCHANEL;
    data['C_CHANEL_NAME'] = this.cCHANELNAME;
    data['C_ORDER_DATE'] = this.cORDERDATE;
    data['C_ORDER_TIME'] = this.cORDERTIME;
    data['C_ORDER_VOLUME'] = this.cORDERVOLUME;
    data['C_ORDER_PRICE'] = this.cORDERPRICE;
    data['C_ORDER_STATUS'] = this.cORDERSTATUS;
    data['C_SHOW_PRICE'] = this.cSHOWPRICE;
    data['C_SET_ORDER_TYPE'] = this.cSETORDERTYPE;
    data['C_CONFIRM_STATUS'] = this.cCONFIRMSTATUS;
    data['C_CONFIRM_TIME'] = this.cCONFIRMTIME;
    data['C_CANCEL_TIME'] = this.cCANCELTIME;
    data['C_TOTAL_RECORD'] = this.cTOTALRECORD;
    return data;
  }
}
