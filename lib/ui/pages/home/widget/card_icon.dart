import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sbsi/common/app_images.dart';

import '../../../../common/app_colors.dart';
import '../../../../generated/l10n.dart';

class CardIcon extends StatelessWidget {
  const CardIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration:  BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            const BoxShadow(blurRadius: 0, color: Color.fromRGBO(0, 0, 0, 0.10)),
            const BoxShadow(blurRadius: 4, color: Color.fromRGBO(0, 0, 0, 0.10)),
            const BoxShadow(blurRadius: 20, color: Color.fromRGBO(0, 0, 0, 0.10))
          ],
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Row(
        children: [
          iconButton(context,
              title: S.of(context).transfer,
              image: AppImages.transfer,
              onTap: () {}),
          iconButton(context,
              title: S.of(context).bond, image: AppImages.bond, onTap: () {}),
          iconButton(context,
              title: S.of(context).payment,
              image: AppImages.payment,
              onTap: () {}),
          iconButton(context,
              title: S.of(context).statement,
              image: AppImages.history,
              onTap: () {})
        ],
      ),
    );
  }

  Widget iconButton(BuildContext context,
      {required String image,
      required String title,
      required VoidCallback onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.grayF4,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: SvgPicture.asset(image)),
            const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.caption?.copyWith(
                fontWeight: FontWeight.w700
              ),
            )
          ],
        ),
      ),
    );
  }
}
