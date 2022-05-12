class CashAccount {
  String? cCUSTOMERCODE;
  String? cACCOUNTCODE;
  String? cACCOUNTNAME;
  String? cACCOUNTBRANCHCODE;
  String? cBRANCHNAME;
  String? cBRANCHNAMEEN;
  String? cACCOUNTSUBBRANCHCODE;
  String? cMARKETINGID;
  String? cMARKETINGNAME;
  String? cACCOUNTRELATIONTYPE;
  String? cACCOUNTTYPENAME;
  String? cACCOUNTTYPENAMEEN;
  num? cCANBUY;
  num? cCANSELL;
  num? cCASHBALANCE;
  num? cCASHDEPOSITIM;
  num? cCASHDEBALANCE;
  num? cEEFLAG;
  num? cCASHBALANCEEE;
  String? cCARDID;
  String? cISSUEDATE;
  String? cEXPIREDATE;
  String? cIDISSUEPLACE;
  String? cCUSTOMERTYPE;
  String? cCUSTOMERTYPENAME;
  String? cCUSTOMERTYPENAMEEN;
  String? cCUSTEMAIL;
  String? cCUSTMOBILE;
  String? cCUSTTEL;
  String? cCONTACTADDRESS;

  CashAccount(
      {this.cCUSTOMERCODE,
        this.cACCOUNTCODE,
        this.cACCOUNTNAME,
        this.cACCOUNTBRANCHCODE,
        this.cBRANCHNAME,
        this.cBRANCHNAMEEN,
        this.cACCOUNTSUBBRANCHCODE,
        this.cMARKETINGID,
        this.cMARKETINGNAME,
        this.cACCOUNTRELATIONTYPE,
        this.cACCOUNTTYPENAME,
        this.cACCOUNTTYPENAMEEN,
        this.cCANBUY,
        this.cCANSELL,
        this.cCASHBALANCE,
        this.cCASHDEPOSITIM,
        this.cCASHDEBALANCE,
        this.cEEFLAG,
        this.cCASHBALANCEEE,
        this.cCARDID,
        this.cISSUEDATE,
        this.cEXPIREDATE,
        this.cIDISSUEPLACE,
        this.cCUSTOMERTYPE,
        this.cCUSTOMERTYPENAME,
        this.cCUSTOMERTYPENAMEEN,
        this.cCUSTEMAIL,
        this.cCUSTMOBILE,
        this.cCUSTTEL,
        this.cCONTACTADDRESS});

  CashAccount.fromJson(Map<String, dynamic> json) {
    cCUSTOMERCODE = json['C_CUSTOMER_CODE'];
    cACCOUNTCODE = json['C_ACCOUNT_CODE'];
    cACCOUNTNAME = json['C_ACCOUNT_NAME'];
    cACCOUNTBRANCHCODE = json['C_ACCOUNT_BRANCH_CODE'];
    cBRANCHNAME = json['C_BRANCH_NAME'];
    cBRANCHNAMEEN = json['C_BRANCH_NAME_EN'];
    cACCOUNTSUBBRANCHCODE = json['C_ACCOUNT_SUB_BRANCH_CODE'];
    cMARKETINGID = json['C_MARKETING_ID'];
    cMARKETINGNAME = json['C_MARKETING_NAME'];
    cACCOUNTRELATIONTYPE = json['C_ACCOUNT_RELATION_TYPE'];
    cACCOUNTTYPENAME = json['C_ACCOUNT_TYPE_NAME'];
    cACCOUNTTYPENAMEEN = json['C_ACCOUNT_TYPE_NAME_EN'];
    cCANBUY = json['C_CAN_BUY'];
    cCANSELL = json['C_CAN_SELL'];
    cCASHBALANCE = json['C_CASH_BALANCE'];
    cCASHDEPOSITIM = json['C_CASH_DEPOSIT_IM'];
    cCASHDEBALANCE = json['C_CASH_DE_BALANCE'];
    cEEFLAG = json['C_EE_FLAG'];
    cCASHBALANCEEE = json['C_CASH_BALANCE_EE'];
    cCARDID = json['C_CARD_ID'];
    cISSUEDATE = json['C_ISSUE_DATE'];
    cEXPIREDATE = json['C_EXPIRE_DATE'];
    cIDISSUEPLACE = json['C_ID_ISSUE_PLACE'];
    cCUSTOMERTYPE = json['C_CUSTOMER_TYPE'];
    cCUSTOMERTYPENAME = json['C_CUSTOMER_TYPE_NAME'];
    cCUSTOMERTYPENAMEEN = json['C_CUSTOMER_TYPE_NAME_EN'];
    cCUSTEMAIL = json['C_CUST_EMAIL'];
    cCUSTMOBILE = json['C_CUST_MOBILE'];
    cCUSTTEL = json['C_CUST_TEL'];
    cCONTACTADDRESS = json['C_CONTACT_ADDRESS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['C_CUSTOMER_CODE'] = this.cCUSTOMERCODE;
    data['C_ACCOUNT_CODE'] = this.cACCOUNTCODE;
    data['C_ACCOUNT_NAME'] = this.cACCOUNTNAME;
    data['C_ACCOUNT_BRANCH_CODE'] = this.cACCOUNTBRANCHCODE;
    data['C_BRANCH_NAME'] = this.cBRANCHNAME;
    data['C_BRANCH_NAME_EN'] = this.cBRANCHNAMEEN;
    data['C_ACCOUNT_SUB_BRANCH_CODE'] = this.cACCOUNTSUBBRANCHCODE;
    data['C_MARKETING_ID'] = this.cMARKETINGID;
    data['C_MARKETING_NAME'] = this.cMARKETINGNAME;
    data['C_ACCOUNT_RELATION_TYPE'] = this.cACCOUNTRELATIONTYPE;
    data['C_ACCOUNT_TYPE_NAME'] = this.cACCOUNTTYPENAME;
    data['C_ACCOUNT_TYPE_NAME_EN'] = this.cACCOUNTTYPENAMEEN;
    data['C_CAN_BUY'] = this.cCANBUY;
    data['C_CAN_SELL'] = this.cCANSELL;
    data['C_CASH_BALANCE'] = this.cCASHBALANCE;
    data['C_CASH_DEPOSIT_IM'] = this.cCASHDEPOSITIM;
    data['C_CASH_DE_BALANCE'] = this.cCASHDEBALANCE;
    data['C_EE_FLAG'] = this.cEEFLAG;
    data['C_CASH_BALANCE_EE'] = this.cCASHBALANCEEE;
    data['C_CARD_ID'] = this.cCARDID;
    data['C_ISSUE_DATE'] = this.cISSUEDATE;
    data['C_EXPIRE_DATE'] = this.cEXPIREDATE;
    data['C_ID_ISSUE_PLACE'] = this.cIDISSUEPLACE;
    data['C_CUSTOMER_TYPE'] = this.cCUSTOMERTYPE;
    data['C_CUSTOMER_TYPE_NAME'] = this.cCUSTOMERTYPENAME;
    data['C_CUSTOMER_TYPE_NAME_EN'] = this.cCUSTOMERTYPENAMEEN;
    data['C_CUST_EMAIL'] = this.cCUSTEMAIL;
    data['C_CUST_MOBILE'] = this.cCUSTMOBILE;
    data['C_CUST_TEL'] = this.cCUSTTEL;
    data['C_CONTACT_ADDRESS'] = this.cCONTACTADDRESS;
    return data;
  }
}
