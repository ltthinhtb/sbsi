import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/ui/commons/appbar.dart';
import 'package:sbsi/ui/pages/menu/panel/setting/change_password_page/change_password_view.dart';
import 'package:sbsi/utils/validator.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_images.dart';
import '../../../../generated/l10n.dart';
import '../../../../services/index.dart';
import '../../../widgets/button/button_filled.dart';
import '../../../widgets/textfields/app_text_field.dart';
import 'setting/change_pin_page/change_pin_view.dart';

class PinPassPage extends StatefulWidget {
  const PinPassPage({Key? key}) : super(key: key);

  @override
  State<PinPassPage> createState() => _PinPassPageState();
}

class _PinPassPageState extends State<PinPassPage> with Validator{
  final keyPass = GlobalKey<FormState>();

  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: S.of(context).pin_pass,
        isCenter: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            rowButton1(
                button: AppImages.faceID_setting,
                title: S.of(context).registration,
                onTap: () {}),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                thickness: 1,
                height: 32,
              ),
            ),
            rowButton(
                onTap: () {
                  Get.to(const ChangePasswordPage());
                },
                title: S.of(context).change_password,
                button: AppImages.key_icon),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                thickness: 1,
                height: 32,
              ),
            ),
            rowButton(
                onTap: () {
                  Get.to(const ChangePinPage());
                },
                title: S.of(context).change_pin,
                button: AppImages.lock),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                thickness: 1,
                height: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ValueNotifier<bool> isBiometrics =
  ValueNotifier<bool>(Get.find<AuthService>().isBiometricsSave);

  Widget rowButton1(
      {required String button,
        required String title,
        required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 20),
        child: Row(
          children: [
            SvgPicture.asset(button),
            const SizedBox(width: 16),
            Expanded(
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(fontWeight: FontWeight.w700),
                )),
            ValueListenableBuilder<bool>(
              builder: (BuildContext context, _isBiometrics, Widget? child) {
                return CupertinoSwitch(
                    value: _isBiometrics,
                    onChanged: (value) {
                      passController.clear();
                      changeBiometrics(value);
                    });
              },
              valueListenable: isBiometrics,
            ),

          ],
        ),
      ),
    );
  }

  void changeBiometrics(bool _isBiometrics) {
    Get.dialog(Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: Builder(builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Text(
                S.of(context).registration,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),
              Form(
                key: keyPass,
                child: AppTextFieldWidget(
                  validator: (pin) {
                    var currentPass =
                        Get.find<AuthService>().token.value?.data?.pass ?? "";
                    return checkConfirmPass(pin!, currentPass);
                  },
                  hintText: S.of(context).password,
                  inputController: passController,
                  obscureText: true,
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                      child: ButtonFill(
                        voidCallback: () {
                          Get.back();
                        },
                        title: S.of(context).cancel_short,
                        style: ElevatedButton.styleFrom(
                            onPrimary: AppColors.primary,
                            primary: const Color.fromRGBO(255, 238, 238, 1)),
                      )),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: ButtonFill(
                          voidCallback: () async {
                            if (!keyPass.currentState!.validate()) return;
                            isBiometrics.value = _isBiometrics;
                            await Get.find<AuthService>()
                                .changeIsBiometricsSave(isBiometrics.value);
                            //close dialog
                            Get.back();
                          },
                          title: S.of(context).confirm))
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      }),
    ));
  }

  Widget rowButton(
      {required String button,
      required String title,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 20),
        child: Row(
          children: [
            SvgPicture.asset(button),
            const SizedBox(width: 16),
            Expanded(
                child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(fontWeight: FontWeight.w700),
            )),
            SvgPicture.asset(AppImages.vector)
          ],
        ),
      ),
    );
  }
}
