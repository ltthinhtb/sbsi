import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/model/stock_data/stock_socket.dart';
import 'package:sbsi/utils/stock_color.dart';

class StockResponse {
  int? rc;
  String? rs;
  List<StockDataShort>? data;

  StockResponse({this.rc, this.rs, this.data});

  StockResponse.fromJson(Map<String, dynamic> json) {
    rc = json['rc'];
    rs = json['rs'];
    if (json['data'] != null) {
      data = <StockDataShort>[];
      json['data'].forEach((v) {
        data!.add(StockDataShort.fromJson(v));
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

class StockDataShort {
  String? stockCode;
  num? klgd;
  num? gtgd;
  String? stockName;
  num? change;
  num? percentChange;
  String? color;
  String? chart;
  num? price;

  StockDataShort(
      {this.stockCode,
      this.klgd,
      this.gtgd,
      this.stockName,
      this.change,
      this.percentChange,
      this.color,
      this.chart,
      this.price});

  StockDataShort copyWith(SocketStock socket) {
    return StockDataShort(
        change: double.parse(socket.change ?? '0.0'),
        chart: this.chart,
        color: socket.cl == "i"
            ? 'green'
            : socket.cl == "d"
                ? 'blue'
                : "yellow",
        percentChange: double.parse(socket.changePc ?? '0.0'),
        stockCode: socket.sym,
        stockName: this.stockName.toString(),
        price: socket.lastPrice,
        klgd: socket.totalVol,
        gtgd: this.gtgd);
  }

  List<dynamic> get listChart => jsonDecode(chart ?? "").map((e) {
        if (e is double)
          return e;
        else if (e is int) return e.toDouble();
      }).toList();

  StockPrice get stockPrice {
    if (this.color == 'green') {
      return StockPrice.increase;
    } else if (this.color == 'red') {
      return StockPrice.decrease;
    } else {
      return StockPrice.c;
    }
  }

  Color get colorStock {
    if (this.color == 'green') {
      return AppColors.increase;
    } else if (this.color == 'red') {
      return AppColors.decrease;
    } else if (this.color == 'blue') {
      return AppColors.floor;
    } else if (this.color == 'violet') {
      return AppColors.ceil;
    } else {
      return AppColors.yellow;
    }
  }

  StockDataShort.fromJson(Map<String, dynamic> json) {
    stockCode = json['STOCK_CODE'];
    klgd = json['KLGD'];
    gtgd = json['GTGD'];
    stockName = json['STOCK_NAME'];
    change = json['CHANGE'];
    percentChange = json['PERCENT_CHANGE'];
    color = json['COLOR'];
    chart = json['CHART'];
    price = json['PRICE'] ?? json['LAST_PRICE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STOCK_CODE'] = this.stockCode;
    data['KLGD'] = this.klgd;
    data['GTGD'] = this.gtgd;
    data['STOCK_NAME'] = this.stockName;
    data['CHANGE'] = this.change;
    data['PERCENT_CHANGE'] = this.percentChange;
    data['COLOR'] = this.color;
    data['CHART'] = this.chart;
    data['PRICE'] = this.price;
    data['LAST_PRICE'] = this.price;
    return data;
  }
}
