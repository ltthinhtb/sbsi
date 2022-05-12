import 'package:flutter/material.dart';
import 'package:sbsi/ui/commons/appbar.dart';

import '../../../../generated/l10n.dart';

class BankTransfer extends StatefulWidget {
  const BankTransfer({Key? key}) : super(key: key);

  @override
  State<BankTransfer> createState() => _BankTransferState();
}

class _BankTransferState extends State<BankTransfer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: S.of(context).bank_transfer,
      ),
    );
  }
}
