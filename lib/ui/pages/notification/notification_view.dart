import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/generated/l10n.dart';
import 'package:sbsi/ui/commons/appbar.dart';
import 'package:sbsi/ui/pages/notification/tabs/notification_tabs.dart';
import 'notification_logic.dart';
import 'tabs/notify_tabs.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final logic = Get.find<NotificationLogic>();
  final state = Get.find<NotificationLogic>().state;

  List<String> listTabs(BuildContext context) =>
      [S.of(context).account, S.of(context).news];

  @override
  void initState() {
    logic.loadListNotifyAll();
    logic.loadListNotifyAccount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final body1 = Theme.of(context).textTheme.bodyText1;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.whiteBack,
        appBar: AppBarCustom(
          title: S.of(context).notification,
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Stack(
              fit: StackFit.passthrough,
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppColors.grayF2, width: 2.0),
                    ),
                  ),
                ),
                TabBar(
                    indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 3)),
                    labelStyle: body1?.copyWith(fontWeight: FontWeight.w700),
                    labelColor: Theme.of(context).primaryColor,
                    unselectedLabelStyle: body1,
                    indicatorPadding: EdgeInsets.zero,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: AppColors.textGrey,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    labelPadding: const EdgeInsets.only(bottom: 8),
                    indicatorWeight: 0,
                    onTap: (value) {},
                    tabs: listTabs(context)
                        .map((e) => Center(child: Text(e)))
                        .toList()),
              ],
            ),
            const SizedBox(height: 20),
            const Expanded(
                child: TabBarView(
              children: [NotifyTabs(), NotificationTabs()],
            ))
          ],
        ),
      ),
    );
  }
}
