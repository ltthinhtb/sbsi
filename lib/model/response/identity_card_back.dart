class IdentityCardBack {
  String? religionProb;
  String? religion;
  String? ethnicityProb;
  String? ethnicity;
  String? features;
  String? featuresProb;
  String? issueDate;
  String? issueDateProb;
  String? issueLocProb;
  String? issueLoc;
  String? type;

  IdentityCardBack(
      {this.religionProb,
        this.religion,
        this.ethnicityProb,
        this.ethnicity,
        this.features,
        this.featuresProb,
        this.issueDate,
        this.issueDateProb,
        this.issueLocProb,
        this.issueLoc,
        this.type});

  IdentityCardBack.fromJson(Map<String, dynamic> json) {
    religionProb = json['religion_prob'];
    religion = json['religion'];
    ethnicityProb = json['ethnicity_prob'];
    ethnicity = json['ethnicity'];
    features = json['features'];
    featuresProb = json['features_prob'];
    issueDate = json['issue_date'];
    issueDateProb = json['issue_date_prob'];
    issueLocProb = json['issue_loc_prob'];
    issueLoc = json['issue_loc'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['religion_prob'] = religionProb;
    data['religion'] = religion;
    data['ethnicity_prob'] = ethnicityProb;
    data['ethnicity'] = ethnicity;
    data['features'] = features;
    data['features_prob'] = featuresProb;
    data['issue_date'] = issueDate;
    data['issue_date_prob'] = issueDateProb;
    data['issue_loc_prob'] = issueLocProb;
    data['issue_loc'] = issueLoc;
    data['type'] = type;
    return data;
  }
}