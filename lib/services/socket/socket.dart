import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:sbsi/configs/app_configs.dart';
import 'package:sbsi/utils/logger.dart';

class Socket {
  final String? url;
  late io.Socket socket;

  static final Socket _instance = Socket._internal();

  Socket._internal({this.url}) {
    socket = io.io(url ?? AppConfigs.socketUrl,
        io.OptionBuilder().setTransports(['websocket']).build());
    onConnectSocket();
  }

  factory Socket() {
    return _instance;
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

}

