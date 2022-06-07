class NotifyRequest {
  String? cmd;
  int? page;
  int? records;
  String? isPush;
  String? type;
  String? account;
  String? sid;
  String? path;
  String? idNoti;

  NotifyRequest(this.path,
      {this.cmd,
        this.page,
        this.records,
        this.isPush,
        this.type,
        this.account,
        this.sid,this.idNoti});

  NotifyRequest.fromJson(Map<String, dynamic> json) {
    cmd = json['cmd'];
    page = json['page'];
    records = json['records'];
    isPush = json['isPush'];
    type = json['type'];
    account = json['account'];
    sid = json['sid'];
    idNoti =  json['idNoti'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cmd'] = this.cmd;
    data['page'] = this.page;
    data['records'] = this.records;
    data['isPush'] = this.isPush;
    data['type'] = this.type;
    data['account'] = this.account;
    data['sid'] = this.sid;
    data['idNoti'] = this.idNoti;
    return data;
  }
}
