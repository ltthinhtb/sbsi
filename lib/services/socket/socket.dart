import 'dart:convert';

import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:sbsi/configs/app_configs.dart';
import 'package:sbsi/utils/logger.dart';

class Socket {
  String? url = AppConfigs.socketUrl;
  late io.Socket socket;

  Socket({this.url}) {
    socket = io.io(url ?? AppConfigs.socketUrl,
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
