class CashCanAdv {
  num? rOWNUM;
  String? cACCOUNTCODE;
  String? cSELLDATE;
  String? cDUEDATE;
  num? cSELLCASHTOTAL;
  num? cSELLCOMM;
  num? cSELLTAX;
  num? cSELLCOMMTRANFER;
  num? cCOMMANDTAX;
  num? cPLEDGECASH;
  num? cBCCCASH;
  num? cWITHDRAWED;
  num? cWITHDRAWEDFEE;
  num? cWITHDRAWABLE;
  num? cWITHDRAWBLEMAX;
  num? cWITHDRAWBLEFEE;
  num? cRIGHTSELLPAYTAX;

  CashCanAdv(
      {this.rOWNUM,
        this.cACCOUNTCODE,
        this.cSELLDATE,
        this.cDUEDATE,
        this.cSELLCASHTOTAL,
        this.cSELLCOMM,
        this.cSELLTAX,
        this.cSELLCOMMTRANFER,
        this.cCOMMANDTAX,
        this.cPLEDGECASH,
        this.cBCCCASH,
        this.cWITHDRAWED,
        this.cWITHDRAWEDFEE,
        this.cWITHDRAWABLE,
        this.cWITHDRAWBLEMAX,
        this.cWITHDRAWBLEFEE,
        this.cRIGHTSELLPAYTAX});

  CashCanAdv.fromJson(Map<String, dynamic> json) {
    rOWNUM = json['ROW_NUM'];
    cACCOUNTCODE = json['C_ACCOUNT_CODE'];
    cSELLDATE = json['C_SELL_DATE'];
    cDUEDATE = json['C_DUE_DATE'];
    cSELLCASHTOTAL = json['C_SELL_CASH_TOTAL'];
    cSELLCOMM = json['C_SELL_COMM'];
    cSELLTAX = json['C_SELL_TAX'];
    cSELLCOMMTRANFER = json['C_SELL_COMM_TRANFER'];
    cCOMMANDTAX = json['C_COMM_AND_TAX'];
    cPLEDGECASH = json['C_PLEDGE_CASH'];
    cBCCCASH = json['C_BCC_CASH'];
    cWITHDRAWED = json['C_WITHDRAWED'];
    cWITHDRAWEDFEE = json['C_WITHDRAWED_FEE'];
    cWITHDRAWABLE = json['C_WITHDRAWABLE'];
    cWITHDRAWBLEMAX = json['C_WITHDRAWBLE_MAX'];
    cWITHDRAWBLEFEE = json['C_WITHDRAWBLE_FEE'];
    cRIGHTSELLPAYTAX = json['C_RIGHT_SELL_PAY_TAX'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ROW_NUM'] = this.rOWNUM;
    data['C_ACCOUNT_CODE'] = this.cACCOUNTCODE;
    data['C_SELL_DATE'] = this.cSELLDATE;
    data['C_DUE_DATE'] = this.cDUEDATE;
    data['C_SELL_CASH_TOTAL'] = this.cSELLCASHTOTAL;
    data['C_SELL_COMM'] = this.cSELLCOMM;
    data['C_SELL_TAX'] = this.cSELLTAX;
    data['C_SELL_COMM_TRANFER'] = this.cSELLCOMMTRANFER;
    data['C_COMM_AND_TAX'] = this.cCOMMANDTAX;
    data['C_PLEDGE_CASH'] = this.cPLEDGECASH;
    data['C_BCC_CASH'] = this.cBCCCASH;
    data['C_WITHDRAWED'] = this.cWITHDRAWED;
    data['C_WITHDRAWED_FEE'] = this.cWITHDRAWEDFEE;
    data['C_WITHDRAWABLE'] = this.cWITHDRAWABLE;
    data['C_WITHDRAWBLE_MAX'] = this.cWITHDRAWBLEMAX;
    data['C_WITHDRAWBLE_FEE'] = this.cWITHDRAWBLEFEE;
    data['C_RIGHT_SELL_PAY_TAX'] = this.cRIGHTSELLPAYTAX;
    return data;
  }
}
