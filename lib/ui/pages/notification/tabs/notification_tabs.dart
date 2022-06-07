import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/ui/pages/notification/notification_logic.dart';
import 'package:sbsi/ui/pages/notification/notify_widget.dart';

import '../../../../generated/l10n.dart';

class NotificationTabs extends StatefulWidget {
  const NotificationTabs({Key? key}) : super(key: key);

  @override
  State<NotificationTabs> createState() => _NotificationTabsState();
}

class _NotificationTabsState extends State<NotificationTabs>
    with AutomaticKeepAliveClientMixin {
  final state = Get.find<NotificationLogic>().state;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(() {
      if(state.listNotifyAll.isEmpty){
        return Center(
          child: Text(S.of(context).notify_empty,style: Theme.of(context).textTheme.bodyText1,),
        );
      }
      return ListView.separated(
          itemBuilder: (context, index) {
            var notify = state.listNotifyAll[index];
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
          itemCount: state.listNotifyAll.length);
    });
  }

  @override
  bool get wantKeepAlive => true;
}
