class ForgotPassRequest {
  String? username;
  String? ss;
  String? step;
  String? otp;
  String? p1;
  String? p2;

  ForgotPassRequest(
      {this.username, this.ss, this.step, this.otp, this.p1, this.p2});

  ForgotPassRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    ss = json['ss'];
    step = json['step'];
    otp = json['otp'];
    p1 = json['p1'];
    p2 = json['p2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['ss'] = this.ss;
    data['step'] = this.step;
    data['otp'] = this.otp;
    data['p1'] = this.p1;
    data['p2'] = this.p2;
    return data;
  }
}
