class COMPARE_RESULT {
  Imgs? imgs;
  String? dataSign;
  String? dataBase64;
  String? logID;
  String? serverVersion;
  String? message;
  num? statusCode;
  Object? object;
  String? challengeCode;

  COMPARE_RESULT(
      {this.imgs,
        this.dataSign,
        this.dataBase64,
        this.logID,
        this.serverVersion,
        this.message,
        this.statusCode,
        this.object,
        this.challengeCode});

  COMPARE_RESULT.fromJson(Map<String, dynamic> json) {
    imgs = json['imgs'] != null ? new Imgs.fromJson(json['imgs']) : null;
    dataSign = json['dataSign'];
    dataBase64 = json['dataBase64'];
    logID = json['logID'];
    serverVersion = json['server_version'];
    message = json['message'];
    statusCode = json['statusCode'];
    object =
    json['object'] != null ? new Object.fromJson(json['object']) : null;
    challengeCode = json['challengeCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.imgs != null) {
      data['imgs'] = this.imgs!.toJson();
    }
    data['dataSign'] = this.dataSign;
    data['dataBase64'] = this.dataBase64;
    data['logID'] = this.logID;
    data['server_version'] = this.serverVersion;
    data['message'] = this.message;
    data['statusCode'] = this.statusCode;
    if (this.object != null) {
      data['object'] = this.object!.toJson();
    }
    data['challengeCode'] = this.challengeCode;
    return data;
  }
}

class Imgs {
  String? imgFace;
  String? imgFront;

  Imgs({this.imgFace, this.imgFront});

  Imgs.fromJson(Map<String, dynamic> json) {
    imgFace = json['img_face'];
    imgFront = json['img_front'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img_face'] = this.imgFace;
    data['img_front'] = this.imgFront;
    return data;
  }
}

class Object {
  String? result;
  String? msg;
  String? matchWarning;
  num? prob;
  bool? multipleFaces;

  Object(
      {this.result,
        this.msg,
        this.matchWarning,
        this.prob,
        this.multipleFaces});

  Object.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    msg = json['msg'];
    matchWarning = json['match_warning'];
    prob = json['prob'];
    multipleFaces = json['multiple_faces'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['msg'] = this.msg;
    data['match_warning'] = this.matchWarning;
    data['prob'] = this.prob;
    data['multiple_faces'] = this.multipleFaces;
    return data;
  }
}
