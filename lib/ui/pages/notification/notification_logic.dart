import 'package:get/get.dart';

import '../../../services/index.dart';
import 'notification_state.dart';

class NotificationLogic extends GetxController {
  final NotificationState state = NotificationState();

  final ApiService apiService = Get.find();
  final AuthService authService = Get.find();

  void loadListNotifyAll() {}
}
