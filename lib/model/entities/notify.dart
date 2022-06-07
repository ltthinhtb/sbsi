class Notify {
  String? id;
  String? title;
  String? imagePath;
  String? bodyShort;
  String? bodyDetail;
  String? isRead;
  String? dateTime;
  String? account;
  String? excelPath;
  String? isPush;

  Notify(
      {this.id,
        this.title,
        this.imagePath,
        this.bodyShort,
        this.bodyDetail,
        this.isRead,
        this.dateTime,
        this.account,
        this.excelPath,
        this.isPush});

  Notify.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imagePath = json['imagePath'];
    bodyShort = json['bodyShort'];
    bodyDetail = json['bodyDetail'];
    isRead = json['isRead'];
    dateTime = json['dateTime'];
    account = json['account'];
    excelPath = json['excelPath'];
    isPush = json['isPush'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['imagePath'] = this.imagePath;
    data['bodyShort'] = this.bodyShort;
    data['bodyDetail'] = this.bodyDetail;
    data['isRead'] = this.isRead;
    data['dateTime'] = this.dateTime;
    data['account'] = this.account;
    data['excelPath'] = this.excelPath;
    data['isPush'] = this.isPush;
    return data;
  }
}
