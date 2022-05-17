
import 'package:flutter/material.dart';
import 'package:sbsi/common/app_colors.dart';

class HistoryTransfer {
  num? rOWNUM;
  String? cACCOUNTOUT;
  String? cACCOUNTOUTNAME;
  String? cACCOUNTIN;
  String? cACCOUNTINNAME;
  String? cBANKCODE;
  String? cBRANCHBANKCODE;
  String? cBANKADDRESSACCOUNTIN;
  String? cBANKNAMEACCOUNTIN;
  String? cTRANSACTIONNO;
  String? cTRANSACTIONDATE;
  String? cCREATETIME;
  String? cAPPROVERCODE;
  String? cAPPROVETIME;
  String? cWITHDRAWTYPE;
  num? cCASHVOLUME;
  num? cFEETRANSFEROUT;
  num? cRECEIVEPAYFEEFLAG;
  String? cSTATUS;
  String? cCONTENT;
  String? cCANCELNOTE;
  String? cSTATUSNAME;
  String? cSTATUSNAMEEN;
  String? cONLINECHANNEL;


  String get timeString => cCREATETIME?.split("-").first ??"";
  String get type  => cONLINECHANNEL == "INTERNAL" ? "Nội bộ" : "Ngân hàng";

  Color get statusColor {
    if(cSTATUS == "DA_DUYET") return AppColors.active;
    return AppColors.deActive;
  }


  HistoryTransfer(
      {this.rOWNUM,
        this.cACCOUNTOUT,
        this.cACCOUNTOUTNAME,
        this.cACCOUNTIN,
        this.cACCOUNTINNAME,
        this.cBANKCODE,
        this.cBRANCHBANKCODE,
        this.cBANKADDRESSACCOUNTIN,
        this.cBANKNAMEACCOUNTIN,
        this.cTRANSACTIONNO,
        this.cTRANSACTIONDATE,
        this.cCREATETIME,
        this.cAPPROVERCODE,
        this.cAPPROVETIME,
        this.cWITHDRAWTYPE,
        this.cCASHVOLUME,
        this.cFEETRANSFEROUT,
        this.cRECEIVEPAYFEEFLAG,
        this.cSTATUS,
        this.cCONTENT,
        this.cCANCELNOTE,
        this.cSTATUSNAME,
        this.cSTATUSNAMEEN,
        this.cONLINECHANNEL});

  HistoryTransfer.fromJson(Map<String, dynamic> json) {
    rOWNUM = json['ROW_NUM'];
    cACCOUNTOUT = json['C_ACCOUNT_OUT'];
    cACCOUNTOUTNAME = json['C_ACCOUNT_OUT_NAME'];
    cACCOUNTIN = json['C_ACCOUNT_IN'];
    cACCOUNTINNAME = json['C_ACCOUNT_IN_NAME'];
    cBANKCODE = json['C_BANK_CODE'];
    cBRANCHBANKCODE = json['C_BRANCH_BANK_CODE'];
    cBANKADDRESSACCOUNTIN = json['C_BANK_ADDRESS_ACCOUNT_IN'];
    cBANKNAMEACCOUNTIN = json['C_BANK_NAME_ACCOUNT_IN'];
    cTRANSACTIONNO = json['C_TRANSACTION_NO'];
    cTRANSACTIONDATE = json['C_TRANSACTION_DATE'];
    cCREATETIME = json['C_CREATE_TIME'];
    cAPPROVERCODE = json['C_APPROVER_CODE'];
    cAPPROVETIME = json['C_APPROVE_TIME'];
    cWITHDRAWTYPE = json['C_WITHDRAW_TYPE'];
    cCASHVOLUME = json['C_CASH_VOLUME'];
    cFEETRANSFEROUT = json['C_FEE_TRANSFER_OUT'];
    cRECEIVEPAYFEEFLAG = json['C_RECEIVE_PAY_FEE_FLAG'];
    cSTATUS = json['C_STATUS'];
    cCONTENT = json['C_CONTENT'];
    cCANCELNOTE = json['C_CANCEL_NOTE'];
    cSTATUSNAME = json['C_STATUS_NAME'];
    cSTATUSNAMEEN = json['C_STATUS_NAME_EN'];
    cONLINECHANNEL = json['C_ONLINE_CHANNEL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ROW_NUM'] = this.rOWNUM;
    data['C_ACCOUNT_OUT'] = this.cACCOUNTOUT;
    data['C_ACCOUNT_OUT_NAME'] = this.cACCOUNTOUTNAME;
    data['C_ACCOUNT_IN'] = this.cACCOUNTIN;
    data['C_ACCOUNT_IN_NAME'] = this.cACCOUNTINNAME;
    data['C_BANK_CODE'] = this.cBANKCODE;
    data['C_BRANCH_BANK_CODE'] = this.cBRANCHBANKCODE;
    data['C_BANK_ADDRESS_ACCOUNT_IN'] = this.cBANKADDRESSACCOUNTIN;
    data['C_BANK_NAME_ACCOUNT_IN'] = this.cBANKNAMEACCOUNTIN;
    data['C_TRANSACTION_NO'] = this.cTRANSACTIONNO;
    data['C_TRANSACTION_DATE'] = this.cTRANSACTIONDATE;
    data['C_CREATE_TIME'] = this.cCREATETIME;
    data['C_APPROVER_CODE'] = this.cAPPROVERCODE;
    data['C_APPROVE_TIME'] = this.cAPPROVETIME;
    data['C_WITHDRAW_TYPE'] = this.cWITHDRAWTYPE;
    data['C_CASH_VOLUME'] = this.cCASHVOLUME;
    data['C_FEE_TRANSFER_OUT'] = this.cFEETRANSFEROUT;
    data['C_RECEIVE_PAY_FEE_FLAG'] = this.cRECEIVEPAYFEEFLAG;
    data['C_STATUS'] = this.cSTATUS;
    data['C_CONTENT'] = this.cCONTENT;
    data['C_CANCEL_NOTE'] = this.cCANCELNOTE;
    data['C_STATUS_NAME'] = this.cSTATUSNAME;
    data['C_STATUS_NAME_EN'] = this.cSTATUSNAMEEN;
    data['C_ONLINE_CHANNEL'] = this.cONLINECHANNEL;
    return data;
  }
}
