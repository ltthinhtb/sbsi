import 'package:sbsi/model/response/identity_card.dart';

class ImageOrcCheck {
  int? iRs;
  String? sRs;
  OrcDataCheck? data;

  ImageOrcCheck({this.iRs, this.sRs, this.data});

  ImageOrcCheck.fromJson(Map<String, dynamic> json) {
    iRs = json['iRs'];
    sRs = json['sRs'];
    data = json['data'] != null ? OrcDataCheck.fromJson(json['data']) : null;
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

class OrcDataCheck {
  int? errorCode;
  String? errorMessage;
  List<IdentityCard>? data;

  OrcDataCheck({this.errorCode, this.errorMessage, this.data});

  OrcDataCheck.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    if (json['data'] != null) {
      data = <IdentityCard>[];
      json['data'].forEach((v) {
        data!.add(IdentityCard.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errorCode'] = errorCode;
    data['errorMessage'] = errorMessage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
