class AdvanceWithdraw {
  num? rOWNUM;
  String? cACCOUNTCODE;
  String? cACCOUNTNAME;
  String? cSELLDATE;
  String? cDUEDATE;
  String? cWITHDRAWDATE;
  String? cCREATETIME;
  num? cSELLVALUE;
  num? cWITHDRAWCASH;
  num? cFEE;
  num? cTAX;
  num? cCASHNET;
  String? cSTATUSNAME;
  String? cSTATUSNAMEEN;
  String? cSTATUSPROCESS;

  AdvanceWithdraw(
      {this.rOWNUM,
      this.cACCOUNTCODE,
      this.cACCOUNTNAME,
      this.cSELLDATE,
      this.cDUEDATE,
      this.cWITHDRAWDATE,
      this.cCREATETIME,
      this.cSELLVALUE,
      this.cWITHDRAWCASH,
      this.cFEE,
      this.cTAX,
      this.cCASHNET,
      this.cSTATUSNAME,
      this.cSTATUSNAMEEN,
      this.cSTATUSPROCESS});

  AdvanceWithdraw.fromJson(Map<String, dynamic> json) {
    rOWNUM = json['ROW_NUM'];
    cACCOUNTCODE = json['C_ACCOUNT_CODE'];
    cACCOUNTNAME = json['C_ACCOUNT_NAME'];
    cSELLDATE = json['C_SELL_DATE'];
    cDUEDATE = json['C_DUE_DATE'];
    cWITHDRAWDATE = json['C_WITHDRAW_DATE'];
    cCREATETIME = json['C_CREATE_TIME'];
    cSELLVALUE = json['C_SELL_VALUE'];
    cWITHDRAWCASH = json['C_WITHDRAW_CASH'];
    cFEE = json['C_FEE'];
    cTAX = json['C_TAX'];
    cCASHNET = json['C_CASH_NET'];
    cSTATUSNAME = json['C_STATUS_NAME'];
    cSTATUSNAMEEN = json['C_STATUS_NAME_EN'];
    cSTATUSPROCESS = json['C_STATUS_PROCESS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ROW_NUM'] = this.rOWNUM;
    data['C_ACCOUNT_CODE'] = this.cACCOUNTCODE;
    data['C_ACCOUNT_NAME'] = this.cACCOUNTNAME;
    data['C_SELL_DATE'] = this.cSELLDATE;
    data['C_DUE_DATE'] = this.cDUEDATE;
    data['C_WITHDRAW_DATE'] = this.cWITHDRAWDATE;
    data['C_CREATE_TIME'] = this.cCREATETIME;
    data['C_SELL_VALUE'] = this.cSELLVALUE;
    data['C_WITHDRAW_CASH'] = this.cWITHDRAWCASH;
    data['C_FEE'] = this.cFEE;
    data['C_TAX'] = this.cTAX;
    data['C_CASH_NET'] = this.cCASHNET;
    data['C_STATUS_NAME'] = this.cSTATUSNAME;
    data['C_STATUS_NAME_EN'] = this.cSTATUSNAMEEN;
    data['C_STATUS_PROCESS'] = this.cSTATUSPROCESS;
    return data;
  }
}
