class Bank {
  String? pKBANK;
  String? cBANKCODE;
  String? cBANKNAME;
  String? cSHORTNAME;
  String? cENGLISHBANKNAME;
  String? cONLINEVPB;
  String? cBANKKEY;

  Bank(
      {this.pKBANK,
        this.cBANKCODE,
        this.cBANKNAME,
        this.cSHORTNAME,
        this.cENGLISHBANKNAME,
        this.cONLINEVPB,
        this.cBANKKEY});

  Bank.fromJson(Map<String, dynamic> json) {
    pKBANK = json['PK_BANK'];
    cBANKCODE = json['C_BANK_CODE'];
    cBANKNAME = json['C_BANK_NAME'];
    cSHORTNAME = json['C_SHORT_NAME'];
    cENGLISHBANKNAME = json['C_ENGLISH_BANK_NAME'];
    cONLINEVPB = json['C_ONLINE_VPB'];
    cBANKKEY = json['C_BANK_KEY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PK_BANK'] = this.pKBANK;
    data['C_BANK_CODE'] = this.cBANKCODE;
    data['C_BANK_NAME'] = this.cBANKNAME;
    data['C_SHORT_NAME'] = this.cSHORTNAME;
    data['C_ENGLISH_BANK_NAME'] = this.cENGLISHBANKNAME;
    data['C_ONLINE_VPB'] = this.cONLINEVPB;
    data['C_BANK_KEY'] = this.cBANKKEY;
    return data;
  }
}
