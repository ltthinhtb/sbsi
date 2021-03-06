import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sbsi/common/app_images.dart';
import 'package:sbsi/ui/commons/app_snackbar.dart';
import 'package:sbsi/ui/pages/sign_up/sign_up_logic.dart';
import 'package:signature/signature.dart';
import '../../../../common/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../commons/appbar.dart';
import '../../../widgets/button/button_filled.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/src/painting/basic_types.dart' as bt;

class PolicyPage extends StatefulWidget {
  const PolicyPage({Key? key}) : super(key: key);

  @override
  State<PolicyPage> createState() => _PolicyPageState();
}

class _PolicyPageState extends State<PolicyPage> {
  final state = Get.find<SignUpLogic>().state;
  final logic = Get.find<SignUpLogic>();

  Uint8List signatureFile = Uint8List.fromList([]);

  late PdfController pdfController;

  @override
  void initState() {
    state.signatureUrl = "";
    state.signature.clear();
    pdfController =
        PdfController(document: PdfDocument.openAsset('assets/json/MTK.pdf'));
    super.initState();
  }

  @override
  void dispose() {
    pdfController.dispose();
    super.dispose();
  }

  ValueNotifier<bool> isAccept = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'B?????c 5: ${S.of(context).policy}',
                      style: headline6?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 26.5),
                  Expanded(
                    child: PdfView(
                      controller: pdfController,
                      errorBuilder: (error) {
                        return const SizedBox();
                      },
                      documentLoader: const CircularProgressIndicator(),
                      scrollDirection: bt.Axis.vertical,
                    ),
                  ),
                  Row(
                    children: [
                      Theme(
                        data: Theme.of(context).copyWith(
                          unselectedWidgetColor: AppColors.primary,
                          toggleableActiveColor: AppColors.primary,
                        ),
                        child: ValueListenableBuilder<bool>(
                            builder:
                                (BuildContext context, value, Widget? child) {
                              return Checkbox(
                                  value: value,
                                  onChanged: (value) {
                                    isAccept.value = value!;
                                  });
                            },
                            valueListenable: isAccept),
                      ),
                      Flexible(child: Text(S.of(context).accept_policy_hint))
                    ],
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ButtonFill(
                            voidCallback: () {
                              if (isAccept.value) {
                                showBottomSheet();
                              } else {
                                AppSnackBar.showError(
                                    message: S.current.valid_accept);
                              }
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
    );
  }

  void showBottomSheet() {
    Get.bottomSheet(
      Builder(builder: (context) {
        final body1 = Theme.of(context).textTheme.bodyText1;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(20)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 24),
                Center(
                  child: Text(
                    "K?? h???p ?????ng",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 24),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          text:
                              'Qu?? kh??ch vui l??ng ch???m v??o khung b??n d?????i v?? gi??? ????? k??',
                          style: body1)
                    ])),
                const SizedBox(height: 24),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Stack(
                    children: [
                      Signature(
                        controller: state.signature,
                        height: 335 / 812 * MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        backgroundColor: AppColors.whiteBack,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, right: 10),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                              onTap: () {
                                state.signature.clear();
                              },
                              child: SvgPicture.asset(AppImages.refresh)),
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
                      title: S.of(context).cancel_short,
                      style: ElevatedButton.styleFrom(
                          onPrimary: AppColors.primary,
                          primary: const bt.Color.fromRGBO(255, 238, 238, 1)),
                    )),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: ButtonFill(
                            voidCallback: () async {
                              var bytes = await state.signature.toPngBytes();
                              if (bytes != null) {
                                signatureFile = bytes;
                                await logic.uploadSignatureImage(
                                    signNatureFile: signatureFile);

                                // m??? tk
                                await logic.openAccount();
                              }
                            },
                            title: S.of(context).confirm))
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
  }

  Future<String> getFilePath(uniqueFileName) async {
    String path = '';

    Directory dir = await getApplicationDocumentsDirectory();

    path = '${dir.path}/$uniqueFileName.pdf';

    return path;
  }
}
