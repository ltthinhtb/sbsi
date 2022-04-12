import 'package:sbsi/generated/l10n.dart';

class ErrorException {
  int statusCode;
  String message;

  ErrorException(this.statusCode, this.message) {
    if (message == "null") {
      message = S.current.error;
    }
  }
}
