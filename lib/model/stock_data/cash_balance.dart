// {
//     "cmd": "Web.sCashBalance",
//     "oID": "",
//     "rc": 1,
//     "rs": "null",
//     "data": {
//         "accCode": "0027061",
//         "accType": "N",
//         "sym": "APS",
//         "cashAvaiable": "100137060765",
//         "balance": "0",
//         "volumeAvaiable": "22230449",
//         "marginratio": "1",
//         "accName": "Đào Duy Minh"
//     }
// }
// {
//     "cmd": "Web.sCashBalance",
//     "oID": "",
//     "rc": 1,
//     "rs": "null",
//     "data": {
//         "accCode": "0027066",
//         "accType": "M",
//         "sym": "AAV",
//         "ee": "19734132",                    Suc mua TK
//         "marginratio": ".643",
//         "im_ck": "80",
//         "pp": "24667665",                    Suc mua cua Ma
//         "volumeAvaiable": "1232",
//         "balance": "0",
//         "color": "green",
//         "accName": "Đào Duy Minh"
//     }
// }
class CashBalance {
  String? accCode;
  String? accType;
  String? sym;
  String? ee;
  String? marginratio;
  String? imCk;
  String? pp;
  String? volumeAvaiable;
  String? balance;
  String? color;
  String? accName;

  CashBalance(
      {this.accCode,
      this.accType,
      this.sym,
      this.ee,
      this.marginratio,
      this.imCk,
      this.pp,
      this.volumeAvaiable,
      this.balance,
      this.color,
      this.accName});

  CashBalance.fromJson(Map<String, dynamic> json) {
    accCode = json['accCode'];
    accType = json['accType'];
    sym = json['sym'];
    ee = json['ee'];
    marginratio = json['marginratio'];
    imCk = json['im_ck'];
    pp = json['pp'];
    volumeAvaiable = json['volumeAvaiable'];
    balance = json['balance'];
    color = json['color'];
    accName = json['accName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accCode'] = accCode;
    data['accType'] = accType;
    data['sym'] = sym;
    data['ee'] = ee;
    data['marginratio'] = marginratio;
    data['im_ck'] = imCk;
    data['pp'] = pp;
    data['volumeAvaiable'] = volumeAvaiable;
    data['balance'] = balance;
    data['color'] = color;
    data['accName'] = accName;
    return data;
  }
}
