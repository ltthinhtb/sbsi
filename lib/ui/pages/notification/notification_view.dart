import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/ui/commons/appbar.dart';
import 'notification_logic.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final logic = Get.put(NotificationLogic());
  final state = Get.find<NotificationLogic>().state;

  List<String> listTabs(BuildContext context) =>
      [S.of(context).notice, S.of(context).news];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBarCustom(
          title: S.of(context).notification,
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration:  BoxDecoration(
                color: AppColors.grayF2,
                borderRadius: BorderRadius.circular(9)
              ),
              child: TabBar(
                tabs: listTabs(context).map((tab) => Center(child: Text(tab))).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<NotificationLogic>();
    super.dispose();
  }
}
