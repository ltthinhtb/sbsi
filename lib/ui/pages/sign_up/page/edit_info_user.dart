import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sbsi/ui/pages/sign_up/sign_up_logic.dart';
import 'package:sbsi/ui/widgets/textfields/app_text_field.dart';

import '../../../../common/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../commons/appbar.dart';
import '../../../widgets/button/button_filled.dart';
import 'service_page.dart';

class EditInfo extends StatefulWidget {
  const EditInfo({Key? key}) : super(key: key);

  @override
  State<EditInfo> createState() => _EditInfoState();
}

class _EditInfoState extends State<EditInfo> {
  final state = Get.find<SignUpLogic>().state;

  final nameController = TextEditingController();
  final genderController = TextEditingController();
  final iDCardController = TextEditingController();
  final issueDateController = TextEditingController();
  final issuePlaceController = TextEditingController();

  final cityController = TextEditingController();
  final districtController = TextEditingController();
  final wardController = TextEditingController();

  bool get isEmptyGender {
    if (state.orcResponse?.gender == null) return true;
    if (state.orcResponse?.gender == "-") return true;
    return state.orcResponse!.gender!.isEmpty;
  }

  @override
  void initState() {
    nameController.text = state.orcResponse?.name ?? "";
    genderController.text = state.orcResponse?.gender ?? "";
    iDCardController.text = state.orcResponse?.id ?? "";
    issueDateController.text = state.orcResponse?.issueDate ?? "";
    issuePlaceController.text =
        state.orcResponse?.issuePlace?.replaceAll("\n", ", ") ?? "";

    cityController.text = state.orcResponse?.postCode?.first.city?[1] ?? "";
    districtController.text =
        state.orcResponse?.postCode?.first.district?[1] ?? "";
    wardController.text = state.orcResponse?.postCode?.first.ward?[1] ?? "";
    state.addressController.text =
        state.orcResponse?.recentLocation?.replaceAll("\n", ", ") ?? "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
    final body1 = Theme.of(context).textTheme.bodyText1;
    return Scaffold(
      backgroundColor: AppColors.whiteBack,
      appBar: AppBarCustom(
        title: S.of(context).add_info,
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
                percent: 0.6,
                padding: EdgeInsets.zero,
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Bước 3: ${S.of(context).add_info}',
                        style: headline6?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
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
                            S.of(context).profile_info,
                            style: body1?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 16),
                          AppTextFieldWidget(
                            inputController: nameController,
                            label: S.of(context).full_name,
                            isShowLabel: false,
                            readOnly: true,
                            enable: false,
                            fillColor: AppColors.disable,
                            filled: true,
                          ),
                          const SizedBox(height: 16),
                          AppTextFieldWidget(
                            inputController: genderController,
                            label: S.of(context).gender,
                            isShowLabel: false,
                            readOnly: isEmptyGender ? false : true,
                            enable: isEmptyGender ? true : false,
                            fillColor: AppColors.disable,
                            filled: isEmptyGender ? false : true,
                          ),
                          const SizedBox(height: 16),
                          AppTextFieldWidget(
                            inputController: iDCardController,
                            label: 'Số CMND/CCCD',
                            isShowLabel: false,
                            readOnly: true,
                            enable: false,
                            fillColor: AppColors.disable,
                            filled: true,
                          ),
                          const SizedBox(height: 16),
                          AppTextFieldWidget(
                            inputController: issuePlaceController,
                            label: S.of(context).issue_loc,
                            isShowLabel: false,
                            readOnly: true,
                            maxLines: 2,
                            enable: false,
                            fillColor: AppColors.disable,
                            filled: true,
                          ),
                          const SizedBox(height: 16),
                          AppTextFieldWidget(
                            inputController: issueDateController,
                            label: S.of(context).issue_date_cmt,
                            isShowLabel: false,
                            readOnly: true,
                            enable: false,
                            fillColor: AppColors.disable,
                            filled: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
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
                            S.of(context).account_info,
                            style: body1?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 16),
                          AppTextFieldWidget(
                            inputController: cityController,
                            label: "Thành phố",
                            isShowLabel: false,
                          ),
                          const SizedBox(height: 16),
                          AppTextFieldWidget(
                            inputController: districtController,
                            label: "Quân/huyện",
                            isShowLabel: false,
                          ),
                          const SizedBox(height: 16),
                          AppTextFieldWidget(
                            inputController: wardController,
                            label: 'Phường/xã',
                            isShowLabel: false,
                          ),
                          const SizedBox(height: 16),
                          AppTextFieldWidget(
                            inputController: state.addressController,
                            label: "Địa chỉ",
                            isShowLabel: false,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ButtonFill(
                              voidCallback: () {
                                Get.to(const ServicePage());
                              },
                              title: S.of(context).continue_step)),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
