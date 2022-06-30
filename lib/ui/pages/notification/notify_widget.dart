import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_images.dart';
import 'package:sbsi/model/entities/notify.dart';
import 'package:sbsi/ui/pages/notification/notification_logic.dart';

class NotifyWidget extends StatelessWidget {
  final Notify notify;

  const NotifyWidget({Key? key, required this.notify}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final body1 = Theme.of(context).textTheme.bodyText1;
    final body2 = Theme.of(context).textTheme.bodyText2;
    final caption = Theme.of(context).textTheme.caption;
    return GestureDetector(
      onTap: () {
        Get.find<NotificationLogic>().makerRead(notify.id ?? "");
      },
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 15),
        decoration: BoxDecoration(
            color: notify.isRead == "0" ? AppColors.grey_tab : null),
        child: Row(
          children: [
            SvgPicture.asset(AppImages.email),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notify.title ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: body1?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    notify.bodyDetail ?? "",
                    style: body2,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    notify.dateTime ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: caption?.copyWith(color: AppColors.textSecond),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
