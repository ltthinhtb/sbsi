class FaceFPTCheck {
  int? iRs;
  String? sRs;
  FaceCheck? data;

  FaceFPTCheck({this.iRs, this.sRs, this.data});

  FaceFPTCheck.fromJson(Map<String, dynamic> json) {
    iRs = json['iRs'];
    sRs = json['sRs'];
    data = json['data'] != null ? FaceCheck.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iRs'] = iRs;
    data['sRs'] = sRs;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class FaceCheck {
  String? code;
  FaceCheckData? data;
  String? message;

  FaceCheck({this.code, this.data, this.message});

  FaceCheck.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? FaceCheckData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class FaceCheckData {
  bool? isMatch;
  double? similarity;
  bool? isBothImgIDCard;

  FaceCheckData({this.isMatch, this.similarity, this.isBothImgIDCard});

  FaceCheckData.fromJson(Map<String, dynamic> json) {
    isMatch = json['isMatch'];
    similarity = json['similarity'];
    isBothImgIDCard = json['isBothImgIDCard'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isMatch'] = isMatch;
    data['similarity'] = similarity;
    data['isBothImgIDCard'] = isBothImgIDCard;
    return data;
  }
}
