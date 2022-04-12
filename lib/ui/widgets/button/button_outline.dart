import 'package:flutter/material.dart';

class ButtonOutLine extends StatelessWidget {
  final VoidCallback voidCallback;
  final String title;

  const ButtonOutLine({Key? key, required this.voidCallback, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: voidCallback,
      child: Text(title),
    );
  }
}
