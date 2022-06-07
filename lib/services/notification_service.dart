import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/src/platform_specifics/android/enums.dart'
    as enums;
import 'package:sbsi/router/route_config.dart';
import 'package:sbsi/ui/commons/app_dialog.dart';
import 'package:sbsi/ui/pages/notification/notification_logic.dart';
import 'package:sbsi/utils/logger.dart';

class NotificationService extends GetxService {
  String? token;

  //Singleton pattern
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  //instance of FlutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void _requestIOSPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    await AppDiaLog.showNoticeDialog(
        middleText: "Ok",
        onConfirm: () {
          if (Get.isRegistered<NotificationLogic>())
          {
            Get.toNamed(RouteConfig.notification);
          }
        });
  }

  Future<NotificationService> init() async {
    //Initialization Settings for Android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');

    //Initialization Settings for iOS
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestSoundPermission: false,
            requestBadgePermission: false,
            requestAlertPermission: false,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    //InitializationSettings for initializing settings for both platforms (Android & iOS)
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    _requestIOSPermission();

    await _configFirebaseNotification();

    return this;
  }

  void setup() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      logger.i('Got a onMessageOpenedApp whilst in the foreground!');
      if (Get.isRegistered<NotificationLogic>())
        {
          Get.toNamed(RouteConfig.notification);
        }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      NotificationService().showNotification(message);
    });
    setupInteractedMessage();
  }

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      logger.i('Got a Terminal whilst in the foreground!');
      if (Get.isRegistered<NotificationLogic>())
      {
        Get.toNamed(RouteConfig.notification);
      }
    }
  }

  void fcmSubscribe(String topic) {
    FirebaseMessaging.instance.subscribeToTopic(topic);
  }

  void fcmUnSubscribe(String topic) {
    FirebaseMessaging.instance.unsubscribeFromTopic(topic);
  }

  Future<void> _configFirebaseNotification() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    try {
      await messaging.getToken().then((value) {
        logger.i("token ==========> $value");
        token = value;
      });
    } catch (e) {
      logger.e(e.toString());
    }
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  void showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    await flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification?.title,
        notification?.body,
        NotificationDetails(
            android: _androidNotificationDetails, iOS: _iosNotificationDetails),
        payload: notification?.title);
  }

  final AndroidNotificationDetails _androidNotificationDetails =
      const AndroidNotificationDetails('channelId', "channelName",
          channelDescription: "channelDescription",
          playSound: true,
          priority: enums.Priority.high,
          importance: Importance.high);

  final IOSNotificationDetails _iosNotificationDetails =
      const IOSNotificationDetails(threadIdentifier: 'thread_id');
}
