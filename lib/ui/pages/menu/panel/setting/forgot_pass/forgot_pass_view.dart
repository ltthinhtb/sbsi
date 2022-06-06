import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/ui/commons/appbar.dart';
import 'package:sbsi/ui/widgets/button/button_filled.dart';
import 'package:sbsi/ui/widgets/textfields/app_text_field.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../../utils/validator.dart';
import 'forgot_pass_logic.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({Key? key}) : super(key: key);

  @override
  _ForgotPassPageState createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> with Validator {
  final logic = Get.put(ForgotPassLogic());
  final state = Get.find<ForgotPassLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: S.of(context).forgot_pass,
        isCenter: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            Form(
              key: state.formAccount,
              child: AppTextFieldWidget(
                maxLength: 6,
                hintText: S.of(context).user_name,
                inputController: state.accountController,
                focusNode: state.focusNodeAccount,
                textInputType: TextInputType.number,
                validator: (account) {
                  return checkAccount(account!);
                },
                onChanged: (value) {
                  state.formAccount.currentState?.validate();
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Form(
              key: state.formIdentity,
              child: AppTextFieldWidget(
                hintText: S.of(context).identity_card,
                inputController: state.identityController,
                focusNode: state.focusNodeIdentity,
                validator: (identity) {
                  return checkIdentity(identity!);
                },
                onChanged: (value) {
                  state.formIdentity.currentState?.validate();
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Form(
              key: state.formPhone,
              child: AppTextFieldWidget(
                hintText: S.of(context).phone,
                inputController: state.phoneNumberController,
                focusNode: state.focusNodePhone,
                textInputType: TextInputType.number,
                validator: (phone) {
                  return checkPhoneNumber(phone!);
                },
                onChanged: (value) {
                  state.formPhone.currentState?.validate();
                },
              ),
            ),
            const Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ButtonFill(
                  voidCallback: () {

                    if (!state.formAccount.currentState!.validate()) {
                      return;
                    }
                    if (!state.formIdentity.currentState!.validate()) {
                      return;
                    }
                    if (!state.formPhone.currentState!.validate()) {
                      return;
                    }
                    print('ádsa');
                    logic.forgotPass();
                  },
                  title: S.of(context).confirm),
            ),
            const SizedBox(
              height: 32,
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<ForgotPassLogic>();
    super.dispose();
  }
}
