import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sbsi/common/app_images.dart';
import 'package:sbsi/ui/pages/sign_up/sign_up_logic.dart';
import 'package:signature/signature.dart';

import '../../../../common/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../commons/appbar.dart';
import '../../../widgets/button/button_filled.dart';

class PolicyPage extends StatefulWidget {
  const PolicyPage({Key? key}) : super(key: key);

  @override
  State<PolicyPage> createState() => _PolicyPageState();
}

class _PolicyPageState extends State<PolicyPage> {
  final state = Get.find<SignUpLogic>().state;
  final logic = Get.find<SignUpLogic>();

  Uint8List signatureFile = Uint8List.fromList([]);

  @override
  void initState() {
    state.signatureUrl = "";
    state.signature.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
    final body1 = Theme.of(context).textTheme.bodyText1;
    return Scaffold(
      backgroundColor: AppColors.whiteBack,
      resizeToAvoidBottomInset: false,
      appBar: AppBarCustom(
        title: S.of(context).policy,
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
              percent: 1,
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
                        'Bước 5: ${S.of(context).policy}',
                        style: headline6?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 26.5),
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
                        children: [],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ButtonFill(
                              voidCallback: () {
                                Get.bottomSheet(
                                  Builder(builder: (context) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const SizedBox(height: 24),
                                            Center(
                                              child: Text(
                                                "Ký hợp đồng",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w700),
                                              ),
                                            ),
                                            const SizedBox(height: 24),
                                            RichText(
                                                textAlign: TextAlign.center,
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                      text:
                                                          'Quý khách vui lòng chạm vào khung bên dưới và giữ để ký hoặc ',
                                                      style: body1),
                                                  TextSpan(
                                                      text: 'Tải ảnh lên',
                                                      style: body1?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          color:
                                                              AppColors.active))
                                                ])),
                                            const SizedBox(height: 24),
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: Stack(
                                                children: [
                                                  Signature(
                                                    controller: state.signature,
                                                    height: 335 /
                                                        812 *
                                                        MediaQuery.of(context)
                                                            .size
                                                            .height,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    backgroundColor:
                                                        AppColors.whiteBack,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10, right: 10),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: GestureDetector(
                                                          onTap: () {
                                                            state.signature
                                                                .clear();
                                                          },
                                                          child: SvgPicture
                                                              .asset(AppImages
                                                                  .refresh)),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 32),
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: ButtonFill(
                                                  voidCallback: () {
                                                    Get.back();
                                                  },
                                                  title: S
                                                      .of(context)
                                                      .cancel_short,
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          onPrimary:
                                                              AppColors.primary,
                                                          primary: const Color
                                                                  .fromRGBO(255,
                                                              238, 238, 1)),
                                                )),
                                                const SizedBox(
                                                  width: 16,
                                                ),
                                                Expanded(
                                                    child: ButtonFill(
                                                        voidCallback: () async {
                                                          var bytes =
                                                              await state
                                                                  .signature
                                                                  .toPngBytes();
                                                          if (bytes != null) {
                                                            signatureFile =
                                                                bytes;
                                                            await logic.uploadSignatureImage(
                                                                signNatureFile:
                                                                    signatureFile);

                                                            // mở tk
                                                            await logic
                                                                .openAccount();
                                                          }
                                                        },
                                                        title: S
                                                            .of(context)
                                                            .confirm))
                                              ],
                                            ),
                                            const SizedBox(height: 32),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                  isScrollControlled: true,
                                  ignoreSafeArea: false, // add this
                                );
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
