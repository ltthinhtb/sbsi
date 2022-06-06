import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_images.dart';
import 'package:sbsi/services/auth_service.dart';
import 'package:sbsi/ui/commons/appbar.dart';

import '../../../common/app_colors.dart';
import '../../../generated/l10n.dart';
import '../../../utils/money_utils.dart';
import '../wallet/wallet_logic.dart';
import 'guide_payment_logic.dart';

class GuidePaymentPage extends StatefulWidget {
  const GuidePaymentPage({Key? key}) : super(key: key);

  @override
  _GuidePaymentPageState createState() => _GuidePaymentPageState();
}

class _GuidePaymentPageState extends State<GuidePaymentPage> {
  final logic = Get.put(GuidePaymentLogic());
  final state = Get.find<GuidePaymentLogic>().state;

  @override
  Widget build(BuildContext context) {
    final body2 = Theme.of(context).textTheme.bodyText2;
    final headline6 = Theme.of(context).textTheme.headline6;
    final caption = Theme.of(context).textTheme.caption;

    return Scaffold(
      appBar: AppBarCustom(
        title: S.of(context).payment_guide,
        isCenter: true,
      ),
      backgroundColor: AppColors.whiteBack,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    boxShadow: [
                      const BoxShadow(
                          blurRadius: 10,
                          color: const Color.fromRGBO(0, 0, 0, 0.08),
                          offset: Offset(0, 4))
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    SvgPicture.asset(AppImages.ic_money),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).cash_availability,
                          style: body2?.copyWith(
                            color: AppColors.textSecond,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Obx(() {
                          var accountStatus =
                              Get.find<WalletLogic>().state.totalAssets.value;

                          return Text(
                            MoneyFormat.formatMoneyRound(
                                    '${accountStatus.totalNav}') +
                                " đ",
                            style: headline6?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.active),
                          );
                        })
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    boxShadow: [
                      const BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 20,
                          color: Color.fromRGBO(0, 0, 0, 0.05)),
                    ],
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).beneficiary,
                      style: body2?.copyWith(color: AppColors.textSecond),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      'CTCP Chung khoan SBSI',
                      style: body2?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 4),
                    const Divider(
                      thickness: 1,
                      height: 20,
                    ),
                    Text(
                      S.of(context).payment_title,
                      style: body2?.copyWith(color: AppColors.textSecond),
                    ),
                    const SizedBox(height: 12),
                    Obx(() {
                      return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var bank = state.listBankAcc[index];
                          return Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      bank.stk ?? "",
                                      style: caption?.copyWith(
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      bank.branch ?? "",
                                      style: caption?.copyWith(
                                          color: AppColors.textSecond),
                                    )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Clipboard.setData(ClipboardData(
                                          text: bank.branch ?? ""))
                                      .then((value) {
                                    Fluttertoast.showToast(
                                        msg:
                                            "${S.of(context).copy} ${S.of(context).user_name}");
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.fromLTRB(
                                      10.52, 3.68, 11.48, 5.32),
                                  decoration: BoxDecoration(
                                      color: AppColors.buttonOrange,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    S.of(context).copy,
                                    style: caption?.copyWith(
                                        color: AppColors.white),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            height: 32,
                            thickness: 1,
                          );
                        },
                        itemCount: state.listBankAcc.length,
                        shrinkWrap: true,
                      );
                    })
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      const BoxShadow(
                          offset: Offset(0, 4),
                          color: Color.fromRGBO(0, 0, 0, 0.05),
                          blurRadius: 20)
                    ]),
                child: Obx(() {
                  var account = Get.find<AuthService>().token.value;
                  return Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).content_transfer,
                              style: caption?.copyWith(
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${S.of(context).payment_on_account} 088C${account?.data?.user ?? ""}",
                              style: caption?.copyWith(
                                  color: AppColors.textSecond),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(
                                  text:
                                      "${S.of(context).payment_on_account} 088C${account?.data?.user ?? ""}"))
                              .then((value) {
                            Fluttertoast.showToast(
                                msg:
                                    "${S.of(context).copy} ${S.of(context).content_transfer}");
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(
                              10.52, 3.68, 11.48, 5.32),
                          decoration: BoxDecoration(
                              color: AppColors.buttonOrange,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            S.of(context).copy,
                            style: caption?.copyWith(color: AppColors.white),
                          ),
                        ),
                      )
                    ],
                  );
                }),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<GuidePaymentLogic>();
    super.dispose();
  }
}
