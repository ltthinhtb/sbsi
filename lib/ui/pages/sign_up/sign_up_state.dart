import 'package:flutter/cupertino.dart';

class SignUpState {
  final referralController = TextEditingController();
  final referralNameController = TextEditingController();

  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final rePassController = TextEditingController();

  final formKeyPhone = GlobalKey<FormState>();
  final formKeyEmail = GlobalKey<FormState>();
  final formKeyPass = GlobalKey<FormState>();
  final formKeyRePass = GlobalKey<FormState>();

  final FocusNode focusNodePhone = FocusNode();
  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodePass = FocusNode();
  final FocusNode focusNodeRePass = FocusNode();

  SignUpState() {}
}
