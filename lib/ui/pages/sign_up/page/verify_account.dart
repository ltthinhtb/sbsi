import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sbsi/common/app_images.dart';
import 'package:sbsi/model/entities/orc_model.dart';

import '../../../../common/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../commons/appbar.dart';
import '../../../widgets/button/button_filled.dart';
import '../sign_up_logic.dart';
import 'edit_info_user.dart';

class VerifyAccount extends StatefulWidget {
  const VerifyAccount({Key? key}) : super(key: key);

  @override
  State<VerifyAccount> createState() => _VerifyAccountState();
}

class _VerifyAccountState extends State<VerifyAccount> {
  final logic = Get.put(SignUpLogic());
  final state = Get.find<SignUpLogic>().state;

  ValueNotifier<File> frontImage = ValueNotifier<File>(File(""));
  ValueNotifier<File> backImage = ValueNotifier<File>(File(""));
  ValueNotifier<File> faceImage = ValueNotifier<File>(File(""));

  @override
  void initState() {
    // clear dữ liệu
    state.orcResponse = null;
    state.cardFrontUrl = "";
    state.cardBackUrl = "";
    state.faceUrl = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
    final body1 = Theme.of(context).textTheme.bodyText1;
    final body2 = Theme.of(context).textTheme.bodyText2;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarCustom(
        title: S.of(context).verify_account,
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
                percent: 0.4,
                padding: EdgeInsets.zero,
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Bước 2: Xác thực tài khoản',
                  style: headline6?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 26),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    SvgPicture.asset(AppImages.camera),
                    const SizedBox(width: 8),
                    Text(
                      'Chụp ảnh giấy tờ',
                      style: headline6?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          height: 24 / 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Vui lòng sử dụng cùng 1 loại giấy tờ để chụp ảnh mặt trước và mặt sau',
                  style: headline6?.copyWith(fontSize: 14, height: 20 / 14),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: ValueListenableBuilder<File>(
                              builder:
                                  (BuildContext context, file, Widget? child) {
                                if (file.path.isEmpty) return child!;
                                return Image.file(file);
                              },
                              valueListenable: frontImage,
                              child: SvgPicture.asset(
                                AppImages.idCard1,
                              ),
                            )),
                        const SizedBox(height: 6.5),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(AppImages.camera1),
                            const SizedBox(width: 6.5),
                            Text(
                              'Chụp ảnh',
                              style: body1?.copyWith(
                                  color: AppColors.buttonOrange),
                            )
                          ],
                        )
                      ],
                    )),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: Column(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: ValueListenableBuilder<File>(
                              builder:
                                  (BuildContext context, file, Widget? child) {
                                if (file.path.isEmpty) return child!;
                                return Image.file(file);
                              },
                              valueListenable: backImage,
                              child: SvgPicture.asset(
                                AppImages.idCard2,
                              ),
                            )),
                        const SizedBox(height: 6.5),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(AppImages.camera1),
                            const SizedBox(width: 6.5),
                            Text(
                              'Chụp ảnh',
                              style: body1?.copyWith(
                                  color: AppColors.buttonOrange),
                            )
                          ],
                        )
                      ],
                    ))
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    SvgPicture.asset(AppImages.user_image1),
                    const SizedBox(width: 8),
                    Text('Xác thực khuôn mặt',
                        style: body1?.copyWith(fontWeight: FontWeight.w700))
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('Chỉ cần 1 phút để thực hiện',
                    style: body2?.copyWith(height: 20 / 14)),
              ),
              const SizedBox(height: 16),
              Center(
                child: ValueListenableBuilder<File>(
                    builder: (BuildContext context, file, Widget? child) {
                      if (file.path.isEmpty) return child!;
                      return Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: AppColors.textGrey, width: 5),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: FileImage(file), fit: BoxFit.cover)),
                      );
                    },
                    valueListenable: faceImage,
                    child: SvgPicture.asset(AppImages.user_big)),
              ),
              const SizedBox(height: 16),
              Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                  decoration: BoxDecoration(
                    color: AppColors.PastelSecond2,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(AppImages.camera1),
                      const SizedBox(width: 6.5),
                      Text(
                        'Chụp ảnh',
                        style: body1?.copyWith(color: AppColors.buttonOrange),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ButtonFill(
                        voidCallback: () {
                          // nếu chưa làm ekyc hoặc ekyc thất bại
                          if (state.orcResponse == null) {
                            Get.bottomSheet(
                              Builder(builder: (context) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(height: 24),
                                        Center(
                                          child: Text(
                                            S.of(context).guide_take,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w700),
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                        Text(
                                          "Quý khách vui lòng đảm bảo hình chụp:",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w700),
                                        ),
                                        const SizedBox(height: 15),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                AppImages.tick_circle),
                                            const SizedBox(width: 10),
                                            Text(
                                              "Không bị mờ, tối hay chói sáng",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 12),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                AppImages.tick_circle),
                                            const SizedBox(width: 10),
                                            Text(
                                              "Không bị mất góc, bấm lỗ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 12),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                AppImages.tick_circle),
                                            const SizedBox(width: 10),
                                            Text(
                                              "Là bản gốc, còn hạn sử dụng",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 24),
                                        SvgPicture.asset(
                                            'assets/icon_svg/cmnd_bad.svg',
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            fit: BoxFit.fitWidth),
                                        const SizedBox(height: 32),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: ButtonFill(
                                                voidCallback: () {
                                                  nativeCode();
                                                },
                                                title: S
                                                    .of(context)
                                                    .continue_step)),
                                        const SizedBox(height: 29),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                              isScrollControlled: true,
                              ignoreSafeArea: false, // add this
                            );
                            return;
                          }
                          // thành công ekyc
                          Get.to(const EditInfo());
                        },
                        title: S.of(context).continue_step)),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> nativeCode() async {
    const platform = MethodChannel('com.vnpt.ekyc/sdk');
    try {
      // clear image cache
      imageCache?.clear();
      String result = await platform.invokeMethod('startEKYC');
      var mapData = jsonDecode(result);
      frontImage.value = File(mapData['imageFront']);
      backImage.value = File(mapData['imageBack']);
      faceImage.value = File(mapData['imageFace']);
      state.orcResponse =
          OrcResponse.fromJson(jsonDecode(mapData['jsonInfo'])['object']);
      await logic.uploadUrlImage(
          frontIDByte: frontImage.value.readAsBytesSync().toList(),
          backIDByte: backImage.value.readAsBytesSync().toList(),
          faceByte: faceImage.value.readAsBytesSync().toList());
      Get.back();
    } on PlatformException catch (e) {
      Logger().e(e.toString());
    }
  }
}
