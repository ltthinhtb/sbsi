import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/l10n.dart';
import '../notification_logic.dart';
import '../notify_widget.dart';

class NotifyTabs extends StatefulWidget {
  const NotifyTabs({Key? key}) : super(key: key);

  @override
  State<NotifyTabs> createState() => _NotifyTabsState();
}

class _NotifyTabsState extends State<NotifyTabs>
    with AutomaticKeepAliveClientMixin {
  final state = Get.find<NotificationLogic>().state;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(() {
      if (state.listNotifyAccount.isEmpty) {
        return Center(
          child: Text(
            S.of(context).notify_empty,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        );
      }
      return ListView.separated(
          itemBuilder: (context, index) {
            var notify = state.listNotifyAccount[index];
            return NotifyWidget(notify: notify);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 5,
            );
          },
          itemCount: state.listNotifyAccount.length);
    });
  }

  @override
  bool get wantKeepAlive => true;
}
