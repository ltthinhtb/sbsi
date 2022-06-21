class RightExc {
  String? pKRIGHTSTOCKINFO;
  String? cRIGHTTYPENAME;
  String? cRIGHTTYPENAMEEN;
  num? cRIGHTBUYFLAG;
  String? cRIGHTRATE;
  num? cCASHRECEIVERATE;
  String? cSHARECODE;
  String? cSHARENAME;
  String? cRECEIVESHARECODE;
  String? cXDATE;
  String? cCLOSEDATE;
  String? cEXECUTEDATE;
  String? cDUEDATE;
  String? cTRANSFERFROMDATE;
  String? cTRANSFERTODATE;
  String? cREGISTERFROMDATE;
  String? cREGISTERTODATE;
  String? cTRANSFERTYPE;
  num? cFLAG;
  String? cTRANSFERNAME;
  String? cSTATUSNAME;
  String? cSTATUSNAMEEN;
  String? cACCOUNTCODE;
  num? cBUYPRICE;
  num? cSHAREBUY;
  num? cCASHBUY;
  num? cSHAREDIVIDENT;
  num? cSHAREODDLOT;
  num? cCASHODDLOT;
  num? cCASHVOLUME;
  num? cTAXVOLUME;
  String? cNOTE;
  num? cSHAREVOLUME;
  num? cRIGHTRECEIVER;
  num? cRIGHTTRANSFER;
  num? cRIGHTVOLUME;
  num? cSHARERIGHT;
  num? cCASHBUYALL;



  bool get showAction {
    if (cSHAREBUY == null) return false;
    if (cSHARERIGHT == null) return false;
    if (cFLAG == 1 && cSHAREBUY! < cSHARERIGHT!)
      return true;
    else
      return false;
  }

  double get rate {
    if (cRIGHTRATE == null || cRIGHTRATE!.isEmpty) return 1;
    var list = cRIGHTRATE!.replaceAll("/", "-").split("-");
    try {
      var top = int.parse(list.first);
      var bottom = int.parse(list.last);
      return bottom / top;
    } catch (e) {
      return 1;
    }
  }

  num get cShareCL {
    return cSHAREVOLUME! * rate - cSHAREBUY!;
  }

  String get cShareCLString {
    return cShareCL.toString().split(".").first;
  }


  String get eXECUTEDATE1 {
    if (cEXECUTEDATE == null) return "";
    if (cEXECUTEDATE == "null") return "";
    return cEXECUTEDATE!;
  }

  String get cDueDate {
    if (cDUEDATE == null) return "";
    if (cDUEDATE == "null") return "";
    return cDUEDATE!;
  }

  String get cRightRate {
    if (cRIGHTRATE == null) return "";
    if (cRIGHTRATE == "null") return "";
    return cRIGHTRATE!;
  }

  String get dueDATE {
    if (cDUEDATE == null) return "";
    if (cDUEDATE == "null") return "";
    return cDUEDATE!;
  }

  RightExc(
      {this.pKRIGHTSTOCKINFO,
      this.cRIGHTTYPENAME,
      this.cRIGHTTYPENAMEEN,
      this.cRIGHTBUYFLAG,
      this.cRIGHTRATE,
      this.cCASHRECEIVERATE,
      this.cSHARECODE,
      this.cSHARENAME,
      this.cRECEIVESHARECODE,
      this.cXDATE,
      this.cCLOSEDATE,
      this.cEXECUTEDATE,
      this.cDUEDATE,
      this.cTRANSFERFROMDATE,
      this.cTRANSFERTODATE,
      this.cREGISTERFROMDATE,
      this.cREGISTERTODATE,
      this.cTRANSFERTYPE,
      this.cFLAG,
      this.cTRANSFERNAME,
      this.cSTATUSNAME,
      this.cSTATUSNAMEEN,
      this.cACCOUNTCODE,
      this.cBUYPRICE,
      this.cSHAREBUY,
      this.cCASHBUY,
      this.cSHAREDIVIDENT,
      this.cSHAREODDLOT,
      this.cCASHODDLOT,
      this.cCASHVOLUME,
      this.cTAXVOLUME,
      this.cNOTE,
      this.cSHAREVOLUME,
      this.cRIGHTRECEIVER,
      this.cRIGHTTRANSFER,
      this.cRIGHTVOLUME,
      this.cSHARERIGHT,
      this.cCASHBUYALL});

  RightExc.fromJson(Map<String, dynamic> json) {
    pKRIGHTSTOCKINFO = json['PK_RIGHT_STOCK_INFO'];
    cRIGHTTYPENAME = json['C_RIGHT_TYPE_NAME'];
    cRIGHTTYPENAMEEN = json['C_RIGHT_TYPE_NAME_EN'];
    cRIGHTBUYFLAG = json['C_RIGHT_BUY_FLAG'];
    cRIGHTRATE = json['C_RIGHT_RATE'];
    cCASHRECEIVERATE = json['C_CASH_RECEIVE_RATE'];
    cSHARECODE = json['C_SHARE_CODE'];
    cSHARENAME = json['C_SHARE_NAME'];
    cRECEIVESHARECODE = json['C_RECEIVE_SHARE_CODE'];
    cXDATE = json['C_XDATE'];
    cCLOSEDATE = json['C_CLOSE_DATE'];
    cEXECUTEDATE = json['C_EXECUTE_DATE'];
    cDUEDATE = json['C_DUE_DATE'];
    cTRANSFERFROMDATE = json['C_TRANSFER_FROM_DATE'];
    cTRANSFERTODATE = json['C_TRANSFER_TO_DATE'];
    cREGISTERFROMDATE = json['C_REGISTER_FROM_DATE'];
    cREGISTERTODATE = json['C_REGISTER_TO_DATE'];
    cTRANSFERTYPE = json['C_TRANSFER_TYPE'];
    cFLAG = json['C_FLAG'];
    cTRANSFERNAME = json['C_TRANSFER_NAME'];
    cSTATUSNAME = json['C_STATUS_NAME'];
    cSTATUSNAMEEN = json['C_STATUS_NAME_EN'];
    cACCOUNTCODE = json['C_ACCOUNT_CODE'];
    cBUYPRICE = json['C_BUY_PRICE'];
    cSHAREBUY = json['C_SHARE_BUY'];
    cCASHBUY = json['C_CASH_BUY'];
    cSHAREDIVIDENT = json['C_SHARE_DIVIDENT'];
    cSHAREODDLOT = json['C_SHARE_ODD_LOT'];
    cCASHODDLOT = json['C_CASH_ODD_LOT'];
    cCASHVOLUME = json['C_CASH_VOLUME'];
    cTAXVOLUME = json['C_TAX_VOLUME'];
    cNOTE = json['C_NOTE'];
    cSHAREVOLUME = json['C_SHARE_VOLUME'];
    cRIGHTRECEIVER = json['C_RIGHT_RECEIVER'];
    cRIGHTTRANSFER = json['C_RIGHT_TRANSFER'];
    cRIGHTVOLUME = json['C_RIGHT_VOLUME'];
    cSHARERIGHT = json['C_SHARE_RIGHT'];
    cCASHBUYALL = json['C_CASH_BUY_ALL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PK_RIGHT_STOCK_INFO'] = this.pKRIGHTSTOCKINFO;
    data['C_RIGHT_TYPE_NAME'] = this.cRIGHTTYPENAME;
    data['C_RIGHT_TYPE_NAME_EN'] = this.cRIGHTTYPENAMEEN;
    data['C_RIGHT_BUY_FLAG'] = this.cRIGHTBUYFLAG;
    data['C_RIGHT_RATE'] = this.cRIGHTRATE;
    data['C_CASH_RECEIVE_RATE'] = this.cCASHRECEIVERATE;
    data['C_SHARE_CODE'] = this.cSHARECODE;
    data['C_SHARE_NAME'] = this.cSHARENAME;
    data['C_RECEIVE_SHARE_CODE'] = this.cRECEIVESHARECODE;
    data['C_XDATE'] = this.cXDATE;
    data['C_CLOSE_DATE'] = this.cCLOSEDATE;
    data['C_EXECUTE_DATE'] = this.cEXECUTEDATE;
    data['C_DUE_DATE'] = this.cDUEDATE;
    data['C_TRANSFER_FROM_DATE'] = this.cTRANSFERFROMDATE;
    data['C_TRANSFER_TO_DATE'] = this.cTRANSFERTODATE;
    data['C_REGISTER_FROM_DATE'] = this.cREGISTERFROMDATE;
    data['C_REGISTER_TO_DATE'] = this.cREGISTERTODATE;
    data['C_TRANSFER_TYPE'] = this.cTRANSFERTYPE;
    data['C_FLAG'] = this.cFLAG;
    data['C_TRANSFER_NAME'] = this.cTRANSFERNAME;
    data['C_STATUS_NAME'] = this.cSTATUSNAME;
    data['C_STATUS_NAME_EN'] = this.cSTATUSNAMEEN;
    data['C_ACCOUNT_CODE'] = this.cACCOUNTCODE;
    data['C_BUY_PRICE'] = this.cBUYPRICE;
    data['C_SHARE_BUY'] = this.cSHAREBUY;
    data['C_CASH_BUY'] = this.cCASHBUY;
    data['C_SHARE_DIVIDENT'] = this.cSHAREDIVIDENT;
    data['C_SHARE_ODD_LOT'] = this.cSHAREODDLOT;
    data['C_CASH_ODD_LOT'] = this.cCASHODDLOT;
    data['C_CASH_VOLUME'] = this.cCASHVOLUME;
    data['C_TAX_VOLUME'] = this.cTAXVOLUME;
    data['C_NOTE'] = this.cNOTE;
    data['C_SHARE_VOLUME'] = this.cSHAREVOLUME;
    data['C_RIGHT_RECEIVER'] = this.cRIGHTRECEIVER;
    data['C_RIGHT_TRANSFER'] = this.cRIGHTTRANSFER;
    data['C_RIGHT_VOLUME'] = this.cRIGHTVOLUME;
    data['C_SHARE_RIGHT'] = this.cSHARERIGHT;
    data['C_CASH_BUY_ALL'] = this.cCASHBUYALL;
    return data;
  }
}
