import 'package:flutter/material.dart';

class ButtonFill extends StatelessWidget {
  final VoidCallback? voidCallback;
  final String title;
  final ButtonStyle? style;

  const ButtonFill(
      {Key? key, required this.voidCallback, required this.title, this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: style,
      onPressed: voidCallback,
      child: Text(title),
    );
  }
}
