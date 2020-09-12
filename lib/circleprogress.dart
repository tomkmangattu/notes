import 'package:flutter/material.dart';
import 'dart:math';
class CircleProgress extends CustomPainter{
  double currentprocess;
  CircleProgress({this.currentprocess});
@override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint outerCircle=Paint()
      ..strokeWidth=7
      ..color=Colors.black12
      ..style=PaintingStyle.stroke;
    Paint completeArc=Paint()
      ..strokeWidth=7
      ..style =PaintingStyle.stroke
      ..color=Colors.blue
      ..strokeCap=StrokeCap.round;
    Offset center=Offset(size.width/2, size.height/2);
    double radius =min(size.width/2, size.height/2)-7;
    canvas.drawCircle(center, radius, outerCircle);
    double angle=2*pi*(currentprocess/100);
    canvas.drawArc(Rect.fromCircle(radius: radius,center: center),-pi/2 , angle,false , completeArc);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}