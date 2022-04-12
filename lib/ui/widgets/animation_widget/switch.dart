import 'package:flutter/material.dart';
import 'package:sbsi/common/app_colors.dart';

class BackGroundPainter extends CustomPainter {
  BackGroundPainter({
    required this.value,
    this.color = AppColors.primary,
  });
  final double value;
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    double conWidth = size.width / 2;
    Paint _paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.save();

    Rect _rect = Rect.fromLTWH(value * conWidth, 0, conWidth, size.height);
    RRect _rRect = RRect.fromRectAndRadius(_rect, const Radius.circular(10));

    canvas.drawRRect(_rRect, _paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate != this;
  }
}

class AnimatedSwitch extends StatefulWidget {
  const AnimatedSwitch({
    Key? key,
    required this.trueLabel,
    required this.falseLabel,
    required this.value,
    required this.trueColor,
    required this.falseColor,
    this.backgroundColor = AppColors.grayF2,
    this.padding = 0,
    required this.onChange,
  }) : super(key: key);
  final String trueLabel;
  final String falseLabel;
  final bool value;
  final Color backgroundColor;
  final Color trueColor;
  final Color falseColor;
  final double padding;
  final ValueChanged<bool> onChange;

  @override
  _AnimatedSwitchState createState() => _AnimatedSwitchState();
}

class _AnimatedSwitchState extends State<AnimatedSwitch>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;
  late Color _color;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    var curvedAnimation =
        CurvedAnimation(parent: animationController, curve: Curves.linear);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation)
      ..addListener(() {
        setState(() {
          if (widget.value) {
            _color = widget.trueColor;
          } else {
            _color = widget.falseColor;
          }
        });
      });
    setState(() {
      if (widget.value) {
        _color = widget.trueColor;
      } else {
        _color = widget.falseColor;
      }
    });

    if (!widget.value) {
      animationController.forward();
    }
    return;
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      if (widget.value) {
        animationController.reverse();
      } else {
        animationController.forward();
      }
      // animationController.forward();
      setState(() {});
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(
            color: AppColors.grayF2,
          )),
      child: CustomPaint(
        painter: BackGroundPainter(value: animation.value, color: _color),
        child: Container(
          color: Colors.transparent,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    widget.onChange.call(true);
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    alignment: Alignment.center,
                    child: Text(
                      widget.trueLabel,
                      style: TextStyle(
                        color: !widget.value ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    widget.onChange.call(false);
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    alignment: Alignment.center,
                    child: Text(
                      widget.falseLabel,
                      style: TextStyle(
                        color: widget.value ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
