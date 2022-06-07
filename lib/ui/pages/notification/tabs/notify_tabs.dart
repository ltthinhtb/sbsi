import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../notification_logic.dart';
import '../notify_widget.dart';

class NotifyTabs extends StatefulWidget {
  const NotifyTabs({Key? key}) : super(key: key);

  @override
  State<NotifyTabs> createState() => _NotifyTabsState();
}

class _NotifyTabsState extends State<NotifyTabs> with AutomaticKeepAliveClientMixin{
  final state = Get.find<NotificationLogic>().state;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(() {
      return ListView.separated(
          itemBuilder: (context, index) {
            var notify = state.listNotifyAccount[index];
            return NotifyWidget(notify: notify);
          },
          separatorBuilder: (context, index) {
            return const Divider(
              height: 32,
              thickness: 1,
              indent: 66,
              endIndent: 15,
            );
          },
          itemCount: state.listNotifyAccount.length);
    });
  }

  @override
  bool get wantKeepAlive => true;
}
