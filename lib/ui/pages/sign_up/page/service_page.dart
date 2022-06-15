import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sbsi/ui/widgets/textfields/app_text_field.dart';
import 'package:sbsi/utils/validator.dart';
import '../../../../common/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../../model/entities/bank.dart';
import '../../../commons/appbar.dart';
import '../../../widgets/button/button_filled.dart';
import '../../../widgets/textfields/app_text_typehead.dart';
import '../enum/enums.dart';
import '../sign_up_logic.dart';
import 'policy_page.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({Key? key}) : super(key: key);

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> with Validator {
  bool _internet = false;
  bool _hotline = false;

  bool isOpenPin = false;
  bool _money = false;

  AccountEnums accountEnums = AccountEnums.normal;

  final logic = Get.put(SignUpLogic());
  final state = Get.find<SignUpLogic>().state;

  @override
  void initState() {
    logic.getListBank();

    /// check xem ngân hàng có đúng k
    state.bankNode.addListener(() {
      selectBank();
    });
    super.initState();
  }

  /// chọn mã ngân hàng
  void selectBank() {
    int index = state.listBank.indexWhere((element) =>
        element.cBANKCODE!.toLowerCase() ==
        state.bankController.text.toLowerCase());
    if (index >= 0) {
      state.bankController.text = state.listBank[index].cBANKCODE ?? "";
      state.bankAccountController.clear();
      state.bankBranhController.clear();
      state.errorBank.value = null;
    } else {
      state.errorBank.value = "Ngân hàng không hợp lệ";
    }
  }

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
    final body2 = Theme.of(context).textTheme.bodyText2;
    final body1 = Theme.of(context).textTheme.bodyText1;
    final caption = Theme.of(context).textTheme.caption;

    return Scaffold(
      backgroundColor: AppColors.whiteBack,
      appBar: AppBarCustom(
        title: S.of(context).service_register,
        isCenter: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearPercentIndicator(
                width: MediaQuery.of(context).size.width,
                progressColor: AppColors.yellowStatus,
                backgroundColor: Colors.grey[300],
                lineHeight: 5,
                percent: 0.8,
                padding: EdgeInsets.zero,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Bước 4: ${S.of(context).service_register}',
                      style: headline6?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 26.5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Giao dịch trực truyến qua Internet',
                          style: body2,
                        ),
                        CupertinoSwitch(
                          value: _internet,
                          onChanged: (bool value) {
                            setState(() {
                              _internet = !_internet;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Giao dịch thông qua tổng đài ',
                          style: body2,
                        ),
                        CupertinoSwitch(
                          value: _hotline,
                          onChanged: (bool value) {
                            setState(() {
                              _hotline = !_hotline;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _hotline,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: state.formKeyPassPin,
                        child: AppTextFieldWidget(
                          validator: (pass) => checkNewPass(pass!),
                          inputController: state.passPinController,
                          hintText: "Đăng ký mật khẩu giao dịch qua điện thoại",
                          onChanged: (pass) {
                            state.formKeyPassPin.currentState?.validate();
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Dịch vụ nhận thông báo qua email',
                          style: body2,
                        ),
                        CupertinoSwitch(
                          value: isOpenPin,
                          onChanged: (bool value) {
                            setState(() {
                              isOpenPin = !isOpenPin;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Dịch vụ ứng tiền bán chứng khoán',
                          style: body2,
                        ),
                        CupertinoSwitch(
                          value: _money,
                          onChanged: (bool value) {
                            setState(() {
                              _money = !_money;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 23),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Loại tài khoản',
                          style: body1?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          height: 32,
                          decoration: BoxDecoration(
                              color: AppColors.grey_tab,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: AccountEnums.values
                                .map((e) => GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          accountEnums = e;
                                          // mở tài khoản thường
                                          if (accountEnums ==
                                              AccountEnums.normal) {
                                            state.isOpenMargin = false;
                                          }
                                          // mở cả tk thường và margin
                                          else {
                                            state.isOpenMargin = true;
                                          }
                                        });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 24,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: e == accountEnums
                                                ? AppColors.primary
                                                : null),
                                        child: Text(
                                          e.name,
                                          style: caption?.copyWith(
                                              color: e == accountEnums
                                                  ? AppColors.white
                                                  : AppColors.textGrey4),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Divider(
                      height: 32,
                      thickness: 1,
                      color: AppColors.grayF2,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(16),
                    decoration:
                        const BoxDecoration(color: AppColors.white, boxShadow: [
                      BoxShadow(
                          offset: Offset(0, -0.5),
                          blurRadius: 8,
                          color: Color.fromRGBO(0, 0, 0, 0.03)),
                      BoxShadow(
                          offset: Offset(0, -1),
                          blurRadius: 10,
                          color: Color.fromRGBO(0, 0, 0, 0.04)),
                    ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).bank_name,
                          style: body1?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 16),
                        Obx(() {
                          return AppTextTypeHead<Bank>(
                            inputController: state.bankController,
                            hintText: S.of(context).bank,
                            focusNode: state.bankNode,
                            errorText: state.errorBank.value,
                            suggestionsCallback: (String bank) {
                              return logic.searchBank(bank);
                            },
                            label: S.of(context).bank,
                            onSuggestionSelected: (suggestion) {
                              // chọn ngân hàng
                              state.bankController.text =
                                  suggestion.cBANKCODE ?? "";
                              state.bankAccountController.clear();
                              state.bankBranhController.clear();
                              state.errorBank.value = null;
                              FocusScope.of(context).unfocus();
                            },
                          );
                        }),
                        const SizedBox(height: 16),
                        Form(
                          key: state.formKeyBankAccount,
                          child: AppTextFieldWidget(
                            hintText: S.of(context).bank_account,
                            inputController: state.bankAccountController,
                            textInputType: TextInputType.number,
                            label: S.of(context).bank_account,
                            isShowLabel: false,
                            onChanged: (account) {
                              state.formKeyBankAccount.currentState?.validate();
                            },
                            validator: (account) {
                              return checkAccount(account!);
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        AppTextFieldWidget(
                          inputController: state.bankBranhController,
                          hintText: S.of(context).branch,
                          label: S.of(context).branch,
                          isShowLabel: false,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ButtonFill(
                            voidCallback: () {
                              // kiểm tra mật khẩu pin
                              if (!isOpenPin &&
                                  !(state.formKeyPassPin.currentState
                                          ?.validate() ??
                                      true)) return;
                              if (state.bankController.text.isEmpty) {
                                state.errorBank.value =
                                    "Vui lòng chọn ngân hàng";
                                return;
                              }
                              if (state.errorBank.value != null) return;
                              if (!state.formKeyBankAccount.currentState!
                                  .validate()) return;
                              Get.to(const PolicyPage());
                            },
                            title: S.of(context).continue_step)),
                  ),
                  const SizedBox(height: 32),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
