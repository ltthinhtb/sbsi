class StockInfo {
  int? id;
  String? sym;
  num? c;
  num? f;
  num? r;
  num? lastPrice;
  int? lastVolume;
  int? lot;
  String? ot;
  String? cl;
  String? avePrice;
  String? highPrice;
  String? lowPrice;
  String? fRoom;
  G? g1;
  G? g2;
  G? g3;
  G? g4;
  G? g5;
  G? g6;
  G? g7;
  String? mc;
  String? mr;
  int? fBVol;
  int? fSVolume;
  num? stepPrice;
  String? code;
  String? stockType;
  String? statusInfo;
  String? forceUse;

  StockInfo(
      {this.id,
      this.sym,
      this.c,
      this.f,
      this.r,
      this.lastPrice,
      this.lastVolume,
      this.lot,
      this.ot,
      this.cl,
      this.avePrice,
      this.highPrice,
      this.lowPrice,
      this.fRoom,
      this.g1,
      this.g2,
      this.g3,
      this.g4,
      this.g5,
      this.g6,
      this.g7,
      this.mc,
      this.mr,
      this.fBVol,
      this.fSVolume,
      this.stepPrice,
      this.code,
      this.stockType,
      this.statusInfo,
      this.forceUse});

  StockInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sym = json['sym'];
    c = json['c'];
    f = json['f'];
    r = json['r'];
    lastPrice = json['lastPrice'];
    lastVolume = json['lastVolume'];
    lot = json['lot'];
    ot = json['ot'].replaceAll(" ", "");
    cl = json['cl'];
    avePrice = json['avePrice'];
    highPrice = json['highPrice'];
    lowPrice = json['lowPrice'];
    fRoom = json['fRoom'];
    g1 = G.fromJson(json['g1']);
    g2 = G.fromJson(json['g2']);
    g3 = G.fromJson(json['g3']);
    g4 = G.fromJson(json['g4']);
    g5 = G.fromJson(json['g5']);
    g6 = G.fromJson(json['g6']);
    g7 = G.fromJson(json['g7']);
    mc = json['mc'];
    mr = json['mr'];
    fBVol = json['fBVol'];
    fSVolume = json['fSVolume'];
    stepPrice = json['stepPrice'];
    code = json['code'];
    stockType = json['stockType'];
    statusInfo = json['status_info'];
    forceUse = json['force_use'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sym'] = sym;
    data['c'] = c;
    data['f'] = f;
    data['r'] = r;
    data['lastPrice'] = lastPrice;
    data['lastVolume'] = lastVolume;
    data['lot'] = lot;
    data['ot'] = ot;
    data['cl'] = cl;
    data['avePrice'] = avePrice;
    data['highPrice'] = highPrice;
    data['lowPrice'] = lowPrice;
    data['fRoom'] = fRoom;
    data['g1'] = g1!.toJson();
    data['g2'] = g2!.toJson();
    data['g3'] = g3!.toJson();
    data['g4'] = g4!.toJson();
    data['g5'] = g5!.toJson();
    data['g6'] = g6!.toJson();
    data['g7'] = g7!.toJson();
    data['mc'] = mc;
    data['mr'] = mr;
    data['fBVol'] = fBVol;
    data['fSVolume'] = fSVolume;
    data['stepPrice'] = stepPrice;
    data['code'] = code;
    data['stockType'] = stockType;
    data['status_info'] = statusInfo;
    data['force_use'] = forceUse;
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

  String toJson() {
    return (price ?? "0") +
        "|" +
        (volumn != null ? volumn.toString() : "0") +
        "|" +
        (status ?? "e");
  }
}
