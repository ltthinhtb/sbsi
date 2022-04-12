class AccountInfo {
  String? cSTORECODE;
  String? cBRANCHCODE;
  String? cSUBBRANCHCODE;
  String? cMARKETINGID;
  String? cCUSTOMERCODE;
  String? cDEPOSITCODE;
  String? cDCTERMCODE;
  String? cPOLICYCODE;
  String? cPOLICYNAME;
  String? cACCOUNTCODE;
  String? cACCOUNTNAME;
  String? cBIRTHDAY;
  String? cCREDITTYPENAME;
  String? cOPENDATE;
  String? cCLOSEDATE;
  String? cCOMMPACKAGE;
  String? cSTATUS;
  String? cACCOUNTSTATUSNAME;
  String? cCHANNEL;
  String? cCONTENT;
  String? cCARDIDTYPE;
  String? cCARDID;
  String? cISSUEDATE;
  String? cEXPIREDATE;
  String? cISSUEPLACE;
  String? cCUSTGENDER;
  String? cCUSTMOBILE;
  String? cCUSTEMAIL;
  String? cCONTACTADDRESS;

  AccountInfo(
      {this.cSTORECODE,
      this.cBRANCHCODE,
      this.cSUBBRANCHCODE,
      this.cMARKETINGID,
      this.cCUSTOMERCODE,
      this.cDEPOSITCODE,
      this.cDCTERMCODE,
      this.cPOLICYCODE,
      this.cPOLICYNAME,
      this.cACCOUNTCODE,
      this.cACCOUNTNAME,
      this.cBIRTHDAY,
      this.cCREDITTYPENAME,
      this.cOPENDATE,
      this.cCLOSEDATE,
      this.cCOMMPACKAGE,
      this.cSTATUS,
      this.cACCOUNTSTATUSNAME,
      this.cCHANNEL,
      this.cCONTENT,
      this.cCARDIDTYPE,
      this.cCARDID,
      this.cISSUEDATE,
      this.cEXPIREDATE,
      this.cISSUEPLACE,
      this.cCUSTGENDER,
      this.cCUSTMOBILE,
      this.cCUSTEMAIL,
      this.cCONTACTADDRESS});

  AccountInfo.fromJson(Map<String, dynamic> json) {
    cSTORECODE = json['C_STORE_CODE'];
    cBRANCHCODE = json['C_BRANCH_CODE'];
    cSUBBRANCHCODE = json['C_SUB_BRANCH_CODE'];
    cMARKETINGID = json['C_MARKETING_ID'];
    cCUSTOMERCODE = json['C_CUSTOMER_CODE'];
    cDEPOSITCODE = json['C_DEPOSIT_CODE'];
    cDCTERMCODE = json['C_DCTERM_CODE'];
    cPOLICYCODE = json['C_POLICY_CODE'];
    cPOLICYNAME = json['C_POLICY_NAME'];
    cACCOUNTCODE = json['C_ACCOUNT_CODE'];
    cACCOUNTNAME = json['C_ACCOUNT_NAME'];
    cBIRTHDAY = json['C_BIRTH_DAY'];
    cCREDITTYPENAME = json['C_CREDIT_TYPE_NAME'];
    cOPENDATE = json['C_OPEN_DATE'];
    cCLOSEDATE = json['C_CLOSE_DATE'];
    cCOMMPACKAGE = json['C_COMM_PACKAGE'];
    cSTATUS = json['C_STATUS'];
    cACCOUNTSTATUSNAME = json['C_ACCOUNT_STATUS_NAME'];
    cCHANNEL = json['C_CHANNEL'];
    cCONTENT = json['C_CONTENT'];
    cCARDIDTYPE = json['C_CARD_ID_TYPE'];
    cCARDID = json['C_CARD_ID'];
    cISSUEDATE = json['C_ISSUE_DATE'];
    cEXPIREDATE = json['C_EXPIRE_DATE'];
    cISSUEPLACE = json['C_ISSUE_PLACE'];
    cCUSTGENDER = json['C_CUST_GENDER'];
    cCUSTMOBILE = json['C_CUST_MOBILE'];
    cCUSTEMAIL = json['C_CUST_EMAIL'];
    cCONTACTADDRESS = json['C_CONTACT_ADDRESS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['C_STORE_CODE'] = cSTORECODE;
    data['C_BRANCH_CODE'] = cBRANCHCODE;
    data['C_SUB_BRANCH_CODE'] = cSUBBRANCHCODE;
    data['C_MARKETING_ID'] = cMARKETINGID;
    data['C_CUSTOMER_CODE'] = cCUSTOMERCODE;
    data['C_DEPOSIT_CODE'] = cDEPOSITCODE;
    data['C_DCTERM_CODE'] = cDCTERMCODE;
    data['C_POLICY_CODE'] = cPOLICYCODE;
    data['C_POLICY_NAME'] = cPOLICYNAME;
    data['C_ACCOUNT_CODE'] = cACCOUNTCODE;
    data['C_ACCOUNT_NAME'] = cACCOUNTNAME;
    data['C_BIRTH_DAY'] = cBIRTHDAY;
    data['C_CREDIT_TYPE_NAME'] = cCREDITTYPENAME;
    data['C_OPEN_DATE'] = cOPENDATE;
    data['C_CLOSE_DATE'] = cCLOSEDATE;
    data['C_COMM_PACKAGE'] = cCOMMPACKAGE;
    data['C_STATUS'] = cSTATUS;
    data['C_ACCOUNT_STATUS_NAME'] = cACCOUNTSTATUSNAME;
    data['C_CHANNEL'] = cCHANNEL;
    data['C_CONTENT'] = cCONTENT;
    data['C_CARD_ID_TYPE'] = cCARDIDTYPE;
    data['C_CARD_ID'] = cCARDID;
    data['C_ISSUE_DATE'] = cISSUEDATE;
    data['C_EXPIRE_DATE'] = cEXPIREDATE;
    data['C_ISSUE_PLACE'] = cISSUEPLACE;
    data['C_CUST_GENDER'] = cCUSTGENDER;
    data['C_CUST_MOBILE'] = cCUSTMOBILE;
    data['C_CUST_EMAIL'] = cCUSTEMAIL;
    data['C_CONTACT_ADDRESS'] = cCONTACTADDRESS;
    return data;
  }
}
