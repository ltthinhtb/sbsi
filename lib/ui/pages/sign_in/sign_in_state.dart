import 'package:flutter/material.dart';

class SignInState {
  late TextEditingController usernameTextController;
  late TextEditingController passwordTextController;
  final formKeyUser = GlobalKey<FormState>();
  final formKeyPass = GlobalKey<FormState>();
  final FocusNode forcusNodeUsername = FocusNode();
  final FocusNode forcusNodePassword = FocusNode();

  SignInState() {
    usernameTextController = TextEditingController(text: '123456');
    passwordTextController = TextEditingController(text: "1234567");
  }
}
