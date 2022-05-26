class OpenAccountRequest {
  String? cCARDID;
  String? cFULLNAME;
  String? cCUSTBIRTHDAY;
  String? cISSUEDATE;
  String? cISSUEEXPIRE;
  String? cISSUEPLACE;
  String? cGENDER;
  String? cPROVINCE;
  String? cADDRESS;
  String? cCONTACTADDRESS;
  String? cMOBILE;
  String? cEMAIL;
  String? cMOBILETRADINGPASSWORD;
  String? cBANKCODE;
  String? cRECEIVEBANKACCOUNT;
  String? cSALEID;
  String? cANHMATTRUOC;
  String? cANHMATSAU;
  String? cANHCHANDUNG;
  String? cANHCHUKY;
  String? cPASSWORD;
  String? cOPENMARGIN;

  OpenAccountRequest(
      {this.cCARDID,
        this.cFULLNAME,
        this.cCUSTBIRTHDAY,
        this.cISSUEDATE,
        this.cISSUEEXPIRE,
        this.cISSUEPLACE,
        this.cGENDER,
        this.cPROVINCE,
        this.cADDRESS,
        this.cCONTACTADDRESS,
        this.cMOBILE,
        this.cEMAIL,
        this.cMOBILETRADINGPASSWORD,
        this.cBANKCODE,
        this.cRECEIVEBANKACCOUNT,
        this.cSALEID,
        this.cANHMATTRUOC,
        this.cANHMATSAU,
        this.cANHCHANDUNG,
        this.cANHCHUKY,
        this.cPASSWORD,
        this.cOPENMARGIN});

  OpenAccountRequest.fromJson(Map<String, dynamic> json) {
    cCARDID = json['C_CARD_ID'];
    cFULLNAME = json['C_FULL_NAME'];
    cCUSTBIRTHDAY = json['C_CUST_BIRTH_DAY'];
    cISSUEDATE = json['C_ISSUE_DATE'];
    cISSUEEXPIRE = json['C_ISSUE_EXPIRE'];
    cISSUEPLACE = json['C_ISSUE_PLACE'];
    cGENDER = json['C_GENDER'];
    cPROVINCE = json['C_PROVINCE'];
    cADDRESS = json['C_ADDRESS'];
    cCONTACTADDRESS = json['C_CONTACT_ADDRESS'];
    cMOBILE = json['C_MOBILE'];
    cEMAIL = json['C_EMAIL'];
    cMOBILETRADINGPASSWORD = json['C_MOBILE_TRADING_PASSWORD'];
    cBANKCODE = json['C_BANK_CODE'];
    cRECEIVEBANKACCOUNT = json['C_RECEIVE_BANK_ACCOUNT'];
    cSALEID = json['C_SALE_ID'];
    cANHMATTRUOC = json['C_ANH_MAT_TRUOC'];
    cANHMATSAU = json['C_ANH_MAT_SAU'];
    cANHCHANDUNG = json['C_ANH_CHAN_DUNG'];
    cANHCHUKY = json['C_ANH_CHU_KY'];
    cPASSWORD = json['C_PASSWORD'];
    cOPENMARGIN = json['C_OPEN_MARGIN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['C_CARD_ID'] = this.cCARDID;
    data['C_FULL_NAME'] = this.cFULLNAME;
    data['C_CUST_BIRTH_DAY'] = this.cCUSTBIRTHDAY;
    data['C_ISSUE_DATE'] = this.cISSUEDATE;
    data['C_ISSUE_EXPIRE'] = this.cISSUEEXPIRE;
    data['C_ISSUE_PLACE'] = this.cISSUEPLACE;
    data['C_GENDER'] = this.cGENDER;
    data['C_PROVINCE'] = this.cPROVINCE;
    data['C_ADDRESS'] = this.cADDRESS;
    data['C_CONTACT_ADDRESS'] = this.cCONTACTADDRESS;
    data['C_MOBILE'] = this.cMOBILE;
    data['C_EMAIL'] = this.cEMAIL;
    data['C_MOBILE_TRADING_PASSWORD'] = this.cMOBILETRADINGPASSWORD;
    data['C_BANK_CODE'] = this.cBANKCODE;
    data['C_RECEIVE_BANK_ACCOUNT'] = this.cRECEIVEBANKACCOUNT;
    data['C_SALE_ID'] = this.cSALEID;
    data['C_ANH_MAT_TRUOC'] = this.cANHMATTRUOC;
    data['C_ANH_MAT_SAU'] = this.cANHMATSAU;
    data['C_ANH_CHAN_DUNG'] = this.cANHCHANDUNG;
    data['C_ANH_CHU_KY'] = this.cANHCHUKY;
    data['C_PASSWORD'] = this.cPASSWORD;
    data['C_OPEN_MARGIN'] = this.cOPENMARGIN;
    return data;
  }
}
