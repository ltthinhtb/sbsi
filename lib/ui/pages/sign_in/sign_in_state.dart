import 'package:flutter/material.dart';

class SignInState {
  late TextEditingController usernameTextController;
  late TextEditingController passwordTextController;
  final formKeyUser = GlobalKey<FormState>();
  final formKeyPass = GlobalKey<FormState>();
  final FocusNode focusNodeUsername = FocusNode();
  final FocusNode focusNodePassword = FocusNode();

  SignInState() {
    usernameTextController = TextEditingController();
    passwordTextController = TextEditingController();
  }
}
