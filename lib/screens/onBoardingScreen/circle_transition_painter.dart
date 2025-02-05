import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

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
    if(transitionPercent<0.5){
      final double expansionPercent= (0.5-transitionPercent)/0.5;
    _paintExpansion(canvas, size, expansionPercent);
    }else{
      final double contractionPercent= (1.0-transitionPercent)/0.5;
      _paintContraction(canvas, size, contractionPercent);
    }


  }

  void _paintExpansion(Canvas canvas ,Size size,double expansionPercent){
    // Paint the background
    canvas.drawPaint(backgroundPaint);
    //Paint the circle
    Offset circlePosition = Offset(size.width/2, size.height*0.75);
    canvas.drawCircle(circlePosition, baseCircleRadius, currentCirclePaint);

    // Paint the Icon
    _paintChevron(canvas,circlePosition,backgroundPaint.color);

  }
  void _paintContraction(Canvas canvas ,Size size,double contractionPercent){

  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

  /// Paint Chevron Method
  void _paintChevron(Canvas canvas,Offset  circlePosition,Color color){
    final  IconData chevronIcon =Icons.arrow_forward_ios;

    final ui.ParagraphBuilder paragraphBuilder = ui.ParagraphBuilder(ui.ParagraphStyle(
      fontFamily: chevronIcon.fontFamily,
      fontSize: 24,
      textAlign:  TextAlign.center,

    ))..pushStyle(ui.TextStyle(color:color))..addText(String.fromCharCode(chevronIcon.codePoint));

    final ui.Paragraph paragraph = paragraphBuilder.build();
    paragraph.layout(ui.ParagraphConstraints(width:baseCircleRadius));
    canvas.drawParagraph(paragraph, circlePosition-Offset(paragraph.width/2,paragraph.height/2));
  }

}