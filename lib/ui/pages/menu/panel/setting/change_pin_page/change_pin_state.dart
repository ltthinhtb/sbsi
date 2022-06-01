import 'package:flutter/material.dart';

class ChangePinState {
  final TextEditingController old_controller = TextEditingController();
  final TextEditingController new_controller = TextEditingController();
  final TextEditingController confirm_controller = TextEditingController();

  final TextEditingController oldPinController = TextEditingController();
  final TextEditingController newPinController = TextEditingController();
  final TextEditingController confirmPinController = TextEditingController();

  ChangePinState();
}

class ChangePinModel {
  final String CURRENT_Pin;
  final String NEW_Pin;
  final String CONFIRM_NEW_Pin;
  ChangePinModel(
      this.CURRENT_Pin, this.NEW_Pin, this.CONFIRM_NEW_Pin);
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["CURRENT_Pin"] = CURRENT_Pin;
    data["NEW_Pin"] = NEW_Pin;
    data["CONFIRM_NEW_Pin"] = CONFIRM_NEW_Pin;
    return data;
  }
}
