class ShareTransaction {
  String? cTRANSACTIONNO;
  String? cTRANSACTIONDATE;
  String? cDUEDATE;
  String? cACCOUNTCODE;
  String? cSHARECODE;
  String? cSHARESTATUS;
  String? cSTATUSNAME;
  num? cSHAREIN;
  num? cSHAREOUT;
  String? cCONTENT;

  ShareTransaction(
      {this.cTRANSACTIONNO,
        this.cTRANSACTIONDATE,
        this.cDUEDATE,
        this.cACCOUNTCODE,
        this.cSHARECODE,
        this.cSHARESTATUS,
        this.cSTATUSNAME,
        this.cSHAREIN,
        this.cSHAREOUT,
        this.cCONTENT});

  ShareTransaction.fromJson(Map<String, dynamic> json) {
    cTRANSACTIONNO = json['C_TRANSACTION_NO'];
    cTRANSACTIONDATE = json['C_TRANSACTION_DATE'];
    cDUEDATE = json['C_DUE_DATE'];
    cACCOUNTCODE = json['C_ACCOUNT_CODE'];
    cSHARECODE = json['C_SHARE_CODE'];
    cSHARESTATUS = json['C_SHARE_STATUS'];
    cSTATUSNAME = json['C_STATUS_NAME'];
    cSHAREIN = json['C_SHARE_IN'];
    cSHAREOUT = json['C_SHARE_OUT'];
    cCONTENT = json['C_CONTENT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['C_TRANSACTION_NO'] = this.cTRANSACTIONNO;
    data['C_TRANSACTION_DATE'] = this.cTRANSACTIONDATE;
    data['C_DUE_DATE'] = this.cDUEDATE;
    data['C_ACCOUNT_CODE'] = this.cACCOUNTCODE;
    data['C_SHARE_CODE'] = this.cSHARECODE;
    data['C_SHARE_STATUS'] = this.cSHARESTATUS;
    data['C_STATUS_NAME'] = this.cSTATUSNAME;
    data['C_SHARE_IN'] = this.cSHAREIN;
    data['C_SHARE_OUT'] = this.cSHAREOUT;
    data['C_CONTENT'] = this.cCONTENT;
    return data;
  }
}
