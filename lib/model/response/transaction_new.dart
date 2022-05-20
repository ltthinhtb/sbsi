import 'package:flutter/material.dart';
import 'package:sbsi/common/app_colors.dart';

class TransactionNew {
  List<Content>? data1;
  List<Transaction>? data2;

  TransactionNew({this.data1, this.data2});

  TransactionNew.fromJson(Map<String, dynamic> json) {
    if (json['data1'] != null) {
      data1 = <Content>[];
      json['data1'].forEach((v) {
        data1!.add(new Content.fromJson(v));
      });
    }
    if (json['data2'] != null) {
      data2 = <Transaction>[];
      json['data2'].forEach((v) {
        data2!.add(new Transaction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data1 != null) {
      data['data1'] = this.data1!.map((v) => v.toJson()).toList();
    }
    if (this.data2 != null) {
      data['data2'] = this.data2!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Content {
  String? cACCOUNTCODE;
  String? cACCOUNTNAME;
  num? cCASHFISRTBALANCE;
  num? cCASHCLOSEBALANCE;
  num? cCASHBLOCK;

  Content(
      {this.cACCOUNTCODE,
      this.cACCOUNTNAME,
      this.cCASHFISRTBALANCE,
      this.cCASHCLOSEBALANCE,
      this.cCASHBLOCK});

  Content.fromJson(Map<String, dynamic> json) {
    cACCOUNTCODE = json['C_ACCOUNT_CODE'];
    cACCOUNTNAME = json['C_ACCOUNT_NAME'];
    cCASHFISRTBALANCE = json['C_CASH_FISRT_BALANCE'];
    cCASHCLOSEBALANCE = json['C_CASH_CLOSE_BALANCE'];
    cCASHBLOCK = json['C_CASH_BLOCK'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['C_ACCOUNT_CODE'] = this.cACCOUNTCODE;
    data['C_ACCOUNT_NAME'] = this.cACCOUNTNAME;
    data['C_CASH_FISRT_BALANCE'] = this.cCASHFISRTBALANCE;
    data['C_CASH_CLOSE_BALANCE'] = this.cCASHCLOSEBALANCE;
    data['C_CASH_BLOCK'] = this.cCASHBLOCK;
    return data;
  }
}

class Transaction {
  String? cACCOUNTCODE;
  String? cTRANSACTIONDATE;
  String? cTRANSACTIONNO;
  num? cCASHIN;
  num? cCASHOUT;
  String? cCONTENT;
  num? cORDER;

  num get balancerEnd {
    if (cCASHIN == null) return 0;
    if (cCASHOUT == null) return cCASHIN!;
    return cCASHIN! - cCASHOUT!;
  }

  bool get checkIncrease => balancerEnd > 0 ? true : false;

  Color get color => checkIncrease ? AppColors.active : AppColors.deActive;

  Transaction(
      {this.cACCOUNTCODE,
      this.cTRANSACTIONDATE,
      this.cTRANSACTIONNO,
      this.cCASHIN,
      this.cCASHOUT,
      this.cCONTENT,
      this.cORDER});

  Transaction.fromJson(Map<String, dynamic> json) {
    cACCOUNTCODE = json['C_ACCOUNT_CODE'];
    cTRANSACTIONDATE = json['C_TRANSACTION_DATE'];
    cTRANSACTIONNO = json['C_TRANSACTION_NO'];
    cCASHIN = json['C_CASH_IN'];
    cCASHOUT = json['C_CASH_OUT'];
    cCONTENT = json['C_CONTENT'];
    cORDER = json['C_ORDER'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['C_ACCOUNT_CODE'] = this.cACCOUNTCODE;
    data['C_TRANSACTION_DATE'] = this.cTRANSACTIONDATE;
    data['C_TRANSACTION_NO'] = this.cTRANSACTIONNO;
    data['C_CASH_IN'] = this.cCASHIN;
    data['C_CASH_OUT'] = this.cCASHOUT;
    data['C_CONTENT'] = this.cCONTENT;
    data['C_ORDER'] = this.cORDER;
    return data;
  }
}
