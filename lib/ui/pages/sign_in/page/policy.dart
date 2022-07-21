import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

import '../../../../common/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../commons/appbar.dart';
import 'package:flutter/src/painting/basic_types.dart' as bt;

class PolicySignUpPage extends StatefulWidget {
  const PolicySignUpPage({Key? key}) : super(key: key);

  @override
  State<PolicySignUpPage> createState() => _PolicySignUpPageState();
}

class _PolicySignUpPageState extends State<PolicySignUpPage> {
  late PdfController pdfController;

  @override
  void initState() {
    pdfController = PdfController(
        document: PdfDocument.openAsset('assets/json/DKSD.pdf'),
        viewportFraction: 1);
    super.initState();
  }


  @override
  void dispose() {
    pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBack,
      resizeToAvoidBottomInset: false,
      appBar: AppBarCustom(
        title: S.of(context).policy,
        isCenter: true,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: PdfView(
          controller: pdfController,
          errorBuilder: (error) {
            return const SizedBox();
          },
          documentLoader: const Center(child: CircularProgressIndicator()),
          scrollDirection: bt.Axis.vertical,

        ),
      ),
    );
  }
}


