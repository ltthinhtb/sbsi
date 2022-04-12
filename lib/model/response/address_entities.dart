
class AddressEntities {
  String? province;
  String? district;
  String? ward;
  String? street;

  AddressEntities({this.province, this.district, this.ward, this.street});

  AddressEntities.fromJson(Map<String, dynamic> json) {
    province = json['province'];
    district = json['district'];
    ward = json['ward'];
    street = json['street'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['province'] = province;
    data['district'] = district;
    data['ward'] = ward;
    data['street'] = street;
    return data;
  }
}


