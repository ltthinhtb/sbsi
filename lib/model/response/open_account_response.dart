class OpenAccountResponse {
  int? iRs;
  String? sRs;
  List<Data>? data;

  OpenAccountResponse({this.iRs, this.sRs, this.data});

  OpenAccountResponse.fromJson(Map<String, dynamic> json) {
    iRs = json['iRs'];
    sRs = json['sRs'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iRs'] = iRs;
    data['sRs'] = sRs;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sTK;

  Data({this.sTK});

  Data.fromJson(Map<String, dynamic> json) {
    sTK = json['STK'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['STK'] = sTK;
    return data;
  }
}