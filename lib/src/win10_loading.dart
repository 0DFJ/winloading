import 'dart:math';

import 'package:flutter/material.dart';

/**
 * When I wrote this, only God and I understood what I was doing
 * Now, God only knows
 */

class WinLoading extends StatefulWidget {
  final Color color;
  final double radius;
  final double gap;
  final double amount;
  final double width;
  final double height;
  final Duration duration;
  final Cubic cubic;

  const WinLoading({
    this.color = Colors.white,
    this.radius = 3,
    this.gap = 0.04,
    this.amount = 5,
    this.width = 60,
    this.height = 60,
    this.duration = const Duration(milliseconds: 5200),
    this.cubic = const Cubic(.21, .6, .59, .8),
    Key? key,
  }) : super(key: key);

  @override
  State<WinLoading> createState() => _WinLoadingState();
}

class _WinLoadingState extends State<WinLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationControl;

  @override
  void initState() {
    super.initState();
    _animationControl =
        AnimationController(vsync: this, duration: widget.duration);
    _animationControl.repeat();
  }

  @override
  void dispose() {
    _animationControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _animationControl,
        builder: (BuildContext context, Widget? child) {
          return CustomPaint(
            painter: _WinLoadingPainter(
              _animationControl.value,
              widget.color,
              widget.radius,
              widget.gap,
              widget.amount,
              widget.cubic,
            ),
          );
        },
      ),
    );
  }
}

class _WinLoadingPainter extends CustomPainter {
  final double progress;
  final double radius;
  final double gap;
  final double amount;
  final Color color;
  final Paint _paint = Paint();
  final Cubic cubic;
  final List<Interval> winIntervals = [];

  _WinLoadingPainter(
    this.progress,
    this.color,
    this.radius,
    this.gap,
    this.amount,
    this.cubic,
  ) {
    _paint
      ..color = color
      ..style = PaintingStyle.fill;

    /// https://cubic-bezier.com/#.07,.59,.59,.8
    // Cubic cubic1 = const Cubic(.07, .59, .59, .8);
    // Cubic cubic1 = const Cubic(.17,.59,.59,.8);
    // Cubic cubic1 = const Cubic(.21,.6,.59,.8);
    Cubic cubic2 = cubic.symmetry();
    winIntervals.add(_CurveAngle(0, 18 / 72.0, curve: cubic));
    winIntervals.add(_CurveAngle(18 / 72.0, 36 / 72.0, curve: cubic2));
    winIntervals.add(_CurveAngle(36 / 72.0, 54 / 72.0, curve: cubic));
    winIntervals.add(_CurveAngle(54 / 72.0, 1, curve: cubic2));
  }

  @override
  void paint(Canvas canvas, Size size) {
    //计算 延迟后每个球运动多久
    double time = 1 - gap * (amount - 1);
    for (int i = 0; i < amount; i++) {
      double begin = gap * i;

      /// 耗时都是 time 延时模拟 1-gap-2-gap-3-gap-4-gap-5
      var interval = Interval(begin, time + begin);
      drawCircle(canvas, size, interval.transform(progress));
    }
  }

  void drawCircle(Canvas canvas, Size size, double progress) {
    double calcuAniAngle() {
      double ani = 0;
      for (var element in winIntervals) {
        var current = element.transform(progress);
        ani += current;
        if (current == 0) {
          /// 为0 表示当前阶段winInterval还没开始
          return ani;
        }
      }

      /// 最后一个阶段
      return ani;
    }

    double aniAngle = calcuAniAngle();
    if (aniAngle == 0 || aniAngle == 4 * pi) {
      /// 开始和结束不可见
      return;
    }

    // 从底部开始 默认0度 在右边
    double angle = pi / 3.3 + aniAngle;

    double minSide = min(size.width, size.height);
    double locusRadius = minSide / 2 - radius;

    // (x-a)^2+(y-b)^2=r^2
    // x,y = R*cos(θ) , R*sin(θ)
    // path of particle
    /// 圆的轨迹 方程 x,y = R*cos(θ) , R*sin(θ)
    var offset = Offset(locusRadius * cos(angle), locusRadius * sin(angle));
    canvas.drawCircle(
        offset.translate(size.width / 2, size.height / 2), radius, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _CurveAngle extends Interval {
  final double angle;

  // 18 / 72=pi
  const _CurveAngle(double begin, double end, {Curve curve = Curves.linear})
      : angle = (end - begin) * 72 / 18.0 * pi,
        super(begin, end, curve: curve);

  @override
  double transform(double t) {
    return angle * super.transform(t);
  }
}

extension CubicExt on Cubic {
  Cubic symmetry() {
    return Cubic(1 - c, 1 - d, 1 - a, 1 - b);
  }
}
