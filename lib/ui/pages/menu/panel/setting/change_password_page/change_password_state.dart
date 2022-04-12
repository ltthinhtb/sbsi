import 'package:flutter/material.dart';

class ChangePasswordState {
  final TextEditingController old_controller = TextEditingController();
  final TextEditingController new_controller = TextEditingController();
  final TextEditingController confirm_controller = TextEditingController();

  ChangePasswordState();
}

class ChangePasswordModel {
  final String CURRENT_PASSWORD;
  final String NEW_PASSWORD;
  final String CONFIRM_NEW_PASSWORD;
  ChangePasswordModel(
      this.CURRENT_PASSWORD, this.NEW_PASSWORD, this.CONFIRM_NEW_PASSWORD);
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["CURRENT_PASSWORD"] = CURRENT_PASSWORD;
    data["NEW_PASSWORD"] = NEW_PASSWORD;
    data["CONFIRM_NEW_PASSWORD"] = CONFIRM_NEW_PASSWORD;
    return data;
  }
}
