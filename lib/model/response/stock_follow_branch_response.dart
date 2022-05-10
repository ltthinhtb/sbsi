import 'package:flutter/material.dart';

import '../../utils/stock_utils.dart';

class StockBranchResponse {
  int? rc;
  String? rs;
  List<StockBranchData>? data;

  List<StockBranch> get stockData {
    List<StockBranch> stockData = [];
    if (data == null) return [];
    int length = data!.length > 10 ? 10 : data!.length;
    for (int i = 0; i < length; i++) {
      List<StockBranch> stockBranch = data![i].stocks != null
          ? (data![i].stocks!.length >= 10
              ? data![i].stocks!.sublist(0, 10)
              : data![i].stocks!)
          : [];
      stockData.addAll(stockBranch);
    }
    return stockData;
  }

  StockBranchResponse({this.rc, this.rs, this.data});

  StockBranchResponse.fromJson(Map<String, dynamic> json) {
    rc = json['rc'];
    rs = json['rs'];
    if (json['data'] != null) {
      data = <StockBranchData>[];
      json['data'].forEach((v) {
        data!.add(new StockBranchData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rc'] = this.rc;
    data['rs'] = this.rs;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StockBranchData {
  String? iNDUSTRY;
  int? tOTALKLGD;
  List<StockBranch>? stocks;

  StockBranchData({this.iNDUSTRY, this.tOTALKLGD, this.stocks});

  StockBranchData.fromJson(Map<String, dynamic> json) {
    iNDUSTRY = json['INDUSTRY'];
    tOTALKLGD = json['TOTAL_KLGD'];
    if (json['stocks'] != null) {
      stocks = <StockBranch>[];
      json['stocks'].forEach((v) {
        stocks!.add(new StockBranch.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['INDUSTRY'] = this.iNDUSTRY;
    data['TOTAL_KLGD'] = this.tOTALKLGD;
    if (this.stocks != null) {
      data['stocks'] = this.stocks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StockBranch {
  String? sTOCKCODE;
  num? vHTT;
  String? sTOCKNAME;
  String? iNDUSTRY;
  String? sECONDINDUSTRY;
  num? dEVIEND;
  num? gTGD;
  num? pERCENTCHANGE;
  num? uPDATEDTIME;
  num? cHANGE;
  String? cOLOR;
  String? qEPS;
  String? qPE;
  String? qPB;
  String? qROE;
  String? qROA;
  dynamic bETA;
  num? kLGD;
  num? lASTPRICE;
  num? iNTERESTED;
  String? cHARTNOTIME;
  String? cATID;

  Color get color => StockUtil.itemColorWithColor(cOLOR ?? "");

  StockBranch(
      {this.sTOCKCODE,
      this.vHTT,
      this.sTOCKNAME,
      this.iNDUSTRY,
      this.sECONDINDUSTRY,
      this.dEVIEND,
      this.gTGD,
      this.pERCENTCHANGE,
      this.uPDATEDTIME,
      this.cHANGE,
      this.cOLOR,
      this.qEPS,
      this.qPE,
      this.qPB,
      this.qROE,
      this.qROA,
      this.bETA,
      this.kLGD,
      this.lASTPRICE,
      this.iNTERESTED,
      this.cHARTNOTIME,
      this.cATID});

  StockBranch.fromJson(Map<String, dynamic> json) {
    sTOCKCODE = json['STOCK_CODE'];
    vHTT = json['VHTT'];
    sTOCKNAME = json['STOCK_NAME'];
    iNDUSTRY = json['INDUSTRY'];
    sECONDINDUSTRY = json['SECOND_INDUSTRY'];
    dEVIEND = json['DEVIEND'];
    gTGD = json['GTGD'];
    pERCENTCHANGE = json['PERCENT_CHANGE'];
    uPDATEDTIME = json['UPDATED_TIME'];
    cHANGE = json['CHANGE'];
    cOLOR = json['COLOR'];
    qEPS = json['Q_EPS'];
    qPE = json['Q_PE'];
    qPB = json['Q_PB'];
    qROE = json['Q_ROE'];
    qROA = json['Q_ROA'];
    bETA = json['BETA'];
    kLGD = json['KLGD'];
    lASTPRICE = json['LAST_PRICE'];
    iNTERESTED = json['INTERESTED'];
    cHARTNOTIME = json['CHART_NO_TIME'];
    cATID = json['CATID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STOCK_CODE'] = this.sTOCKCODE;
    data['VHTT'] = this.vHTT;
    data['STOCK_NAME'] = this.sTOCKNAME;
    data['INDUSTRY'] = this.iNDUSTRY;
    data['SECOND_INDUSTRY'] = this.sECONDINDUSTRY;
    data['DEVIEND'] = this.dEVIEND;
    data['GTGD'] = this.gTGD;
    data['PERCENT_CHANGE'] = this.pERCENTCHANGE;
    data['UPDATED_TIME'] = this.uPDATEDTIME;
    data['CHANGE'] = this.cHANGE;
    data['COLOR'] = this.cOLOR;
    data['Q_EPS'] = this.qEPS;
    data['Q_PE'] = this.qPE;
    data['Q_PB'] = this.qPB;
    data['Q_ROE'] = this.qROE;
    data['Q_ROA'] = this.qROA;
    data['BETA'] = this.bETA;
    data['KLGD'] = this.kLGD;
    data['LAST_PRICE'] = this.lASTPRICE;
    data['INTERESTED'] = this.iNTERESTED;
    data['CHART_NO_TIME'] = this.cHARTNOTIME;
    data['CATID'] = this.cATID;
    return data;
  }
}
