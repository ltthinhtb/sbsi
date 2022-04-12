import 'address_entities.dart';

class IdentityCard {
  String? id;
  String? idProb;
  String? name;
  String? nameProb;
  String? dob;
  String? dobProb;
  String? sex;
  String? sexProb;
  String? ethnicity;
  String? ethnicityProb;
  String? typeNew;
  String? doe;
  String? doeProb;
  String? home;
  String? homeProb;
  String? address;
  String? addressProb;
  AddressEntities? addressEntities;

  String? overallScore;
  String? type;
  String? religionProb;
  String? religion;
  String? features;
  String? featuresProb;
  String? issueDate;
  String? issueDateProb;
  String? issueLocProb;
  String? issueLoc;

  IdentityCard(
      {this.id,
      this.idProb,
      this.name,
      this.nameProb,
      this.dob,
      this.dobProb,
      this.sex,
      this.sexProb,
      this.ethnicity,
      this.ethnicityProb,
      this.typeNew,
      this.doe,
      this.doeProb,
      this.home,
      this.homeProb,
      this.address,
      this.addressProb,
      this.addressEntities,
      this.overallScore,
      this.type,
      this.features,
      this.featuresProb,
      this.issueDate,
      this.issueDateProb,
      this.issueLoc,
      this.issueLocProb,
      this.religion,
      this.religionProb});

  IdentityCard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idProb = json['id_prob'];
    name = json['name'];
    nameProb = json['name_prob'];
    dob = json['dob'];
    dobProb = json['dob_prob'];
    sex = json['sex'];
    sexProb = json['sex_prob'];
    ethnicity = json['ethnicity'];
    ethnicityProb = json['ethnicity_prob'];
    typeNew = json['type_new'];
    doe = json['doe'];
    doeProb = json['doe_prob'];
    home = json['home'];
    homeProb = json['home_prob'];
    address = json['address'];
    addressProb = json['address_prob'];
    addressEntities = json['address_entities'] != null
        ? AddressEntities.fromJson(json['address_entities'])
        : null;
    overallScore = json['overall_score'];
    type = json['type'];
    religionProb = json['religion_prob'];
    religion = json['religion'];
    features = json['features'];
    featuresProb = json['features_prob'];
    issueDate = json['issue_date'];
    issueDateProb = json['issue_date_prob'];
    issueLocProb = json['issue_loc_prob'];
    issueLoc = json['issue_loc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_prob'] = idProb;
    data['name'] = name;
    data['name_prob'] = nameProb;
    data['dob'] = dob;
    data['dob_prob'] = dobProb;
    data['sex'] = sex;
    data['sex_prob'] = sexProb;
    data['ethnicity'] = ethnicity;
    data['ethnicity_prob'] = ethnicityProb;
    data['type_new'] = typeNew;
    data['doe'] = doe;
    data['doe_prob'] = doeProb;
    data['home'] = home;
    data['home_prob'] = homeProb;
    data['address'] = address;
    data['address_prob'] = addressProb;
    if (addressEntities != null) {
      data['address_entities'] = addressEntities!.toJson();
    }
    data['overall_score'] = overallScore;
    data['type'] = type;
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
