class OrcResponse {
  String? originLocation;
  String? msg;
  num? nameProb;
  num? coverProbFront;
  num? backTypeId;
  bool? addressFakeWarning;
  CheckingResultBack? checkingResultBack;
  String? nationPolicy;
  String? features;
  QualityBack? qualityBack;
  CheckingResultFront? checkingResultFront;
  String? backCornerWarning;
  String? id;
  String? backExpireWarning;
  String? msgBack;
  num? birthDayProb;
  String? recentLocation;
  String? idFakeWarning;
  num? issueDateProb;
  String? citizenId;
  num? recentLocationProb;
  num? issuePlaceProb;
  String? nationality;
  String? name;
  num? nameFakeWarningProb;
  String? gender;
  String? expireWarning;
  num? validDateProb;
  num? originLocationProb;
  String? cornerWarning;
  String? validDate;
  String? issueDate;
  num? idFakeProb;
  num? citizenIdProb;
  String? idProbs;
  num? dobFakeWarningProb;
  num? featuresProb;
  String? issuePlace;
  bool? dobFakeWarning;
  String? nameFakeWarning;
  num? typeId;
  QualityBack? qualityFront;
  String? cardType;
  String? birthDay;
  List<PostCode>? postCode;
  Tampering? tampering;

  OrcResponse(
      {this.originLocation,
      this.msg,
      this.nameProb,
      this.coverProbFront,
      this.backTypeId,
      this.addressFakeWarning,
      this.checkingResultBack,
      this.nationPolicy,
      this.features,
      this.qualityBack,
      this.checkingResultFront,
      this.backCornerWarning,
      this.id,
      this.backExpireWarning,
      this.msgBack,
      this.birthDayProb,
      this.recentLocation,
      this.idFakeWarning,
      this.issueDateProb,
      this.citizenId,
      this.recentLocationProb,
      this.issuePlaceProb,
      this.nationality,
      this.name,
      this.nameFakeWarningProb,
      this.gender,
      this.expireWarning,
      this.validDateProb,
      this.originLocationProb,
      this.cornerWarning,
      this.validDate,
      this.issueDate,
      this.idFakeProb,
      this.citizenIdProb,
      this.idProbs,
      this.dobFakeWarningProb,
      this.featuresProb,
      this.issuePlace,
      this.dobFakeWarning,
      this.nameFakeWarning,
      this.typeId,
      this.qualityFront,
      this.cardType,
      this.birthDay,
      this.postCode,
      this.tampering});

