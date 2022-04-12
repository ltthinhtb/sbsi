class OpenAccountRequest {
  String? user;
  String? cmd;
  ParamOpenAccount? param;

  OpenAccountRequest({this.user = 'back', this.cmd = "OPEN_INDI_ACCOUNT", this.param});

  OpenAccountRequest.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    cmd = json['cmd'];
    param = json['param'] != null ? ParamOpenAccount.fromJson(json['param']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['cmd'] = cmd;
    if (param != null) {
      data['param'] = param!.toJson();
    }
    return data;
  }
}

class ParamOpenAccount {
  String? cARDID;
  String? aCCOUNTCODE;
  String? aCCOUNTNAME;
  String? iSSUEDATE;
  String? cARDIDTYPE;
  String? iSSUEPLACE;
  String? cUSTGENDER;
  String? cPROVINCE;
  String? cUSTADDRESS;
  String? cUSTMOBILE;
  String? cUSTEMAIL;
  String? cSALEID;
  String? cANHMATTRUOC;
  String? cANHMATSAU;
  String? cANHCHANDUNG;
  String? cANHCHUKY;
  String? cACCOUNT;
  String? cPASSWORD;

  ParamOpenAccount(
      {this.cARDID,
        this.aCCOUNTCODE,
        this.aCCOUNTNAME,
        this.iSSUEDATE,
        this.cARDIDTYPE,
        this.iSSUEPLACE,
        this.cUSTGENDER,
        this.cPROVINCE,
        this.cUSTADDRESS,
        this.cUSTMOBILE,
        this.cUSTEMAIL,
        this.cSALEID,
        this.cANHMATTRUOC,
        this.cANHMATSAU,
        this.cANHCHANDUNG,
        this.cANHCHUKY,
        this.cACCOUNT,
        this.cPASSWORD});

  ParamOpenAccount.fromJson(Map<String, dynamic> json) {
    cARDID = json['CARD_ID'];
    aCCOUNTCODE = json['ACCOUNT_CODE'];
    aCCOUNTNAME = json['ACCOUNT_NAME'];
    iSSUEDATE = json['ISSUE_DATE'];
    cARDIDTYPE = json['CARD_ID_TYPE'];
    iSSUEPLACE = json['ISSUE_PLACE'];
    cUSTGENDER = json['CUST_GENDER'];
    cPROVINCE = json['C_PROVINCE'];
    cUSTADDRESS = json['CUST_ADDRESS'];
    cUSTMOBILE = json['CUST_MOBILE'];
    cUSTEMAIL = json['CUST_EMAIL'];
    cSALEID = json['C_SALE_ID'];
    cANHMATTRUOC = json['C_ANH_MAT_TRUOC'];
    cANHMATSAU = json['C_ANH_MAT_SAU'];
    cANHCHANDUNG = json['C_ANH_CHAN_DUNG'];
    cANHCHUKY = json['C_ANH_CHU_KY'];
    cACCOUNT = json['C_ACCOUNT'];
    cPASSWORD = json['C_PASSWORD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CARD_ID'] = cARDID;
    data['ACCOUNT_CODE'] = aCCOUNTCODE;
    data['ACCOUNT_NAME'] = aCCOUNTNAME;
    data['ISSUE_DATE'] = iSSUEDATE;
    data['CARD_ID_TYPE'] = cARDIDTYPE;
    data['ISSUE_PLACE'] = iSSUEPLACE;
    data['CUST_GENDER'] = cUSTGENDER;
    data['C_PROVINCE'] = cPROVINCE;
    data['CUST_ADDRESS'] = cUSTADDRESS;
    data['CUST_MOBILE'] = cUSTMOBILE;
    data['CUST_EMAIL'] = cUSTEMAIL;
    data['C_SALE_ID'] = cSALEID;
    data['C_ANH_MAT_TRUOC'] = cANHMATTRUOC;
    data['C_ANH_MAT_SAU'] = cANHMATSAU;
    data['C_ANH_CHAN_DUNG'] = cANHCHANDUNG;
    data['C_ANH_CHU_KY'] = cANHCHUKY;
    data['C_ACCOUNT'] = cACCOUNT;
    data['C_PASSWORD'] = cPASSWORD;
    return data;
  }
}
