class RightHistory {
  num? rOWNUM;
  String? pKRIGHTSTOCKINFO;
  String? cRIGHTTYPE;
  String? cRIGHTRATE;
  num? cCASHRECEIVERATE;
  String? cSHARECODE;
  String? cRECEIVESHARECODE;
  String? cXDATE;
  String? cCLOSEDATE;
  String? cEXECUTEDATE;
  String? cDUEDATE;
  String? cTRANSFERFROMDATE;
  String? cTRANSFERTODATE;
  String? cREGISTERFROMDATE;
  String? cREGISTERTODATE;
  String? cSTATUSNAME;
  String? cSTATUSNAMEEN;
  String? cACCOUNTCODE;
  num? cBUYPRICE;
  num? cSHAREBUY;
  num? cCASHBUY;
  num? cSHAREDIVIDENT;
  num? cSHAREODDLOT;
  num? cCASHVOLUME;
  num? cTAXVOLUME;
  String? cNOTE;
  num? cSHAREVOLUME;
  num? cRIGHTVOLUME;
  num? cSHARERIGHT;
  num? cCASHBUYALL;

  String get cDudeDate {
    if(cDUEDATE == "null") return "";
    return cDUEDATE!;
  }

  String get cReceiverCode {
    if(cRECEIVESHARECODE == "null") return "";
    return cRECEIVESHARECODE!;
  }

  bool get ratePercent {
    if(cRIGHTRATE?.contains("%") ?? true){
      return true;
    }
    return false;
  }

  RightHistory(
      {this.rOWNUM,
        this.pKRIGHTSTOCKINFO,
        this.cRIGHTTYPE,
        this.cRIGHTRATE,
        this.cCASHRECEIVERATE,
        this.cSHARECODE,
        this.cRECEIVESHARECODE,
        this.cXDATE,
        this.cCLOSEDATE,
        this.cEXECUTEDATE,
        this.cDUEDATE,
        this.cTRANSFERFROMDATE,
        this.cTRANSFERTODATE,
        this.cREGISTERFROMDATE,
        this.cREGISTERTODATE,
        this.cSTATUSNAME,
        this.cSTATUSNAMEEN,
        this.cACCOUNTCODE,
        this.cBUYPRICE,
        this.cSHAREBUY,
        this.cCASHBUY,
        this.cSHAREDIVIDENT,
        this.cSHAREODDLOT,
        this.cCASHVOLUME,
        this.cTAXVOLUME,
        this.cNOTE,
        this.cSHAREVOLUME,
        this.cRIGHTVOLUME,
        this.cSHARERIGHT,
        this.cCASHBUYALL});

  RightHistory.fromJson(Map<String, dynamic> json) {
    rOWNUM = json['ROW_NUM'];
    pKRIGHTSTOCKINFO = json['PK_RIGHT_STOCK_INFO'];
    cRIGHTTYPE = json['C_RIGHT_TYPE'];
    cRIGHTRATE = json['C_RIGHT_RATE'];
    cCASHRECEIVERATE = json['C_CASH_RECEIVE_RATE'];
    cSHARECODE = json['C_SHARE_CODE'];
    cRECEIVESHARECODE = json['C_RECEIVE_SHARE_CODE'];
    cXDATE = json['C_XDATE'];
    cCLOSEDATE = json['C_CLOSE_DATE'];
    cEXECUTEDATE = json['C_EXECUTE_DATE'];
    cDUEDATE = json['C_DUE_DATE'];
    cTRANSFERFROMDATE = json['C_TRANSFER_FROM_DATE'];
    cTRANSFERTODATE = json['C_TRANSFER_TO_DATE'];
    cREGISTERFROMDATE = json['C_REGISTER_FROM_DATE'];
    cREGISTERTODATE = json['C_REGISTER_TO_DATE'];
    cSTATUSNAME = json['C_STATUS_NAME'];
    cSTATUSNAMEEN = json['C_STATUS_NAME_EN'];
    cACCOUNTCODE = json['C_ACCOUNT_CODE'];
    cBUYPRICE = json['C_BUY_PRICE'];
    cSHAREBUY = json['C_SHARE_BUY'];
    cCASHBUY = json['C_CASH_BUY'];
    cSHAREDIVIDENT = json['C_SHARE_DIVIDENT'];
    cSHAREODDLOT = json['C_SHARE_ODD_LOT'];
    cCASHVOLUME = json['C_CASH_VOLUME'];
    cTAXVOLUME = json['C_TAX_VOLUME'];
    cNOTE = json['C_NOTE'];
    cSHAREVOLUME = json['C_SHARE_VOLUME'];
    cRIGHTVOLUME = json['C_RIGHT_VOLUME'];
    cSHARERIGHT = json['C_SHARE_RIGHT'];
    cCASHBUYALL = json['C_CASH_BUY_ALL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ROW_NUM'] = this.rOWNUM;
    data['PK_RIGHT_STOCK_INFO'] = this.pKRIGHTSTOCKINFO;
    data['C_RIGHT_TYPE'] = this.cRIGHTTYPE;
    data['C_RIGHT_RATE'] = this.cRIGHTRATE;
    data['C_CASH_RECEIVE_RATE'] = this.cCASHRECEIVERATE;
    data['C_SHARE_CODE'] = this.cSHARECODE;
    data['C_RECEIVE_SHARE_CODE'] = this.cRECEIVESHARECODE;
    data['C_XDATE'] = this.cXDATE;
    data['C_CLOSE_DATE'] = this.cCLOSEDATE;
    data['C_EXECUTE_DATE'] = this.cEXECUTEDATE;
    data['C_DUE_DATE'] = this.cDUEDATE;
    data['C_TRANSFER_FROM_DATE'] = this.cTRANSFERFROMDATE;
    data['C_TRANSFER_TO_DATE'] = this.cTRANSFERTODATE;
    data['C_REGISTER_FROM_DATE'] = this.cREGISTERFROMDATE;
    data['C_REGISTER_TO_DATE'] = this.cREGISTERTODATE;
    data['C_STATUS_NAME'] = this.cSTATUSNAME;
    data['C_STATUS_NAME_EN'] = this.cSTATUSNAMEEN;
    data['C_ACCOUNT_CODE'] = this.cACCOUNTCODE;
    data['C_BUY_PRICE'] = this.cBUYPRICE;
    data['C_SHARE_BUY'] = this.cSHAREBUY;
    data['C_CASH_BUY'] = this.cCASHBUY;
    data['C_SHARE_DIVIDENT'] = this.cSHAREDIVIDENT;
    data['C_SHARE_ODD_LOT'] = this.cSHAREODDLOT;
    data['C_CASH_VOLUME'] = this.cCASHVOLUME;
    data['C_TAX_VOLUME'] = this.cTAXVOLUME;
    data['C_NOTE'] = this.cNOTE;
    data['C_SHARE_VOLUME'] = this.cSHAREVOLUME;
    data['C_RIGHT_VOLUME'] = this.cRIGHTVOLUME;
    data['C_SHARE_RIGHT'] = this.cSHARERIGHT;
    data['C_CASH_BUY_ALL'] = this.cCASHBUYALL;
    return data;
  }
}
