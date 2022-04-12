class IndayOrder {
  String? orderNo;
  String? pkOrderNo;
  String? orderTime;
  String? accountCode;
  String? side;
  String? symbol;
  String? volume;
  String? showPrice;
  String? orderPrice;
  String? matchVolume;
  String? channel;
  String? group;
  String? cancelTime;
  String? info;
  String? maxPrice;
  String? matchValue;
  String? quote;
  String? status;
  String? isCancel;
  String? isAmend;
  String? autoType;
  String? product;

  IndayOrder(
      {this.orderNo,
      this.pkOrderNo,
      this.orderTime,
      this.accountCode,
      this.side,
      this.symbol,
      this.volume,
      this.showPrice,
      this.orderPrice,
      this.matchVolume,
      this.channel,
      this.group,
      this.cancelTime,
      this.info,
      this.maxPrice,
      this.matchValue,
      this.quote,
      this.status,
      this.isCancel,
      this.isAmend,
      this.autoType,
      this.product});

  num get matchPrice {
    try {
      num _matchValue = double.parse(matchValue ?? "0");
      num _matchVol = double.parse(matchVolume ?? "0");
      if (_matchValue > 0) {
        return _matchValue / (_matchVol * 1000);
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  IndayOrder.fromJson(Map<String?, dynamic> json) {
    orderNo = json['orderNo'];
    pkOrderNo = json['pk_orderNo'];
    orderTime = json['orderTime'];
    accountCode = json['accountCode'];
    side = json['side'];
    symbol = json['symbol'];
    volume = json['volume'];
    showPrice = json['showPrice'];
    orderPrice = json['orderPrice'];
    matchVolume = json['matchVolume'];
    channel = json['channel'];
    group = json['group'];
    cancelTime = json['cancelTime'];
    info = json['info'];
    maxPrice = json['maxPrice'];
    matchValue = json['matchValue'];
    quote = json['quote'];
    status = json['status'];
    isCancel = json['isCancel'];
    isAmend = json['isAmend'];
    autoType = json['autoType'];
    product = json['product'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = <String?, dynamic>{};
    data['orderNo'] = orderNo;
    data['pk_orderNo'] = pkOrderNo;
    data['orderTime'] = orderTime;
    data['accountCode'] = accountCode;
    data['side'] = side;
    data['symbol'] = symbol;
    data['volume'] = volume;
    data['showPrice'] = showPrice;
    data['orderPrice'] = orderPrice;
    data['matchVolume'] = matchVolume;
    data['channel'] = channel;
    data['group'] = group;
    data['cancelTime'] = cancelTime;
    data['info'] = info;
    data['maxPrice'] = maxPrice;
    data['matchValue'] = matchValue;
    data['quote'] = quote;
    data['status'] = status;
    data['isCancel'] = isCancel;
    data['isAmend'] = isAmend;
    data['autoType'] = autoType;
    data['product'] = product;
    return data;
  }
}
