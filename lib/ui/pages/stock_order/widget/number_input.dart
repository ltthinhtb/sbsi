import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_text_styles.dart';

class BackGroundPainter extends CustomPainter {
  BackGroundPainter({
    this.color = AppColors.primary,
  });
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint _paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    Paint _linePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    Rect _rect = Rect.fromLTWH(0, 0, size.height, size.height);
    RRect _rRect = RRect.fromRectAndRadius(_rect, const Radius.circular(14));

    canvas.drawRRect(_rRect, _paint);
    canvas.translate(size.width * 0.3, size.height / 2);
    canvas.save();
    canvas.drawLine(
        const Offset(0, 0), Offset(size.width * 0.4, 0), _linePaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate != this;
  }
}

class BackGroundPainter2 extends CustomPainter {
  BackGroundPainter2({
    this.color = AppColors.primary,
  });
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint _paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    Paint _linePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    canvas.translate(size.width, size.height);
    canvas.rotate(pi);
    canvas.save();

    Rect _rect = Rect.fromLTWH(0, 0, size.height, size.height);
    RRect _rRect = RRect.fromRectAndRadius(_rect, const Radius.circular(14));

    canvas.drawRRect(_rRect, _paint);
    canvas.restore();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.save();
    for (var i = 0; i < 4; i++) {
      canvas.drawLine(
          const Offset(0, 0), Offset(size.width * 0.2, 0), _linePaint);
      canvas.rotate(pi / 2);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate != this;
  }
}

class NumberInputField extends StatefulWidget {
  const NumberInputField({
    Key? key,
    required this.label,
    this.backgroundColor = Colors.transparent,
    this.buttonColor = AppColors.primary,
    required this.editingController,
    this.focusNode,
    this.enabled = true,
    this.onSubtractPress,
    this.onAddPress,
    this.onChange,
    this.onEditingComplete,
    this.onFocus,
    this.onUnfocus,
    this.maxLength = 20,
    this.scrollPadding = const EdgeInsets.only(bottom: 80),
  }) : super(key: key);
  final Color backgroundColor;
  final Color buttonColor;
  final String label;
  final TextEditingController editingController;
  final FocusNode? focusNode;
  final bool enabled;
  final Function()? onSubtractPress;
  final Function()? onAddPress;
  final Function()? onChange;
  final Function()? onEditingComplete;
  final Function()? onFocus;
  final Function()? onUnfocus;
  final int? maxLength;
  final EdgeInsets scrollPadding;

  @override
  _NumberInputFieldState createState() => _NumberInputFieldState();
}

class _NumberInputFieldState extends State<NumberInputField> {
  late Color _color;
  FocusNode? _focusNode;
  String _hintText = "";
  bool enabled = true;
  
  @override
  void initState() {
    super.initState();
    if (widget.focusNode == null) {
      _focusNode = FocusNode();
    } else {
      _focusNode = widget.focusNode;
    }

    setState(() {
      _hintText = widget.label;
      _color = widget.buttonColor;
      enabled = widget.enabled;
    });
    _focusNode?.addListener(() {
      // print("Has focus: ${_focusNode?.hasFocus}");
      if (_focusNode!.hasFocus) {
        _hintText = "";
        widget.onFocus?.call();
      } else {
        _hintText = widget.label;
        widget.onUnfocus?.call();
      }
      setState(() {});
    });
  }

  // void focusListener() {}

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.enabled != widget.enabled) {
      // animationController.forward();
      setState(() {
        enabled = widget.enabled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        // color: Colors.green,
        borderRadius: const BorderRadius.all(
          Radius.circular(14),
        ),
        border: Border.all(
          color: widget.buttonColor,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.center,
            child: AspectRatio(
              aspectRatio: 1,
              child: CustomPaint(
                painter: BackGroundPainter(color: _color),
                child: MaterialButton(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    _focusNode?.unfocus();
                    if (enabled) {
                      widget.onSubtractPress?.call();
                    }
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: TextField(
                controller: widget.editingController,
                focusNode: _focusNode,
                enableSuggestions: false,
                enabled: enabled,
                autocorrect: false,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(widget.maxLength)
                ],
                scrollPadding: widget.scrollPadding,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  hintText: _hintText,
                  hintStyle: AppTextStyle.H4Regular,
                  filled: true,
                  fillColor: Colors.transparent,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                onChanged: (value) {
                  if (enabled) {
                    widget.onChange?.call();
                  }
                },
                onEditingComplete: () {
                  if (enabled) {
                    _focusNode?.unfocus();
                    widget.onEditingComplete?.call();
                  }
                },
              ),
            ),
          ),
          Container(
            child: AspectRatio(
              aspectRatio: 1,
              child: CustomPaint(
                painter: BackGroundPainter2(color: _color),
                child: MaterialButton(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    _focusNode?.unfocus();
                    if (enabled) {
                      widget.onAddPress?.call();
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
