import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';

enum ForkEnum { overview, menu, world }

extension ForkExt on ForkEnum {
  String title(BuildContext context) {
    switch (this) {
      case ForkEnum.overview:
        return S.of(context).over_view;
      case ForkEnum.menu:
        return S.of(context).menu;
      case ForkEnum.world:
        return S.of(context).world;

    }
  }
}
