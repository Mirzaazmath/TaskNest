import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleTransitionPainter extends CustomPainter{

  CircleTransitionPainter({
    required Color backgroundColor,
    required Color currentCircleColor,
    required Color nextCircleColor,
    this.transitionPercent=0,
}):backgroundPaint=Paint()..color=backgroundColor,
  currentCirclePaint = Paint()..color= currentCircleColor,
  nextCirclePaint = Paint()..color= nextCircleColor;

  final  double baseCircleRadius=36;
  final Paint backgroundPaint;
  final Paint currentCirclePaint;
  final Paint nextCirclePaint;
  final double transitionPercent;

  @override
  void paint(Canvas canvas, Size size) {
    // Paint the background
    canvas.drawPaint(backgroundPaint);
    //Paint the circle
    Offset circlePosition = Offset(size.width/2, size.height*0.75);
    canvas.drawCircle(circlePosition, baseCircleRadius, currentCirclePaint);

    // Paint the Icon
    final  IconData chevronIcon =Icons.arrow_forward_ios;

    final ui.ParagraphBuilder paragraphBuilder = ui.ParagraphBuilder(ui.ParagraphStyle(
      fontFamily: chevronIcon.fontFamily,
      fontSize: 24,
      textAlign:  TextAlign.center,
      
    ))..pushStyle(ui.TextStyle(color: backgroundPaint.color))..addText(String.fromCharCode(chevronIcon.codePoint));

    final ui.Paragraph paragraph = paragraphBuilder.build();
    paragraph.layout(ui.ParagraphConstraints(width:baseCircleRadius));
    canvas.drawParagraph(paragraph, circlePosition-Offset(paragraph.width/2,paragraph.height/2));

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }

}