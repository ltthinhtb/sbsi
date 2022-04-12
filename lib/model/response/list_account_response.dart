class ListAccountResponse {
  String? cmd;
  String? oID;
  int? rc;
  String? rs;
  List<Account>? data;

  ListAccountResponse({this.cmd, this.oID, this.rc, this.rs, this.data});

  ListAccountResponse.fromJson(Map<String, dynamic> json) {
    cmd = json['cmd'];
    oID = json['oID'];
    rc = json['rc'];
    rs = json['rs'];
    if (json['data'] != null) {
      data = <Account>[];
      json['data'].forEach((v) {
        data!.add(Account.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cmd'] = cmd;
    data['oID'] = oID;
    data['rc'] = rc;
    data['rs'] = rs;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Account {
  String? accCode;
  String? accName;
  String? accType;
  String? type;
  String? authen;
  String? serial;
  String? orderAcc;

  Account(
      {this.accCode,
        this.accName,
        this.accType,
        this.type,
        this.authen,
        this.serial,
        this.orderAcc});

  Account.fromJson(Map<String, dynamic> json) {
    accCode = json['accCode'];
    accName = json['accName'];
    accType = json['accType'];
    type = json['type'];
    authen = json['authen'];
    serial = json['serial'];
    orderAcc = json['orderAcc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accCode'] = accCode;
    data['accName'] = accName;
    data['accType'] = accType;
    data['type'] = type;
    data['authen'] = authen;
    data['serial'] = serial;
    data['orderAcc'] = orderAcc;
    return data;
  }
}
