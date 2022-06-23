import 'data_params.dart';

class RequestParams {
  String? group;
  String? user;
  String? session;
  String? channel;
  String? checksum;
  String? otp;
  String? cmd;
  ParamsObject? data;
  String? ekyc;
  Map<String, dynamic>? param;

  String? enPoint;

  RequestParams(
      {this.group,
      this.user,
      this.session,
      this.channel,
      this.data,
      this.checksum,
      this.otp,
      this.cmd,
      this.param,
      this.ekyc,
      this.enPoint = "core"});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (group != null) {
      data['group'] = group;
    }
    if (ekyc != null) {
      data['ekyc'] = ekyc;
    }
    if (user != null) {
      data['user'] = user;
    }
    if (otp != null) {
      data['otp'] = otp;
    }
    if (session != null) {
      data['session'] = session;
    }
    if (channel != null) {
      data['channel'] = channel;
    }
    if (checksum != null) {
      data['checksum'] = checksum;
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (cmd != null) {
      data['cmd'] = cmd;
    }
    if (param != null) {
      data['param'] = param;
    }

    return data;
  }
}
