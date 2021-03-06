import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:new_version/new_version.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_images.dart';
import 'package:sbsi/configs/app_configs.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/ui/widgets/button/button_filled.dart';
import 'package:sbsi/ui/widgets/textfields/app_text_field.dart';
import 'package:sbsi/utils/validator.dart';
import '../../../router/route_config.dart';
import '../../../services/index.dart';
import '../../../utils/logger.dart';
import '../../widgets/button/button_text.dart';
import 'page/policy.dart';
import 'sign_in_logic.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with Validator {
  final logic = Get.put(SignInLogic());
  final state = Get.find<SignInLogic>().state;

  bool isTest = false;

  String _version = "";

  Future checkUpdate() async {
    final newVersion = NewVersion(
      iOSId: 'com.sbsi.etrading',
      androidId: 'com.sbsi.etrading',
    );

    // You can let the plugin handle fetching the status and showing a dialog,
    // or you can fetch the status and display your own dialog, or no dialog.
    try {
      final status = await newVersion.getVersionStatus();
      _version = status?.localVersion ?? "";
      if (status!.canUpdate) {
        newVersion.showUpdateDialog(
            context: context,
            versionStatus: status,
            dialogText: "Cập nhật phiên bản mới",
            dismissButtonText: "Bỏ qua",
            dialogTitle:
                "Vui lòng cập nhật phiên bản mới để tiếp tục xử dụng ứng dụng",
            dismissAction: () {
              SystemNavigator.pop();
            },
            updateButtonText: "Cập nhật");
      }
    } catch (e) {
      logger.e(e.toString());
    }
  }

  @override
  void initState() {
    checkUpdate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
    final body1 = Theme.of(context).textTheme.bodyText1;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox.expand(
              child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppImages.background),
                    fit: BoxFit.cover)),
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
                          style:
                              headline6?.copyWith(fontWeight: FontWeight.w700),
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
                              GestureDetector(
                                onTap: () {
                                  Get.find<AuthService>().authenticate();
                                },
                                child: SvgPicture.asset(
                                  "assets/icon_svg/face_id.svg",
                                  height: 33,
                                  width: 31,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        ButtonText(
                          voidCallback: () {
                            Get.toNamed(RouteConfig.forgot_pass);
                          },
                          title: '${S.of(context).forgot_pass}?',
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  ButtonFill(
                      voidCallback: () {
                        Get.toNamed(RouteConfig.sign_up);
                      },
                      title: S.of(context).register_online,
                      style: Theme.of(context)
                          .elevatedButtonTheme
                          .style
                          ?.copyWith(
                              backgroundColor: MaterialStateProperty.all(
                                  AppColors.buttonOrange),
                              padding: ButtonStyleButton.allOrNull<
                                      EdgeInsetsGeometry>(
                                  const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 7)),
                              shape:
                                  ButtonStyleButton.allOrNull<OutlinedBorder>(
                                      const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              )))),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      Get.to(const PolicySignUpPage());
                    },
                    child: Text(
                      S.of(context).policy_use,
                      style: body1?.copyWith(color: AppColors.white),
                    ),
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          )),
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20, right: 5),
                child: FutureBuilder<VersionStatus?>(
                    future: NewVersion(
                      iOSId: 'com.sbsi.etrading',
                      androidId: 'com.sbsi.etrading',
                    ).getVersionStatus(),
                    builder: (context, snapshot) {
                      String version = "";
                      if (snapshot.hasData) {
                        version = snapshot.data?.localVersion ?? "";
                      }
                      if (isTest) {
                        return Obx(() {
                          var flavor = Get.find<SettingService>().flavor;
                          var stringVersion = version + flavor.value.name;
                          return Text(
                            stringVersion,
                            style: const TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w700),
                          );
                        });
                      }
                      return Text(
                        version,
                        style: const TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w700),
                      );
                    }),
              )),
          Visibility(
            visible: isTest,
            child: Align(
                alignment: Alignment.bottomLeft,
                child: GestureDetector(
                  onTap: () {
                    showDialog();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20, left: 10),
                    child: SvgPicture.asset(AppImages.setting),
                  ),
                )),
          )
        ],
      ),
    );
  }

  void showDialog() {
    Get.dialog(Dialog(
      child: Builder(builder: (context) {
        var flavor = Get.find<SettingService>().flavor;
        return Obx(() {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Thay đổi phiên bản",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                    "Phiên bản hiện tại của bạn là $_version ${flavor.value.name}"),
                const Text("Chỉ thay đổi được ở phiên bản thử nghiệm"),
                RadioListTile<Flavor>(
                  groupValue: Flavor.TEST,
                  value: flavor.value,
                  title: Text(Flavor.TEST.name),
                  onChanged: (_flavor) {
                    Get.find<SettingService>().changeFlavor(Flavor.TEST);
                    Get.back();
                  },
                ),
                RadioListTile<Flavor>(
                  groupValue: Flavor.PROD,
                  value: flavor.value,
                  title: Text(Flavor.PROD.name),
                  onChanged: (_flavor) {
                    Get.find<SettingService>().changeFlavor(Flavor.PROD);
                    Get.back();
                  },
                )
              ],
            ),
          );
        });
      }),
    )).then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    Get.delete<SignInLogic>();
    super.dispose();
  }
}

