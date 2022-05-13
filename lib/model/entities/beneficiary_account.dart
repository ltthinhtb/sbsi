class BeneficiaryAccount {
  String? pKACCOUNTBEN;
  String? cACCOUNTCODE;
  String? cACCOUNTTYPE;
  String? cBANKCODE;
  String? cBANKNAME;
  String? cBANKACCOUNTCODE;
  String? cBANKACCOUNTNAME;
  String? cBANKADDRESS;
  String? cPROVINCENAME;
  String? cBANKBRANCH;
  num? cOWNERFLAG;
  String? cSUBBRANCHCODE;
  String? cSUBBRANCHNAME;
  String? cONLINECHANNEL;
  String? cBANKKEY;

  BeneficiaryAccount(
      {this.pKACCOUNTBEN,
        this.cACCOUNTCODE,
        this.cACCOUNTTYPE,
        this.cBANKCODE,
        this.cBANKNAME,
        this.cBANKACCOUNTCODE,
        this.cBANKACCOUNTNAME,
        this.cBANKADDRESS,
        this.cPROVINCENAME,
        this.cBANKBRANCH,
        this.cOWNERFLAG,
        this.cSUBBRANCHCODE,
        this.cSUBBRANCHNAME,
        this.cONLINECHANNEL,
        this.cBANKKEY});

  BeneficiaryAccount.fromJson(Map<String, dynamic> json) {
    pKACCOUNTBEN = json['PK_ACCOUNT_BEN'];
    cACCOUNTCODE = json['C_ACCOUNT_CODE'];
    cACCOUNTTYPE = json['C_ACCOUNT_TYPE'];
    cBANKCODE = json['C_BANK_CODE'];
    cBANKNAME = json['C_BANK_NAME'];
    cBANKACCOUNTCODE = json['C_BANK_ACCOUNT_CODE'];
    cBANKACCOUNTNAME = json['C_BANK_ACCOUNT_NAME'];
    cBANKADDRESS = json['C_BANK_ADDRESS'];
    cPROVINCENAME = json['C_PROVINCE_NAME'];
    cBANKBRANCH = json['C_BANK_BRANCH'];
    cOWNERFLAG = json['C_OWNER_FLAG'];
    cSUBBRANCHCODE = json['C_SUB_BRANCH_CODE'];
    cSUBBRANCHNAME = json['C_SUB_BRANCH_NAME'];
    cONLINECHANNEL = json['C_ONLINE_CHANNEL'];
    cBANKKEY = json['C_BANK_KEY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PK_ACCOUNT_BEN'] = this.pKACCOUNTBEN;
    data['C_ACCOUNT_CODE'] = this.cACCOUNTCODE;
    data['C_ACCOUNT_TYPE'] = this.cACCOUNTTYPE;
    data['C_BANK_CODE'] = this.cBANKCODE;
    data['C_BANK_NAME'] = this.cBANKNAME;
    data['C_BANK_ACCOUNT_CODE'] = this.cBANKACCOUNTCODE;
    data['C_BANK_ACCOUNT_NAME'] = this.cBANKACCOUNTNAME;
    data['C_BANK_ADDRESS'] = this.cBANKADDRESS;
    data['C_PROVINCE_NAME'] = this.cPROVINCENAME;
    data['C_BANK_BRANCH'] = this.cBANKBRANCH;
    data['C_OWNER_FLAG'] = this.cOWNERFLAG;
    data['C_SUB_BRANCH_CODE'] = this.cSUBBRANCHCODE;
    data['C_SUB_BRANCH_NAME'] = this.cSUBBRANCHNAME;
    data['C_ONLINE_CHANNEL'] = this.cONLINECHANNEL;
    data['C_BANK_KEY'] = this.cBANKKEY;
    return data;
  }
}
