import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_images.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/ui/widgets/button/button_filled.dart';
import 'package:sbsi/ui/widgets/textfields/app_text_field.dart';
import 'package:sbsi/utils/validator.dart';
import '../../../utils/logger.dart';
import '../../widgets/button/button_text.dart';
import 'sign_in_logic.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with Validator {
  final logic = Get.put(SignInLogic());
  final state = Get.find<SignInLogic>().state;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
    final body1 =
        Theme.of(context).textTheme.bodyText1?.copyWith(color: AppColors.white);

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox.expand(
          child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImages.background), fit: BoxFit.cover)),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 200 / 812 * width),
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  AppImages.logo,
                  height: 43,
                  width: 208,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 48),
              Container(
                padding: const EdgeInsets.only(
                    top: 16, bottom: 24, left: 16.54, right: 14.54),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: AppColors.whiteBack,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).login,
                      style: headline6?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 24),
                    Form(
                      key: state.formKeyUser,
                      child: AppTextFieldWidget(
                          inputController: state.usernameTextController,
                          hintText: S.of(context).user_name,
                          hintTextStyle:
                              const TextStyle(color: AppColors.grayB5),
                          validator: (value) => checkUser(value!),
                          focusNode: state.focusNodeUsername,
                          onFieldSubmitted: (v) {
                            FocusScope.of(context)
                                .requestFocus(state.focusNodePassword);
                          }),
                    ),
                    const SizedBox(height: 16),
                    Form(
                      key: state.formKeyPass,
                      child: AppTextFieldWidget(
                        obscureText: true,
                        inputController: state.passwordTextController,
                        hintText: S.of(context).password,
                        validator: (value) => checkPass(value!),
                        focusNode: state.focusNodePassword,
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Expanded(
                            child: ButtonFill(
                              voidCallback: () {
                                logic.signIn();
                              },
                              title: S.of(context).login,
                            ),
                          ),
                          const SizedBox(width: 23.17),
                          SvgPicture.asset(
                            "assets/icon_svg/face_id.svg",
                            color: Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    ButtonText(
                      voidCallback: () {},
                      title: S.of(context).forgot_pass,
                    )
                  ],
                ),
              ),
              const Spacer(),
              ButtonFill(
                  voidCallback: () {
                    nativeCode();
                  },
                  title: S.of(context).register_online,
                  style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.buttonOrange),
                      padding: ButtonStyleButton.allOrNull<EdgeInsetsGeometry>(
                          const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 7)),
                      shape: ButtonStyleButton.allOrNull<OutlinedBorder>(
                          const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      )))),
              const SizedBox(height: 24),
              ButtonText(
                voidCallback: () {},
                title: S.of(context).policy_use,
                textStyle: body1,
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      )),
    );
  }

  Future<void> nativeCode() async {
    const platform = MethodChannel('sbsi-vnpt/ekyc');
    try {
      String result = await platform.invokeMethod('frontEKYC');
      Logger().d(result);

      // Map data = jsonDecode(result);
      // Logger().d(data);

      String result1 = await platform.invokeMethod('rearEKYC');

      Logger().d(result1);
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => Scaffold(
      //               body: Image.file(File(result)),
      //          )));
    } on PlatformException catch (e) {
      logger.e(e.toString());
    }
  }

  @override
  void dispose() {
    Get.delete<SignInLogic>();
    super.dispose();
  }
}