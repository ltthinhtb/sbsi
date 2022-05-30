import '../../../../generated/l10n.dart';

enum RightExc { listRight, history }

extension RightExt on RightExc {
  String get name {
    switch (this) {
      case RightExc.listRight:
        return S.current.right_list;
      case RightExc.history:
        return S.current.right_history;
    }
  }
}
