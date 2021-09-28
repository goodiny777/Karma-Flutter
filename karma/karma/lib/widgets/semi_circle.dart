import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:karma/general/constants.dart';

class SemiCircle extends StatelessWidget {
  const SemiCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SemiCirclePainter(),
      size: Size(screenWidth, screenWidth / 3),
    );
  }
}

class SemiCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = materialAppYellow;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height * 1.5, size.width / 3),
        height: size.height * 2,
        width: size.width,
      ),
      pi,
      pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
