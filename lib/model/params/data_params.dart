class ParamsObject {
  String? type;
  String? cmd;
  var p;
  String? p1;
  String? p2;
  String? p3;
  String? p4;

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

  ParamsObject({
    this.type,
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
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
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
