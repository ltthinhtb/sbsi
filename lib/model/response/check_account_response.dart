class CheckAccountResponse {
  int? iRs;
  String? sRs;
  List<CheckAccount>? data;

  CheckAccountResponse({this.iRs, this.sRs, this.data});

  CheckAccountResponse.fromJson(Map<String, dynamic> json) {
    iRs = json['iRs'];
    sRs = json['sRs'];
    if (json['data'] != null) {
      data = <CheckAccount>[];
      json['data'].forEach((v) {
        data!.add(CheckAccount.fromJson(v));
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

class CheckAccount {
  String? cDATE;

  CheckAccount({this.cDATE});

  CheckAccount.fromJson(Map<String, dynamic> json) {
    cDATE = json['C_DATE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['C_DATE'] = cDATE;
    return data;
  }
}
