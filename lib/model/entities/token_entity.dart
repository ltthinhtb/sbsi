class TokenEntity {
  String? cmd;
  String? oID;
  int? rc;
  String? rs;
  Data? data;

  TokenEntity({this.cmd, this.oID, this.rc, this.rs, this.data});

  TokenEntity.fromJson(Map<String, dynamic> json) {
    cmd = json['cmd'];
    oID = json['oID'];
    rc = json['rc'];
    rs = json['rs'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cmd'] = cmd;
    data['oID'] = oID;
    data['rc'] = rc;
    data['rs'] = rs;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? user;
  String? name;
  String? sid;
  String? address;
  String? defaultAcc;
  int? iFlag;
  int? countLoginFail;
  String? authenType;
  String? iP;

  Data(
      {this.user,
        this.name,
        this.sid,
        this.address,
        this.defaultAcc,
        this.iFlag,
        this.countLoginFail,
        this.authenType,
        this.iP});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    name = json['name'];
    sid = json['sid'];
    address = json['address'];
    defaultAcc = json['defaultAcc'];
    iFlag = json['iFlag'];
    countLoginFail = json['CountLoginFail'];
    authenType = json['AuthenType'];
    iP = json['IP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['name'] = name;
    data['sid'] = sid;
    data['address'] = address;
    data['defaultAcc'] = defaultAcc;
    data['iFlag'] = iFlag;
    data['CountLoginFail'] = countLoginFail;
    data['AuthenType'] = authenType;
    data['IP'] = iP;
    return data;
  }
}