  OrcResponse.fromJson(Map<String, dynamic> json) {
    originLocation = json['origin_location'];
    msg = json['msg'];
    nameProb = json['name_prob'];
    coverProbFront = json['cover_prob_front'];
    backTypeId = json['back_type_id'];
    addressFakeWarning = json['address_fake_warning'];
    checkingResultBack = json['checking_result_back'] != null
        ? new CheckingResultBack.fromJson(json['checking_result_back'])
        : null;
    nationPolicy = json['nation_policy'];

    features = json['features'];
    qualityBack = json['quality_back'] != null
        ? new QualityBack.fromJson(json['quality_back'])
        : null;
    checkingResultFront = json['checking_result_front'] != null
        ? new CheckingResultFront.fromJson(json['checking_result_front'])
        : null;
    backCornerWarning = json['back_corner_warning'];
    id = json['id'];
    backExpireWarning = json['back_expire_warning'];
    msgBack = json['msg_back'];
    birthDayProb = json['birth_day_prob'];
    recentLocation = json['recent_location'];
    idFakeWarning = json['id_fake_warning'];
    issueDateProb = json['issue_date_prob'];
    citizenId = json['citizen_id'];
    recentLocationProb = json['recent_location_prob'];
    issuePlaceProb = json['issue_place_prob'];
    nationality = json['nationality'];
    name = json['name'];
    nameFakeWarningProb = json['name_fake_warning_prob'];
    gender = json['gender'];
    expireWarning = json['expire_warning'];
    validDateProb = json['valid_date_prob'];
    originLocationProb = json['origin_location_prob'];
    cornerWarning = json['corner_warning'];
    validDate = json['valid_date'];
    issueDate = json['issue_date'];
    idFakeProb = json['id_fake_prob'];
    citizenIdProb = json['citizen_id_prob'];
    idProbs = json['id_probs'];
    dobFakeWarningProb = json['dob_fake_warning_prob'];
    featuresProb = json['features_prob'];
    issuePlace = json['issue_place'];
    dobFakeWarning = json['dob_fake_warning'];
    nameFakeWarning = json['name_fake_warning'];
    typeId = json['type_id'];
    qualityFront = json['quality_front'] != null
        ? new QualityBack.fromJson(json['quality_front'])
        : null;
    cardType = json['card_type'];
    birthDay = json['birth_day'];
    if (json['post_code'] != null) {
      postCode = <PostCode>[];
      json['post_code'].forEach((v) {
        postCode!.add(new PostCode.fromJson(v));
      });
    }
    tampering = json['tampering'] != null
        ? new Tampering.fromJson(json['tampering'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['origin_location'] = this.originLocation;
    data['msg'] = this.msg;
    data['name_prob'] = this.nameProb;
    data['cover_prob_front'] = this.coverProbFront;
    data['back_type_id'] = this.backTypeId;
    data['address_fake_warning'] = this.addressFakeWarning;
    if (this.checkingResultBack != null) {
      data['checking_result_back'] = this.checkingResultBack!.toJson();
    }
    data['nation_policy'] = this.nationPolicy;

    data['features'] = this.features;
    if (this.qualityBack != null) {
      data['quality_back'] = this.qualityBack!.toJson();
    }
    if (this.checkingResultFront != null) {
      data['checking_result_front'] = this.checkingResultFront!.toJson();
    }
    data['back_corner_warning'] = this.backCornerWarning;
    data['id'] = this.id;
    data['back_expire_warning'] = this.backExpireWarning;
    data['msg_back'] = this.msgBack;
    data['birth_day_prob'] = this.birthDayProb;
    data['recent_location'] = this.recentLocation;
    data['id_fake_warning'] = this.idFakeWarning;
    data['issue_date_prob'] = this.issueDateProb;
    data['citizen_id'] = this.citizenId;
    data['recent_location_prob'] = this.recentLocationProb;
    data['issue_place_prob'] = this.issuePlaceProb;
    data['nationality'] = this.nationality;
    data['name'] = this.name;
    data['name_fake_warning_prob'] = this.nameFakeWarningProb;
    data['gender'] = this.gender;
    data['expire_warning'] = this.expireWarning;
    data['valid_date_prob'] = this.validDateProb;
    data['origin_location_prob'] = this.originLocationProb;
    data['corner_warning'] = this.cornerWarning;
    data['valid_date'] = this.validDate;
    data['issue_date'] = this.issueDate;
    data['id_fake_prob'] = this.idFakeProb;
    data['citizen_id_prob'] = this.citizenIdProb;
    data['id_probs'] = this.idProbs;
    data['dob_fake_warning_prob'] = this.dobFakeWarningProb;
    data['features_prob'] = this.featuresProb;
    data['issue_place'] = this.issuePlace;
    data['dob_fake_warning'] = this.dobFakeWarning;
    data['name_fake_warning'] = this.nameFakeWarning;
    data['type_id'] = this.typeId;
    if (this.qualityFront != null) {
      data['quality_front'] = this.qualityFront!.toJson();
    }
    data['card_type'] = this.cardType;
    data['birth_day'] = this.birthDay;
    if (this.postCode != null) {
      data['post_code'] = this.postCode!.map((v) => v.toJson()).toList();
    }
    if (this.tampering != null) {
      data['tampering'] = this.tampering!.toJson();
    }
    return data;
  }
}

class CheckingResultBack {
  String? cornerCutResult;
  num? editedProb;
  num? checkPhotocopiedProb;
  String? recapturedResult;
  String? checkPhotocopiedResult;
  String? editedResult;
  num? recapturedProb;

  CheckingResultBack(
      {this.cornerCutResult,
      this.editedProb,
      this.checkPhotocopiedProb,
      this.recapturedResult,
      this.checkPhotocopiedResult,
      this.editedResult,
      this.recapturedProb});

  CheckingResultBack.fromJson(Map<String, dynamic> json) {
    cornerCutResult = json['corner_cut_result'];
    editedProb = json['edited_prob'];
    checkPhotocopiedProb = json['check_photocopied_prob'];
    recapturedResult = json['recaptured_result'];
    checkPhotocopiedResult = json['check_photocopied_result'];
    editedResult = json['edited_result'];
    recapturedProb = json['recaptured_prob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['corner_cut_result'] = this.cornerCutResult;
    data['edited_prob'] = this.editedProb;
    data['check_photocopied_prob'] = this.checkPhotocopiedProb;
    data['recaptured_result'] = this.recapturedResult;
    data['check_photocopied_result'] = this.checkPhotocopiedResult;
    data['edited_result'] = this.editedResult;
    data['recaptured_prob'] = this.recapturedProb;
    return data;
  }
}

class QualityBack {
  num? blurScore;
  BrightSpotParam? brightSpotParam;
  num? luminanceScore;
  FinalResult? finalResult;
  num? brightSpotScore;

  QualityBack(
      {this.blurScore,
      this.brightSpotParam,
      this.luminanceScore,
      this.finalResult,
      this.brightSpotScore});

  QualityBack.fromJson(Map<String, dynamic> json) {
    blurScore = json['blur_score'];
    brightSpotParam = json['bright_spot_param'] != null
        ? new BrightSpotParam.fromJson(json['bright_spot_param'])
        : null;
    luminanceScore = json['luminance_score'];
    finalResult = json['final_result'] != null
        ? new FinalResult.fromJson(json['final_result'])
        : null;
    brightSpotScore = json['bright_spot_score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['blur_score'] = this.blurScore;
    if (this.brightSpotParam != null) {
      data['bright_spot_param'] = this.brightSpotParam!.toJson();
    }
    data['luminance_score'] = this.luminanceScore;
    if (this.finalResult != null) {
      data['final_result'] = this.finalResult!.toJson();
    }
    data['bright_spot_score'] = this.brightSpotScore;
    return data;
  }
}

class BrightSpotParam {
  num? averageIntensity;
  num? brightSpotThreshold;
  num? totalBrightSpotArea;

  BrightSpotParam(
      {this.averageIntensity,
      this.brightSpotThreshold,
      this.totalBrightSpotArea});

  BrightSpotParam.fromJson(Map<String, dynamic> json) {
    averageIntensity = json['average_intensity'];
    brightSpotThreshold = json['bright_spot_threshold'];
    totalBrightSpotArea = json['total_bright_spot_area'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['average_intensity'] = this.averageIntensity;
    data['bright_spot_threshold'] = this.brightSpotThreshold;
    data['total_bright_spot_area'] = this.totalBrightSpotArea;
    return data;
  }
}

class FinalResult {
  String? badLuminanceLikelihood;
  String? lowResolutionLikelihood;
  String? blurredLikelihood;
  String? brightSpotLikelihood;

  FinalResult(
      {this.badLuminanceLikelihood,
      this.lowResolutionLikelihood,
      this.blurredLikelihood,
      this.brightSpotLikelihood});

  FinalResult.fromJson(Map<String, dynamic> json) {
    badLuminanceLikelihood = json['bad_luminance_likelihood'];
    lowResolutionLikelihood = json['low_resolution_likelihood'];
    blurredLikelihood = json['blurred_likelihood'];
    brightSpotLikelihood = json['bright_spot_likelihood'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bad_luminance_likelihood'] = this.badLuminanceLikelihood;
    data['low_resolution_likelihood'] = this.lowResolutionLikelihood;
    data['blurred_likelihood'] = this.blurredLikelihood;
    data['bright_spot_likelihood'] = this.brightSpotLikelihood;
    return data;
  }
}

class CheckingResultFront {
  String? cornerCutResult;
  num? editedProb;
  num? checkPhotocopiedProb;
  String? recapturedResult;
  String? checkPhotocopiedResult;
  String? editedResult;
  num? recapturedProb;

  CheckingResultFront(
      {this.cornerCutResult,
      this.editedProb,
      this.checkPhotocopiedProb,
      this.recapturedResult,
      this.checkPhotocopiedResult,
      this.editedResult,
      this.recapturedProb});

  CheckingResultFront.fromJson(Map<String, dynamic> json) {
    cornerCutResult = json['corner_cut_result'];
    editedProb = json['edited_prob'];
    checkPhotocopiedProb = json['check_photocopied_prob'];
    recapturedResult = json['recaptured_result'];
    checkPhotocopiedResult = json['check_photocopied_result'];
    editedResult = json['edited_result'];
    recapturedProb = json['recaptured_prob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['corner_cut_result'] = this.cornerCutResult;
    data['edited_prob'] = this.editedProb;
    data['check_photocopied_prob'] = this.checkPhotocopiedProb;
    data['recaptured_result'] = this.recapturedResult;
    data['check_photocopied_result'] = this.checkPhotocopiedResult;
    data['edited_result'] = this.editedResult;
    data['recaptured_prob'] = this.recapturedProb;
    return data;
  }
}

class PostCode {
  String? debug;
  List<String>? city;
  List<String>? district;
  List<String>? ward;
  String? detail;
  String? type;

  PostCode(
      {this.debug,
      this.city,
      this.district,
      this.ward,
      this.detail,
      this.type});

  PostCode.fromJson(Map<String, dynamic> json) {
    debug = json['debug'];
    city = json['city'].cast<String>();
    district = json['district'].cast<String>();
    ward = json['ward'].cast<String>();
    detail = json['detail'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['debug'] = this.debug;
    data['city'] = this.city;
    data['district'] = this.district;
    data['ward'] = this.ward;
    data['detail'] = this.detail;
    data['type'] = this.type;
    return data;
  }
}

class Tampering {
  String? isLegal;

  Tampering({this.isLegal});

  Tampering.fromJson(Map<String, dynamic> json) {
    isLegal = json['is_legal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_legal'] = this.isLegal;
    return data;
  }
}
