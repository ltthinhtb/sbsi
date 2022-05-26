import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

import '../../../model/entities/bank.dart';
import '../../../model/entities/orc_model.dart';

class SignUpState {
  final referralController = TextEditingController();
  Rxn<String> errorText = Rxn<String>();
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

  final signature = SignatureController();

  String cardFrontUrl = "";
  String cardBackUrl = "";
  String faceUrl = "";
  String signatureUrl = "";


  OrcResponse? orcResponse;

  var listBank = <Bank>[];

  SignUpState() {}
}
