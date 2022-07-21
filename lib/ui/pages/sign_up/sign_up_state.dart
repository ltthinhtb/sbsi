import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

import '../../../model/entities/bank.dart';
import '../../../model/entities/orc_model.dart';

class SignUpState {
  final referralController = TextEditingController(text: "2003");
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
  final pinController = TextEditingController();

  final FocusNode focusNodePhone = FocusNode();
  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodePass = FocusNode();
  final FocusNode focusNodeRePass = FocusNode();

  final signature = SignatureController();

  final passPinController = TextEditingController();
  final formKeyPassPin = GlobalKey<FormState>();

  final bankController = TextEditingController();
  final bankAccountController = TextEditingController();
  final bankBranhController = TextEditingController();

  final formKeyBankAccount = GlobalKey<FormState>();
  final FocusNode bankNode = FocusNode();
  Rxn<String> errorBank = Rxn<String>();

  String cardFrontUrl = "";
  String cardBackUrl = "";
  String faceUrl = "";
  String signatureUrl = "";

  String accountCode = "";

  OrcResponse? orcResponse;

  bool isOpenMargin = false;

  // ứng trước tiền bán chứng khoán
  int C_ADVANCE_WITHDRAW = 0;

  // giao dịch tổng đài
  int C_FOLLOW_TRADING = 0;

  //giao dịch trực tuyến
  int C_ONLINE_TRADING = 0;

  // nhận thông báo qua mail
  int C_RECEIVE_EMAIL = 0;

  var listBank = <Bank>[];

  SignUpState() {}
}
