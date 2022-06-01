class GetAccountInfo {
  String? pKCUSTCUSTOMER;
  String? cBRANCHCODE;
  String? cSUBBRANCHCODE;
  String? cMARKETINGID;
  String? cMKTNAME;
  String? cCUSTOMERCODE;
  String? cCARDIDTYPE;
  String? cCARDID;
  String? cIDISSUEDATE;
  String? cIDEXPIREDATE;
  String? cIDISSUEPLACE;
  String? cCUSTOMERTYPE;
  String? cTAXCODE;
  String? cNATIONALCODE;
  String? cCUSTFULLNAME;
  String? cCUSTGENDER;
  String? cCUSTBIRTHDAY;
  String? cCUSTBIRTHPLACE;
  num? cCUSTLIVEINVIETNAM;
  String? cCUSTEMAIL;
  String? cCUSTMOBILE;
  String? cCUSTTEL;
  String? cCONTACTADDRESS;
  String? cCUSTRESEDENCEADDRESS;
  String? cPROVINCE;
  String? cAUTHENSIGN;
  String? cFRONTCARD;
  String? cBACKCARD;
  String? cSIGNIMG;
  String? cFACEIMG;
  num? cINTERNETFLAG;
  num? cPHONEFLAG;
  num? cMARGINFLAG;

  String get address {
    if(cCONTACTADDRESS == "null"){
      return "";
    }
    return cCONTACTADDRESS ?? "";
  }

  String get email {
    if(cCUSTEMAIL == "null"){
      return "";
    }
    return cCUSTEMAIL ?? "";
  }

  GetAccountInfo(
      {this.pKCUSTCUSTOMER,
      this.cBRANCHCODE,
      this.cSUBBRANCHCODE,
      this.cMARKETINGID,
      this.cMKTNAME,
      this.cCUSTOMERCODE,
      this.cCARDIDTYPE,
      this.cCARDID,
      this.cIDISSUEDATE,
      this.cIDEXPIREDATE,
      this.cIDISSUEPLACE,
      this.cCUSTOMERTYPE,
      this.cTAXCODE,
      this.cNATIONALCODE,
      this.cCUSTFULLNAME,
      this.cCUSTGENDER,
      this.cCUSTBIRTHDAY,
      this.cCUSTBIRTHPLACE,
      this.cCUSTLIVEINVIETNAM,
      this.cCUSTEMAIL,
      this.cCUSTMOBILE,
      this.cCUSTTEL,
      this.cCONTACTADDRESS,
      this.cCUSTRESEDENCEADDRESS,
      this.cPROVINCE,
      this.cAUTHENSIGN,
      this.cFRONTCARD,
      this.cBACKCARD,
      this.cSIGNIMG,
      this.cFACEIMG,
      this.cINTERNETFLAG,
      this.cPHONEFLAG,
      this.cMARGINFLAG});

  GetAccountInfo.fromJson(Map<String, dynamic> json) {
    pKCUSTCUSTOMER = json['PK_CUST_CUSTOMER'];
    cBRANCHCODE = json['C_BRANCH_CODE'];
    cSUBBRANCHCODE = json['C_SUB_BRANCH_CODE'];
    cMARKETINGID = json['C_MARKETING_ID'];
    cMKTNAME = json['C_MKT_NAME'];
    cCUSTOMERCODE = json['C_CUSTOMER_CODE'];
    cCARDIDTYPE = json['C_CARD_ID_TYPE'];
    cCARDID = json['C_CARD_ID'];
    cIDISSUEDATE = json['C_ID_ISSUE_DATE'];
    cIDEXPIREDATE = json['C_ID_EXPIRE_DATE'];
    cIDISSUEPLACE = json['C_ID_ISSUE_PLACE'];
    cCUSTOMERTYPE = json['C_CUSTOMER_TYPE'];
    cTAXCODE = json['C_TAX_CODE'];
    cNATIONALCODE = json['C_NATIONAL_CODE'];
    cCUSTFULLNAME = json['C_CUST_FULL_NAME'];
    cCUSTGENDER = json['C_CUST_GENDER'];
    cCUSTBIRTHDAY = json['C_CUST_BIRTH_DAY'];
    cCUSTBIRTHPLACE = json['C_CUST_BIRTH_PLACE'];
    cCUSTLIVEINVIETNAM = json['C_CUST_LIVE_IN_VIETNAM'];
    cCUSTEMAIL = json['C_CUST_EMAIL'];
    cCUSTMOBILE = json['C_CUST_MOBILE'];
    cCUSTTEL = json['C_CUST_TEL'];
    cCONTACTADDRESS = json['C_CONTACT_ADDRESS'];
    cCUSTRESEDENCEADDRESS = json['C_CUST_RESEDENCE_ADDRESS'];
    cPROVINCE = json['C_PROVINCE'];
    cAUTHENSIGN = json['C_AUTHEN_SIGN'];
    cFRONTCARD = json['C_FRONT_CARD'];
    cBACKCARD = json['C_BACK_CARD'];
    cSIGNIMG = json['C_SIGN_IMG'];
    cFACEIMG = json['C_FACE_IMG'];
    cINTERNETFLAG = json['C_INTERNET_FLAG'];
    cPHONEFLAG = json['C_PHONE_FLAG'];
    cMARGINFLAG = json['C_MARGIN_FLAG'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PK_CUST_CUSTOMER'] = this.pKCUSTCUSTOMER;
    data['C_BRANCH_CODE'] = this.cBRANCHCODE;
    data['C_SUB_BRANCH_CODE'] = this.cSUBBRANCHCODE;
    data['C_MARKETING_ID'] = this.cMARKETINGID;
    data['C_MKT_NAME'] = this.cMKTNAME;
    data['C_CUSTOMER_CODE'] = this.cCUSTOMERCODE;
    data['C_CARD_ID_TYPE'] = this.cCARDIDTYPE;
    data['C_CARD_ID'] = this.cCARDID;
    data['C_ID_ISSUE_DATE'] = this.cIDISSUEDATE;
    data['C_ID_EXPIRE_DATE'] = this.cIDEXPIREDATE;
    data['C_ID_ISSUE_PLACE'] = this.cIDISSUEPLACE;
    data['C_CUSTOMER_TYPE'] = this.cCUSTOMERTYPE;
    data['C_TAX_CODE'] = this.cTAXCODE;
    data['C_NATIONAL_CODE'] = this.cNATIONALCODE;
    data['C_CUST_FULL_NAME'] = this.cCUSTFULLNAME;
    data['C_CUST_GENDER'] = this.cCUSTGENDER;
    data['C_CUST_BIRTH_DAY'] = this.cCUSTBIRTHDAY;
    data['C_CUST_BIRTH_PLACE'] = this.cCUSTBIRTHPLACE;
    data['C_CUST_LIVE_IN_VIETNAM'] = this.cCUSTLIVEINVIETNAM;
    data['C_CUST_EMAIL'] = this.cCUSTEMAIL;
    data['C_CUST_MOBILE'] = this.cCUSTMOBILE;
    data['C_CUST_TEL'] = this.cCUSTTEL;
    data['C_CONTACT_ADDRESS'] = this.cCONTACTADDRESS;
    data['C_CUST_RESEDENCE_ADDRESS'] = this.cCUSTRESEDENCEADDRESS;
    data['C_PROVINCE'] = this.cPROVINCE;
    data['C_AUTHEN_SIGN'] = this.cAUTHENSIGN;
    data['C_FRONT_CARD'] = this.cFRONTCARD;
    data['C_BACK_CARD'] = this.cBACKCARD;
    data['C_SIGN_IMG'] = this.cSIGNIMG;
    data['C_FACE_IMG'] = this.cFACEIMG;
    data['C_INTERNET_FLAG'] = this.cINTERNETFLAG;
    data['C_PHONE_FLAG'] = this.cPHONEFLAG;
    data['C_MARGIN_FLAG'] = this.cMARGINFLAG;
    return data;
  }
}
