import 'package:flutter/material.dart';
import 'package:sbsi/generated/l10n.dart';

class TimeCountDown extends StatefulWidget {
  final TextStyle? textStyle;
  final Duration duration;

  const TimeCountDown({Key? key, this.textStyle, required this.duration})
      : super(key: key);

  @override
  _TimeCountDownState createState() => _TimeCountDownState();
}

class _TimeCountDownState extends State<TimeCountDown>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Countdown(
        style: widget.textStyle,
        animation: StepTween(
          begin: widget.duration.inSeconds,
          end: 0,
        ).animate(_controller),
      ),
    );
  }
}

class Countdown extends AnimatedWidget {
  const Countdown({Key? key, required this.animation, this.style})
      : super(key: key, listenable: animation);
  final Animation<int> animation;
  final TextStyle? style;

  @override
  Text build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${(clockTimer.inSeconds.remainder(60) % 60).toString().padLeft(2, '0')}';
    return Text(
      clockTimer.inSeconds > 0 ? timerText : S.of(context).resent,
      style: style ?? Theme.of(context).textTheme.headline3,
    );
  }
}
