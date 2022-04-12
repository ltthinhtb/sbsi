import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_text_styles.dart';
import 'package:sbsi/generated/l10n.dart';

class BuyVolumnPainter extends CustomPainter {
  BuyVolumnPainter({
    this.value = 0,
  });
  final double value;

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    if (value > 0) {
      Paint _paint = Paint()
        ..color = AppColors.green_op
        ..style = PaintingStyle.fill;

      canvas.save();

      Rect _rect = Rect.fromLTWH(0, 0, value * size.width, size.height);
      RRect _rRect = RRect.fromRectAndRadius(_rect, const Radius.circular(30));

      canvas.drawRRect(_rRect, _paint);
      canvas.restore();
    } else {
      Paint _paint = Paint()
        ..color = AppColors.green_op
        ..style = PaintingStyle.fill;

      canvas.save();

      Rect _rect = Rect.fromLTWH(0, 0, size.width, size.height);
      RRect _rRect = RRect.fromRectAndRadius(_rect, const Radius.circular(30));

      canvas.drawRRect(_rRect, _paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate != this;
  }
}

class SellVolumnPainter extends CustomPainter {
  SellVolumnPainter({
    this.value = 0,
  });
  final double value;

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    if (value > 0) {
      Paint _paint = Paint()
        ..color = AppColors.red_op
        ..style = PaintingStyle.fill;
      canvas.translate(size.width, size.height);
      canvas.rotate(pi);
      canvas.save();

      Rect _rect = Rect.fromLTWH(0, 0, value * size.width, size.height);
      RRect _rRect = RRect.fromRectAndRadius(_rect, const Radius.circular(30));

      canvas.drawRRect(_rRect, _paint);
      canvas.restore();
    } else {
      Paint _paint = Paint()
        ..color = AppColors.red_op
        ..style = PaintingStyle.fill;
      canvas.translate(size.width, size.height);
      canvas.rotate(pi);
      canvas.save();

      Rect _rect = Rect.fromLTWH(0, 0, size.width, size.height);
      RRect _rRect = RRect.fromRectAndRadius(_rect, const Radius.circular(30));

      canvas.drawRRect(_rRect, _paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate != this;
  }
}

class TotalVolumnPercentRow extends StatefulWidget {
  const TotalVolumnPercentRow({
    Key? key,
    this.buyValue = 0,
    this.sellValue = 0,
    required this.sum,
    this.padding = 5,
  }) : super(key: key);
  final double buyValue;
  final double sellValue;
  final double sum;
  final double padding;
  @override
  _TotalVolumnPercentRowState createState() => _TotalVolumnPercentRowState();
}

class _TotalVolumnPercentRowState extends State<TotalVolumnPercentRow>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController)
          ..addStatusListener((status) {
            setState(() {});
          })
          ..addListener(() {
            setState(() {});
          });

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (widget.buyValue > 0 || widget.sellValue > 0) {
        _animationController.forward();
        setState(() {});
      }
    });
  }

  void updateAnimation() {
    _animationController.reset();
    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController)
          ..addStatusListener((status) {
            setState(() {});
          })
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  void didUpdateWidget(covariant TotalVolumnPercentRow oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget.buyValue != widget.buyValue ||
        oldWidget.sellValue != widget.sellValue) {
      updateAnimation();
      _animationController.forward();
      setState(() {});
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var buyPer = (widget.sum == 0) ? 0 : ((widget.buyValue / widget.sum) * 100);
    var sellPer =
        (widget.sum == 0) ? 0 : ((widget.sellValue / widget.sum) * 100);
    return Container(
      // margin: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    S.of(context).buy,
                    textDirection: TextDirection.ltr,
                    style: AppTextStyle.caption2.copyWith(color: Colors.black),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    S.of(context).sell,
                    textDirection: TextDirection.rtl,
                    style: AppTextStyle.caption2.copyWith(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                flex: widget.buyValue > 0 ? widget.buyValue.round() : 1,
                child: Container(
                  child: CustomPaint(
                    painter: BuyVolumnPainter(
                      value: _animation.value,
                    ),
                    child: Container(
                      padding: EdgeInsets.only(left: widget.padding),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        (buyPer < 20) ? "" : buyPer.toStringAsFixed(1) + "%",
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(color: AppColors.increase),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: widget.sellValue > 0 ? widget.sellValue.round() : 1,
                child: Container(
                  child: CustomPaint(
                    painter: SellVolumnPainter(
                      value: _animation.value,
                    ),
                    child: Container(
                      padding: EdgeInsets.only(right: widget.padding),
                      alignment: Alignment.centerRight,
                      child: Text(
                        (sellPer < 20) ? "" : sellPer.toStringAsFixed(1) + "%",
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(color: AppColors.decrease),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
