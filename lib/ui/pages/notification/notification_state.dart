import 'package:get/get.dart';

import '../../../model/entities/notify.dart';

class NotificationState {
  // biến đếm số tin nhắn chưa đọc
  int get count {
    int _count = 0;
    listNotifyAll.forEach((element) {
      if (element.isRead == "0") _count++;
    });
    listNotifyAccount.forEach((element) {
      if (element.isRead == "0") _count++;
    });
    return _count;
  }

  final listNotifyAll = <Notify>[].obs;

  final listNotifyAccount = <Notify>[].obs;

  NotificationState() {}
}
