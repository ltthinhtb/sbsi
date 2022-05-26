import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sbsi/ui/widgets/dropdown/app_drop_down.dart';
import 'package:sbsi/ui/widgets/textfields/app_text_field.dart';

import '../../../../common/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../commons/appbar.dart';
import '../../../widgets/button/button_filled.dart';
import '../enum/enums.dart';
import '../sign_up_logic.dart';
import 'policy_page.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({Key? key}) : super(key: key);

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  bool _internet = false;
  bool _hotline = false;

  bool _email = false;
  bool _money = false;

  AccountEnums accountEnums = AccountEnums.normal;

  final logic = Get.put(SignUpLogic());
  final state = Get.find<SignUpLogic>().state;

  @override
  void initState() {
    logic.getListBank();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
    final body2 = Theme.of(context).textTheme.bodyText2;
    final body1 = Theme.of(context).textTheme.bodyText1;
    final caption = Theme.of(context).textTheme.caption;

    return Scaffold(
      backgroundColor: AppColors.whiteBack,
      resizeToAvoidBottomInset: false,
      appBar: AppBarCustom(
        title: S.of(context).service_register,
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
              percent: 0.8,
              padding: EdgeInsets.zero,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
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
                      child: const Padding(
                        padding: EdgeInsets.all(16),
                        child: AppTextFieldWidget(
                          hintText: "Đăng ký mật khẩu giao dịch qua điện tho",
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
                            value: _email,
                            onChanged: (bool value) {
                              setState(() {
                                _email = !_email;
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
                            style: body2?.copyWith(fontWeight: FontWeight.w700),
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
                      decoration: const BoxDecoration(
                          color: AppColors.white,
                          boxShadow: [
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
                          AppDropDownWidget(
                            items: [],
                            hintText: S.of(context).bank_choose,
                          ),
                          const SizedBox(height: 16),
                          AppTextFieldWidget(
                            hintText: S.of(context).bank_account,
                          )
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
                                Get.to(const PolicyPage());
                              },
                              title: S.of(context).continue_step)),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
