class Bank {
  String? pKBANK;
  String? cBANKCODE;
  String? cBANKNAME;
  String? cSHORTNAME;
  String? cENGLISHBANKNAME;
  String? cONLINEVPB;
  String? cBANKKEY;
  String? logo;

  Bank(
      {this.pKBANK,
      this.cBANKCODE,
      this.cBANKNAME,
      this.cSHORTNAME,
      this.cENGLISHBANKNAME,
      this.cONLINEVPB,
      this.cBANKKEY,
      this.logo});

  Bank.fromJson(Map<String, dynamic> json) {
    pKBANK = json['PK_BANK'];
    cBANKCODE = json['C_BANK_CODE'];
    cBANKNAME = json['C_BANK_NAME'];
    cSHORTNAME = json['C_SHORT_NAME'];
    cENGLISHBANKNAME = json['C_ENGLISH_BANK_NAME'];
    cONLINEVPB = json['C_ONLINE_VPB'];
    cBANKKEY = json['C_BANK_KEY'];
    logo = 'assets/bank/${cBANKCODE?.toUpperCase()}.png';
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

  Bank copyWith({
    String? pKBANK,
    String? cBANKCODE,
    String? cBANKNAME,
    String? cSHORTNAME,
    String? cENGLISHBANKNAME,
    String? cONLINEVPB,
    String? cBANKKEY,
    String? logo,
  }) {
    return Bank(
      pKBANK: pKBANK ?? this.pKBANK,
      cBANKCODE: cBANKCODE ?? this.cBANKCODE,
      cBANKNAME: cBANKNAME ?? this.cBANKNAME,
      cSHORTNAME: cSHORTNAME ?? this.cSHORTNAME,
      cENGLISHBANKNAME: cENGLISHBANKNAME ?? this.cENGLISHBANKNAME,
      cONLINEVPB: cONLINEVPB ?? this.cONLINEVPB,
      cBANKKEY: cBANKKEY ?? this.cBANKKEY,
      logo: logo ?? this.logo,
    );
  }
}
