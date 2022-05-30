class FeeAdvanceWithdraw {
  num? cFEEMIN;
  double? cFEERATE;
  num? cFEEVALUE;
  num? cCASHVALUE;
  num? cCASHTOTAL;

  FeeAdvanceWithdraw(
      {this.cFEEMIN,
        this.cFEERATE,
        this.cFEEVALUE,
        this.cCASHVALUE,
        this.cCASHTOTAL});

  FeeAdvanceWithdraw.fromJson(Map<String, dynamic> json) {
    cFEEMIN = json['C_FEE_MIN'];
    cFEERATE = json['C_FEE_RATE'];
    cFEEVALUE = json['C_FEE_VALUE'];
    cCASHVALUE = json['C_CASH_VALUE'];
    cCASHTOTAL = json['C_CASH_TOTAL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['C_FEE_MIN'] = this.cFEEMIN;
    data['C_FEE_RATE'] = this.cFEERATE;
    data['C_FEE_VALUE'] = this.cFEEVALUE;
    data['C_CASH_VALUE'] = this.cCASHVALUE;
    data['C_CASH_TOTAL'] = this.cCASHTOTAL;
    return data;
  }
}
