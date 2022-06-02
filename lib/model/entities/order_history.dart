import 'package:flutter/material.dart';

import '../../common/app_colors.dart';

class OrderHistory {
  num? rOWNUM;
  String? pKORDER;
  num? cORDERNO;
  String? cACCOUNTCODE;
  String? cSHARECODE;
  String? cSIDE;
  String? cCHANEL;
  String? cCHANELNAME;
  String? cORDERDATE;
  String? cORDERTIME;
  num? cORDERVOLUME;
  num? cORDERPRICE;
  String? cORDERSTATUS;
  String? cSHOWSTATUS;
  String? cSTATUSNAME;
  String? cSTATUSNAMEEN;
  String? cSHOWPRICE;
  String? cSETORDERTYPE;
  String? cCONFIRMSTATUS;
  String? cCONFIRMTIME;
  num? cMATCHVOL;
  num? cUNMATCHVOL;
  num? cMATCHPRICE;
  num? cFEEVALUE;
  num? cTAXVALUE;
  num? cMATCHEDVALUE;
  num? cTOTALRECORD;

  String sideString(BuildContext context) {
    if (cSIDE == "B") return "M";
    return "B";
  }

  Color get colorBack {
    if (cSIDE == "B") return AppColors.active;
    return AppColors.deActive;
  }

  String get matchPrice {
    if(cMATCHPRICE == null) return "0";
    return (cMATCHPRICE!/1000).toStringAsFixed(2);
  }

  OrderHistory(
      {this.rOWNUM,
        this.pKORDER,
        this.cORDERNO,
        this.cACCOUNTCODE,
        this.cSHARECODE,
        this.cSIDE,
        this.cCHANEL,
        this.cCHANELNAME,
        this.cORDERDATE,
        this.cORDERTIME,
        this.cORDERVOLUME,
        this.cORDERPRICE,
        this.cORDERSTATUS,
        this.cSHOWSTATUS,
        this.cSTATUSNAME,
        this.cSTATUSNAMEEN,
        this.cSHOWPRICE,
        this.cSETORDERTYPE,
        this.cCONFIRMSTATUS,
        this.cCONFIRMTIME,
        this.cMATCHVOL,
        this.cUNMATCHVOL,
        this.cMATCHPRICE,
        this.cFEEVALUE,
        this.cTAXVALUE,
        this.cMATCHEDVALUE,
        this.cTOTALRECORD});

  OrderHistory.fromJson(Map<String, dynamic> json) {
    rOWNUM = json['ROW_NUM'];
    pKORDER = json['PK_ORDER'];
    cORDERNO = json['C_ORDER_NO'];
    cACCOUNTCODE = json['C_ACCOUNT_CODE'];
    cSHARECODE = json['C_SHARE_CODE'];
    cSIDE = json['C_SIDE'];
    cCHANEL = json['C_CHANEL'];
    cCHANELNAME = json['C_CHANEL_NAME'];
    cORDERDATE = json['C_ORDER_DATE'];
    cORDERTIME = json['C_ORDER_TIME'];
    cORDERVOLUME = json['C_ORDER_VOLUME'];
    cORDERPRICE = json['C_ORDER_PRICE'];
    cORDERSTATUS = json['C_ORDER_STATUS'];
    cSHOWSTATUS = json['C_SHOW_STATUS'];
    cSTATUSNAME = json['C_STATUS_NAME'];
    cSTATUSNAMEEN = json['C_STATUS_NAME_EN'];
    cSHOWPRICE = json['C_SHOW_PRICE'];
    cSETORDERTYPE = json['C_SET_ORDER_TYPE'];
    cCONFIRMSTATUS = json['C_CONFIRM_STATUS'];
    cCONFIRMTIME = json['C_CONFIRM_TIME'];
    cMATCHVOL = json['C_MATCH_VOL'];
    cUNMATCHVOL = json['C_UNMATCH_VOL'];
    cMATCHPRICE = json['C_MATCH_PRICE'];
    cFEEVALUE = json['C_FEE_VALUE'];
    cTAXVALUE = json['C_TAX_VALUE'];
    cMATCHEDVALUE = json['C_MATCHED_VALUE'];
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
    data['C_CHANEL'] = this.cCHANEL;
    data['C_CHANEL_NAME'] = this.cCHANELNAME;
    data['C_ORDER_DATE'] = this.cORDERDATE;
    data['C_ORDER_TIME'] = this.cORDERTIME;
    data['C_ORDER_VOLUME'] = this.cORDERVOLUME;
    data['C_ORDER_PRICE'] = this.cORDERPRICE;
    data['C_ORDER_STATUS'] = this.cORDERSTATUS;
    data['C_SHOW_STATUS'] = this.cSHOWSTATUS;
    data['C_STATUS_NAME'] = this.cSTATUSNAME;
    data['C_STATUS_NAME_EN'] = this.cSTATUSNAMEEN;
    data['C_SHOW_PRICE'] = this.cSHOWPRICE;
    data['C_SET_ORDER_TYPE'] = this.cSETORDERTYPE;
    data['C_CONFIRM_STATUS'] = this.cCONFIRMSTATUS;
    data['C_CONFIRM_TIME'] = this.cCONFIRMTIME;
    data['C_MATCH_VOL'] = this.cMATCHVOL;
    data['C_UNMATCH_VOL'] = this.cUNMATCHVOL;
    data['C_MATCH_PRICE'] = this.cMATCHPRICE;
    data['C_FEE_VALUE'] = this.cFEEVALUE;
    data['C_TAX_VALUE'] = this.cTAXVALUE;
    data['C_MATCHED_VALUE'] = this.cMATCHEDVALUE;
    data['C_TOTAL_RECORD'] = this.cTOTALRECORD;
    return data;
  }
}
