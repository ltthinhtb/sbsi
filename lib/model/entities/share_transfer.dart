class ShareTransfer {
  String? account;
  String? symbol;
  num? balance;
  num? max;

  ShareTransfer({this.account, this.symbol, this.balance, this.max});

  ShareTransfer.fromJson(Map<String, dynamic> json) {
    account = json['account'];
    symbol = json['symbol'];
    balance = json['balance'];
    max = json['max'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account'] = this.account;
    data['symbol'] = this.symbol;
    data['balance'] = this.balance;
    data['max'] = this.max;
    return data;
  }
}
