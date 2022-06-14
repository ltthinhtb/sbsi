import 'dart:convert';

import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:sbsi/configs/app_configs.dart';
import 'package:sbsi/utils/logger.dart';

import '../index.dart';

class Socket {

  static Flavor get flavor {
    return Get.find<SettingService>().flavor.value;
  }

  String? url = flavor.socketUrl;
  late io.Socket socket;

  Socket({this.url}) {
    socket = io.io(url ?? flavor.socketUrl,
        io.OptionBuilder().setTransports(['websocket']).build());
    onConnectSocket();
  }

  void onConnectSocket() {
    socket.connect();
    socket.onConnect((data) {
      logger.i('socket đã kết nối ====>  ${socket.id}');
    });
    socket.onConnectError(
            (data) => logger.e('socketkết nối thất bại ====>  $data'));
    socket.onDisconnect((_) => logger.w('disconnect'));
  }

  void disconnectSocket(){
    socket.disconnect();
  }

  void dispose(){
    socket.dispose();
  }

  void addStockSocket(String stock) {
    var map = {"action": "join", "data": "$stock"};
    var msg = json.encode(map);
    socket.emit("regs", msg);
  }

  void removeStockSocket(String stock) {
    var map = {"action": "leave", "data": "$stock"};
    var msg = json.encode(map);
    socket.emit("regs", msg);
  }
}
