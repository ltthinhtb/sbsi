import 'data_params.dart';

class RequestParams {
  String? group;
  String? user;
  String? session;
  String? channel;
  String? checksum;
  String? otp;
  ParamsObject? data;

  RequestParams({
    this.group,
    this.user,
    this.session,
    this.channel,
    this.data,
    this.checksum,
    this.otp
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['group'] = group;
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

    return data;
  }
}
