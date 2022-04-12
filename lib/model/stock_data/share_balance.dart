class ShareBalance {
  String? accCode;
  String? sym;
  int? shareBalance;
  int? actual;

  ShareBalance({this.accCode, this.sym, this.shareBalance, this.actual});

  ShareBalance.fromJson(Map<String, dynamic> json) {
    accCode = json['accCode'];
    sym = json['sym'];
    shareBalance = json['shareBalance'];
    actual = json['actual'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accCode'] = accCode;
    data['sym'] = sym;
    data['shareBalance'] = shareBalance;
    data['actual'] = actual;
    return data;
  }
}
