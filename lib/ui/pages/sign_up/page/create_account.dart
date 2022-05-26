import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/utils/validator.dart';
import '../../../../generated/l10n.dart';
import '../../../commons/appbar.dart';
import '../../../widgets/button/button_filled.dart';
import '../../../widgets/textfields/app_text_field.dart';
import '../sign_up_logic.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> with Validator {
  final logic = Get.put(SignUpLogic());
  final state = Get.find<SignUpLogic>().state;

  @override
  void initState() {
    state.rePassController.clear();
    state.passController.clear();
    state.emailController.clear();
    state.phoneController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
    return Scaffold(
      backgroundColor: AppColors.whiteBack,
      resizeToAvoidBottomInset: false,
      appBar: AppBarCustom(
        title: S.of(context).create_account,
        isCenter: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearPercentIndicator(
              width: MediaQuery.of(context).size.width,
              progressColor: AppColors.yellowStatus,
              backgroundColor: Colors.grey[300],
              lineHeight: 5,
              percent: 0.2,
              padding: EdgeInsets.zero,
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Bước 1: Tạo tài khoản',
                style: headline6?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Quý khách vui lòng cung cấp số điện thoại và Email để đăng ký mở tài khoản',
                style: headline6?.copyWith(fontSize: 16, height: 24 / 16),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: state.formKeyPhone,
                child: AppTextFieldWidget(
                  inputController: state.phoneController,
                  hintText: S.of(context).phone,
                  focusNode: state.focusNodePhone,
                  validator: (phone) => checkPhoneNumber(phone!),
                  onFieldSubmitted: (phone) {
                    if (state.formKeyPhone.currentState!.validate()) {
                      FocusScope.of(context).requestFocus(state.focusNodeEmail);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: state.formKeyEmail,
                child: AppTextFieldWidget(
                  inputController: state.emailController,
                  hintText: S.of(context).email,
                  focusNode: state.focusNodeEmail,
                  validator: (email) => checkEmail(email!),
                  onFieldSubmitted: (email) {
                    if (state.formKeyEmail.currentState!.validate()) {
                      FocusScope.of(context).requestFocus(state.focusNodePass);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: state.formKeyPass,
                child: AppTextFieldWidget(
                  inputController: state.passController,
                  hintText: S.of(context).password,
                  obscureText: true,
                  focusNode: state.focusNodePass,
                  validator: (pass) => checkPass(pass!),
                  onFieldSubmitted: (pass) {
                    if (state.formKeyEmail.currentState!.validate()) {
                      FocusScope.of(context)
                          .requestFocus(state.focusNodeRePass);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: state.formKeyRePass,
                child: AppTextFieldWidget(
                  inputController: state.rePassController,
                  hintText: S.of(context).confirm_new_password,
                  obscureText: true,
                  focusNode: state.focusNodeRePass,
                  validator: (rePass) =>
                      checkConfirmPass(rePass!, state.passController.text),
                  onFieldSubmitted: (rePass) {
                    if (state.formKeyEmail.currentState!.validate()) {}
                  },
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ButtonFill(
                      voidCallback: () {
                        if (!state.formKeyPhone.currentState!.validate()) {
                          return;
                        }
                        if (!state.formKeyEmail.currentState!.validate()) {
                          return;
                        }
                        if (!state.formKeyPass.currentState!.validate()) {
                          return;
                        }
                        if (!state.formKeyRePass.currentState!.validate()) {
                          return;
                        }
                        logic.checkPhone();
                      },
                      title: S.of(context).continue_step)),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
