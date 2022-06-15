import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_dimens.dart';
import 'package:sbsi/common/app_text_styles.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/networks/error_exception.dart';
import 'package:sbsi/services/index.dart';
import 'package:sbsi/ui/commons/app_snackbar.dart';
import 'package:sbsi/ui/widgets/textfields/app_text_field.dart';

import 'change_password_logic.dart';
import 'change_password_state.dart';

class ChangePasswordPage extends StatefulWidget {
  /// lần đầu đổi pass
  final bool isFirst;

  const ChangePasswordPage({Key? key, this.isFirst = false}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final ChangePasswordLogic logic = Get.put(ChangePasswordLogic());
  final ChangePasswordState state = Get.find<ChangePasswordLogic>().state;
  final SettingService settingService = Get.find<SettingService>();
  bool showButton = false;

  @override
  void initState() {
    super.initState();
  }

  // void startListener() {
  //   _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     if (state.old_controller.text.isNotEmpty &&
  //         state.new_controller.text.isNotEmpty &&
  //         state.confirm_controller.text.isNotEmpty) {
  //       setState(() {
  //         showButton = true;
  //       });
  //     } else {
  //       setState(() {
  //         showButton = false;
  //       });
  //     }
  //   });
  // }

  @override
  void dispose() {
    Get.delete<ChangePasswordLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Container(
          child: Text(
            S.of(context).change_password,
            style: AppTextStyle.H3,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(AppDimens.paddingNormal),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildLanguageSection(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: MaterialButton(
          minWidth: width - 30,
          height: 50,
          color: AppColors.primary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          onPressed: () async {
            try {
              await logic.validateInfo();
              if (widget.isFirst) {
                await logic.changePasswordFirst();
              } else {
                await logic.changePassword();
              }
              if (widget.isFirst) {
                // chỉ hiện snackbar khi đổi mật khẩu lần đầu
                AppSnackBar.showSuccess(
                    message: S.of(context).change_password_success);
              }
            } on ErrorException catch (e) {
              AppSnackBar.showError(message: e.message);
            } catch (e) {
              AppSnackBar.showError(message: e.toString());
            }
          },
          child: Text(
            S.of(context).update,
            style: AppTextStyle.H5Bold.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Form(
          // key: state.formKeyUser,
          child: AppTextFieldWidget(
            obscureText: true,
            inputController: state.old_controller,
            hintText: S.of(context).old_password,
            label: S.of(context).old_password,
            isShowLabel: false,
          ),
        ),
        const SizedBox(height: 16),
        Form(
          // key: state.formKeyUser,
          child: AppTextFieldWidget(
            obscureText: true,
            inputController: state.new_controller,
            hintText: S.of(context).new_password,
            label: S.of(context).new_password,
            isShowLabel: false,
          ),
        ),
        const SizedBox(height: 16),
        Form(
          // key: state.formKeyUser,
          child: AppTextFieldWidget(
            obscureText: true,
            inputController: state.confirm_controller,
            hintText: S.of(context).confirm_new_password,
            label: S.of(context).confirm_new_password,
            isShowLabel: false,
          ),
        ),
        const SizedBox(height: 16),
        Visibility(
          visible: widget.isFirst,
          child: Column(
            children: [
              Form(
                // key: state.formKeyUser,
                child: AppTextFieldWidget(
                  obscureText: true,
                  inputController: state.oldPinController,
                  hintText: S.of(context).old_pin,
                  label: S.of(context).old_pin,
                  isShowLabel: false,
                ),
              ),
              const SizedBox(height: 16),
              Form(
                // key: state.formKeyUser,
                child: AppTextFieldWidget(
                  obscureText: true,
                  inputController: state.newPinController,
                  hintText: S.of(context).new_pin,
                  label: S.of(context).new_pin,
                  isShowLabel: false,
                ),
              ),
              const SizedBox(height: 16),
              Form(
                // key: state.formKeyUser,
                child: AppTextFieldWidget(
                  obscureText: true,
                  inputController: state.confirmPinController,
                  hintText: S.of(context).confirm_pin,
                  label: S.of(context).confirm_pin,
                  isShowLabel: false,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
