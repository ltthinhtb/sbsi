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

import 'change_pin_logic.dart';
import 'change_pin_state.dart';

class ChangePinPage extends StatefulWidget {
  const ChangePinPage({Key? key}) : super(key: key);

  @override
  _ChangePinPageState createState() => _ChangePinPageState();
}

class _ChangePinPageState extends State<ChangePinPage> {
  final ChangePinLogic logic = Get.put(ChangePinLogic());
  final ChangePinState state = Get.find<ChangePinLogic>().state;
  final SettingService settingService = Get.find<SettingService>();
  bool showButton = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ChangePinLogic>();
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
            S.of(context).change_pin,
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
              await logic.changePin();
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
            hintText: S.of(context).old_pin,
          ),
        ),
        const SizedBox(height: 16),
        Form(
          // key: state.formKeyUser,
          child: AppTextFieldWidget(
            obscureText: true,
            inputController: state.new_controller,
            hintText: S.of(context).new_pin,
          ),
        ),
        const SizedBox(height: 16),
        Form(
          // key: state.formKeyUser,
          child: AppTextFieldWidget(
            obscureText: true,
            inputController: state.confirm_controller,
            hintText: S.of(context).confirm_new_pin,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
