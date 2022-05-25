class ParamsObject {
  String? type;
  String? cmd;
  var p;
  String? p1;
  String? p2;
  String? p3;
  String? p4;
  String? p5;
  String? p6;
  String? p7;
  String? p8;
  String? p9;
  String? p10;
  String? p11;
  String? p12;
  String? p13;
  String? p14;
  String? p15;
  String? pOther;

  //Order
  String? pin;
  String? orderType;

  //NewOrder
  String? account;
  String? side;
  String? symbol;
  int? volume;
  String? price;
  String? advance;
  String? refId;

  //ChangeOrder
  String? orderNo;
  int? nvol;
  String? nprice;

  //CancelOrder
  String? fisID;

  ParamsObject(
      {this.type,
      this.cmd,
      this.p,
      this.p1,
      this.p2,
      this.p3,
      this.p4,
      this.account,
      this.side,
      this.symbol,
      this.volume,
      this.price,
      this.advance,
      this.refId,
      this.pin,
      this.orderNo,
      this.orderType,
      this.nvol,
      this.nprice,
      this.fisID,
      this.p5,
      this.p6,
      this.p7,
      this.p8,
      this.p9,
      this.p10,
      this.p11,
      this.p12,
      this.p13,
      this.p14,
      this.p15,
      this.pOther});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (type != null) {
      data['type'] = type;
    }
    data['cmd'] = cmd;
    if (p != null) {
      data['p1'] = p;
    }
    if (p1 != null) {
      data['p1'] = p1;
    }
    if (p2 != null) {
      data['p2'] = p2;
    }

    if (p3 != null) {
      data['p3'] = p3;
    }
    if (p4 != null) {
      data['p4'] = p4;
    }
    if (p5 != null) {
      data['p5'] = p5;
    }
    if (p6 != null) {
      data['p6'] = p6;
    }
    if (p7 != null) {
      data['p7'] = p7;
    }
    if (p8 != null) {
      data['p8'] = p8;
    }
    if (p9 != null) {
      data['p9'] = p9;
    }
    if (p10 != null) {
      data['p10'] = p10;
    }
    if (p11 != null) {
      data['p11'] = p11;
    }
    if (p12 != null) {
      data['p12'] = p12;
    }
    if (p13 != null) {
      data['p13'] = p13;
    }
    if (p14 != null) {
      data['p14'] = p14;
    }
    if (p15 != null) {
      data['p15'] = p15;
    }
    if (pOther != null) {
      data['pOther'] = pOther;
    }
    if (account != null) {
      data['account'] = account;
    }
    if (side != null) {
      data['side'] = side;
    }
    if (symbol != null) {
      data['symbol'] = symbol;
    }
    if (volume != null) {
      data['volume'] = volume;
    }
    if (price != null) {
      data['price'] = price;
    }
    if (advance != null) {
      data['advance'] = advance;
    }
    if (refId != null) {
      data['refId'] = refId;
    }
    if (pin != null) {
      data['pin'] = pin;
    }
    if (orderNo != null) {
      data['orderNo'] = orderNo;
    }
    if (orderType != null) {
      data['orderType'] = orderType;
    }
    if (nvol != null) {
      data['nvol'] = nvol;
    }
    if (nprice != null) {
      data['nprice'] = nprice;
    }
    if (fisID != null) {
      data['fisID'] = fisID;
    }
    return data;
  }
}
