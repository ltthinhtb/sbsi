import 'dart:async';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';

import 'stock_socket.dart';

class StockData {
  int? id;
  String? sym;
  String? mc;
  num? c;
  num? f;
  num? r;
  num? lastPrice;
  num? lastVolume;
  num? lot; //khối lượng
  String? ot;
  String? changePc;
  String? avePrice;
  String? highPrice;
  String? lowPrice;
  String? fBVol;
  String? fBValue;
  String? fSVolume;
  String? fSValue;
  String? fRoom;
  G? g1;
  G? g2;
  G? g3;
  G? g4;
  G? g5;
  G? g6;
  G? g7;
  String? mp;
  Color? color;

  final mapColorChange = <String, dynamic>{
    "lastPrice": false,
    "lastVolume": false,
  }.obs;

  void updateFlashColor(bool updateLP, bool updateLV) {
    /// update màu của last price
    mapColorChange['lastPrice'] = updateLP;
    if (mapColorChange['lastPrice'] == true) {
      Timer.periodic(const Duration(milliseconds: 500), (timer) {
        mapColorChange['lastPrice'] = false;
      });
    }

    /// update màu của last volume
    mapColorChange['lastVolume'] = updateLV;
    if (mapColorChange['lastVolume'] == true) {
      Timer.periodic(const Duration(milliseconds: 500), (timer) {
        mapColorChange['lastVolume'] = false;
      });
    }
  }

  StockData(
      {this.id,
      this.sym,
      this.mc,
      this.c,
      this.f,
      this.r,
      this.lastPrice,
      this.lastVolume,
      this.lot,
      this.ot,
      this.changePc,
      this.avePrice,
      this.highPrice,
      this.lowPrice,
      this.fBVol,
      this.fBValue,
      this.fSVolume,
      this.fSValue,
      this.fRoom,
      this.g1,
      this.g2,
      this.g3,
      this.g4,
      this.g5,
      this.g6,
      this.g7,
      this.mp,
      this.color});

  StockData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sym = json['sym'];
    mc = json['mc'];
    c = json['c'];
    f = json['f'];
    r = json['r'];
    lastPrice = json['lastPrice'] == 0 ? json['r'] : json['lastPrice'];
    lastVolume = json['lastVolume'];
    lot = json['lot'];
    ot = json['ot'];
    changePc = json['changePc'];
    avePrice = json['avePrice'];
    highPrice = json['highPrice'];
    lowPrice = json['lowPrice'];
    fBVol = json['fBVol'];
    fBValue = json['fBValue'];
    fSVolume = json['fSVolume'];
    fSValue = json['fSValue'];
    fRoom = json['fRoom'];
    g1 = G.fromJson(json['g1']);
    g2 = G.fromJson(json['g2']);
    g3 = G.fromJson(json['g3']);
    g4 = G.fromJson(json['g4']);
    g5 = G.fromJson(json['g5']);
    g6 = G.fromJson(json['g6']);
    g7 = G.fromJson(json['g7']);
    mp = json['mp'];
    color = lastPrice == c // sàn
        ? AppColors.flow
        : lastPrice == f //trần
            ? AppColors.primary
            : lastPrice! > r! // tham chiếu
                ? AppColors.increase
                : lastPrice! < r!
                    ? AppColors.decrease
                    : AppColors.yellow;
  }

  StockData copyWith(SocketStock socket) {
    bool updateLP = socket.lastPrice != lastPrice;
    bool updateLV = socket.lastVol != lastVolume;

    return StockData(
        id: socket.id?.toInt() ?? id,
        sym: socket.sym ?? sym,
        mc: mc,
        c: c,
        f: f,
        r: r,
        lastPrice: socket.lastPrice ?? lastPrice,
        lastVolume: socket.lastVol ?? lastVolume,
        lot: socket.totalVol ?? lot,
        // tổng
        ot: socket.change ?? ot,
        // % tăng giảm
        changePc: socket.changePc ?? socket.change,
        avePrice: avePrice,
        highPrice: highPrice,
        lowPrice: lowPrice,
        fBVol: fBVol,
        fBValue: fBValue,
        fSVolume: fSVolume,
        fSValue: fSValue,
        fRoom: fRoom,
        g1: g1,
        g2: g2,
        g3: g3,
        g4: g4,
        g5: g5,
        g6: g6,
        g7: g7,
        mp: mp,
        color: socket.cl == "i"
            ? AppColors.increase
            : socket.cl == "d"
                ? AppColors.decrease
                : AppColors.yellow)
      ..updateFlashColor(updateLP, updateLV);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sym'] = sym;
    data['mc'] = mc;
    data['c'] = c;
    data['f'] = f;
    data['r'] = r;
    data['lastPrice'] = lastPrice;
    data['lastVolume'] = lastVolume;
    data['lot'] = lot;
    data['ot'] = ot;
    data['changePc'] = changePc;
    data['avePrice'] = avePrice;
    data['highPrice'] = highPrice;
    data['lowPrice'] = lowPrice;
    data['fBVol'] = fBVol;
    data['fBValue'] = fBValue;
    data['fSVolume'] = fSVolume;
    data['fSValue'] = fSValue;
    data['fRoom'] = fRoom;
    data['g1'] = g1!.toJson();
    data['g2'] = g2!.toJson();
    data['g3'] = g3!.toJson();
    data['g4'] = g4!.toJson();
    data['g5'] = g5!.toJson();
    data['g6'] = g6!.toJson();
    data['g7'] = g7!.toJson();
    data['mp'] = mp;
    return data;
  }
}

class G {
  String? price;
  num? volumn;
  String? status;

  G({this.price, this.volumn, this.status});

  G.fromJson(String data) {
    if (data.isNotEmpty) {
      List<String> _data = data.split('|');
      // print(_data);
      price = _data[0];
      volumn = num.parse(_data[1]);
      status = _data[2];
    } else {
      price = "0.0";
      volumn = 0;
      status = "e";
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = price;
    data['volumn'] = volumn;
    data['status'] = status;
    return data;
  }
}
