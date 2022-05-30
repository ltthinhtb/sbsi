import 'package:flutter/material.dart';
import 'package:sbsi/common/app_colors.dart';

class ShareTransferHistory {
  num? rOWNUM;
  String? cBUSINESSCODE;
  String? cTRANSACTIONNO;
  String? cACCOUNTOUT;
  String? cACCOUNTOUTNAME;
  String? cACCOUNTIN;
  String? cACCOUNTINNAME;
  String? cSHARECODE;
  String? cSHARESTATUSOUT;
  String? cSHARESTATUSIN;
  num? cSHAREVOLUME;
  String? cTRANSACTIONDATE;
  String? cCONTENT;
  String? cSTATUS;
  String? cCREATORCODE;
  String? cCREATETIME;
  String? cAPPROVERCODE;
  String? cSTATUSNAME;
  String? cSTATUSNAMEEN;
  String? cREJECTNOTE;

  Color get statusColor {
    if (cSTATUSNAMEEN == "Approved") return AppColors.active;
    return AppColors.deActive;
  }

  ShareTransferHistory(
      {this.rOWNUM,
      this.cBUSINESSCODE,
      this.cTRANSACTIONNO,
      this.cACCOUNTOUT,
      this.cACCOUNTOUTNAME,
      this.cACCOUNTIN,
      this.cACCOUNTINNAME,
      this.cSHARECODE,
      this.cSHARESTATUSOUT,
      this.cSHARESTATUSIN,
      this.cSHAREVOLUME,
      this.cTRANSACTIONDATE,
      this.cCONTENT,
      this.cSTATUS,
      this.cCREATORCODE,
      this.cCREATETIME,
      this.cAPPROVERCODE,
      this.cSTATUSNAME,
      this.cSTATUSNAMEEN,
      this.cREJECTNOTE});

  ShareTransferHistory.fromJson(Map<String, dynamic> json) {
    rOWNUM = json['ROW_NUM'];
    cBUSINESSCODE = json['C_BUSINESS_CODE'];
    cTRANSACTIONNO = json['C_TRANSACTION_NO'];
    cACCOUNTOUT = json['C_ACCOUNT_OUT'];
    cACCOUNTOUTNAME = json['C_ACCOUNT_OUT_NAME'];
    cACCOUNTIN = json['C_ACCOUNT_IN'];
    cACCOUNTINNAME = json['C_ACCOUNT_IN_NAME'];
    cSHARECODE = json['C_SHARE_CODE'];
    cSHARESTATUSOUT = json['C_SHARE_STATUS_OUT'];
    cSHARESTATUSIN = json['C_SHARE_STATUS_IN'];
    cSHAREVOLUME = json['C_SHARE_VOLUME'];
    cTRANSACTIONDATE = json['C_TRANSACTION_DATE'];
    cCONTENT = json['C_CONTENT'];
    cSTATUS = json['C_STATUS'];
    cCREATORCODE = json['C_CREATOR_CODE'];
    cCREATETIME = json['C_CREATE_TIME'];
    cAPPROVERCODE = json['C_APPROVER_CODE'];
    cSTATUSNAME = json['C_STATUS_NAME'];
    cSTATUSNAMEEN = json['C_STATUS_NAME_EN'];
    cREJECTNOTE = json['C_REJECT_NOTE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ROW_NUM'] = this.rOWNUM;
    data['C_BUSINESS_CODE'] = this.cBUSINESSCODE;
    data['C_TRANSACTION_NO'] = this.cTRANSACTIONNO;
    data['C_ACCOUNT_OUT'] = this.cACCOUNTOUT;
    data['C_ACCOUNT_OUT_NAME'] = this.cACCOUNTOUTNAME;
    data['C_ACCOUNT_IN'] = this.cACCOUNTIN;
    data['C_ACCOUNT_IN_NAME'] = this.cACCOUNTINNAME;
    data['C_SHARE_CODE'] = this.cSHARECODE;
    data['C_SHARE_STATUS_OUT'] = this.cSHARESTATUSOUT;
    data['C_SHARE_STATUS_IN'] = this.cSHARESTATUSIN;
    data['C_SHARE_VOLUME'] = this.cSHAREVOLUME;
    data['C_TRANSACTION_DATE'] = this.cTRANSACTIONDATE;
    data['C_CONTENT'] = this.cCONTENT;
    data['C_STATUS'] = this.cSTATUS;
    data['C_CREATOR_CODE'] = this.cCREATORCODE;
    data['C_CREATE_TIME'] = this.cCREATETIME;
    data['C_APPROVER_CODE'] = this.cAPPROVERCODE;
    data['C_STATUS_NAME'] = this.cSTATUSNAME;
    data['C_STATUS_NAME_EN'] = this.cSTATUSNAMEEN;
    data['C_REJECT_NOTE'] = this.cREJECTNOTE;
    return data;
  }
}
