import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotPassState {
  final accountController = TextEditingController();
  final identityController = TextEditingController();
  final phoneNumberController = TextEditingController();

  final otpController = TextEditingController();


  final formAccount = GlobalKey<FormState>();
  final formIdentity = GlobalKey<FormState>();
  final formPhone = GlobalKey<FormState>();
  final formOtp = GlobalKey<FormState>();

  final focusNodeAccount = FocusNode();
  final focusNodeIdentity = FocusNode();
  final focusNodePhone = FocusNode();
  final focusNodeOtp = FocusNode();


  final step = 1.obs;

  ForgotPassState() {}
}
