import 'package:intl/intl.dart' as la;


class DebtAcc {
  String? cLOANID;
  String? cACCOUNTCODE;
  String? cBANKCODE;
  num? cLOANIN;
  num? cLOANOUT;
  num? cFEEIN;
  num? cFEEOUT;
  num? cLOAN;
  num? cFEE;
  num? cINTERESTRATE;
  String? cDELIVERDATE;
  String? cINTERESTDATE;
  String? cEXPIREDATE1;



  DateTime get deliverDate {
    var stringFormat = 'dd/MM/yyyy';
    var _dateString = cINTERESTDATE?.replaceAll("-", "/");
    var format = la.DateFormat(stringFormat);
    var date = format.parse(_dateString!);
    return date;
  }

  String get totalDate {
    return DateTime.now().difference(deliverDate).inDays.toString();
  }

  num get amountDebt {
    return cLOANIN! + cFEEIN!;
  }

  num get debtLoan {
    return cLOANIN! + cFEEIN! - cLOANOUT! - cFEEOUT!;
  }

  DebtAcc(
      {this.cLOANID,
      this.cACCOUNTCODE,
      this.cBANKCODE,
      this.cLOANIN,
      this.cLOANOUT,
      this.cFEEIN,
      this.cFEEOUT,
      this.cLOAN,
      this.cFEE,
      this.cINTERESTRATE,
      this.cDELIVERDATE,
      this.cINTERESTDATE,
      this.cEXPIREDATE1});

  DebtAcc.fromJson(Map<String, dynamic> json) {
    cLOANID = json['C_LOAN_ID'];
    cACCOUNTCODE = json['C_ACCOUNT_CODE'];
    cBANKCODE = json['C_BANK_CODE'];
    cLOANIN = json['C_LOAN_IN'];
    cLOANOUT = json['C_LOAN_OUT'];
    cFEEIN = json['C_FEE_IN'];
    cFEEOUT = json['C_FEE_OUT'];
    cLOAN = json['C_LOAN'];
    cFEE = json['C_FEE'];
    cINTERESTRATE = json['C_INTEREST_RATE'];
    cDELIVERDATE = json['C_DELIVER_DATE'];
    cINTERESTDATE = json['C_INTEREST_DATE'];
    cEXPIREDATE1 = json['C_EXPIRE_DATE1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['C_LOAN_ID'] = this.cLOANID;
    data['C_ACCOUNT_CODE'] = this.cACCOUNTCODE;
    data['C_BANK_CODE'] = this.cBANKCODE;
    data['C_LOAN_IN'] = this.cLOANIN;
    data['C_LOAN_OUT'] = this.cLOANOUT;
    data['C_FEE_IN'] = this.cFEEIN;
    data['C_FEE_OUT'] = this.cFEEOUT;
    data['C_LOAN'] = this.cLOAN;
    data['C_FEE'] = this.cFEE;
    data['C_INTEREST_RATE'] = this.cINTERESTRATE;
    data['C_DELIVER_DATE'] = this.cDELIVERDATE;
    data['C_INTEREST_DATE'] = this.cINTERESTDATE;
    data['C_EXPIRE_DATE1'] = this.cEXPIREDATE1;
    return data;
  }
}
