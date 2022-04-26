
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

var logger = MyLogger();

class MyLogger {
  /// Log a message at level verbose.
  void v(dynamic message) {
    Logger().v(message);
    // _print("🤍 VERBOSE: $message");
  }

  /// Log a message at level debug.
  void d(dynamic message) {
    //Logger().d(message);
    //_print("💙 DEBUG: $message");
    Logger().d("💙 DEBUG: $message");

  }

  /// Log a message at level info.
  void i(dynamic message) {
    //Logger().i(message);
    //_print("💚️ INFO: $message");
    Logger().i("💚️ INFO: $message");

  }

  /// Log a message at level warning.
  void w(dynamic message) {
    //Logger().w(message);
     //_print("💛 WARNING: $message");
    Logger().w("💛 WARNING: $message");

  }

  /// Log a message at level error.
  void e(dynamic message) {
    //Logger().e(message);
    //_print("❤️ ERROR: $message");
    Logger().e("❤️ ERROR: $message");

  }

  void _print(dynamic message) {
    if (kDebugMode) {
      logger.d("$message");
    }
  }

  void _log(dynamic message) {
    if (kDebugMode) {
      Logger(level: Level.debug).d(message);
    }
  }

  void log(dynamic message, {bool printFullText = false, StackTrace? stackTrace}) {
    if (printFullText) {
      _log(message);
    } else {
      _print(message);
    }
    if (stackTrace != null) {
      _print(stackTrace);
    }
  }
}
