class BranchResponse {
  int? rc;
  String? rs;
  List<String>? data;

  BranchResponse({this.rc, this.rs, this.data});

  BranchResponse.fromJson(Map<String, dynamic> json) {
    rc = json['rc'];
    rs = json['rs'];
    data = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rc'] = this.rc;
    data['rs'] = this.rs;
    data['data'] = this.data;
    return data;
  }
}
