import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class CircleTransitionPainter extends CustomPainter {
  CircleTransitionPainter({
    required Color backgroundColor,
    required Color currentCircleColor,
    required Color nextCircleColor,
    this.transitionPercent = 0,
  })  : backgroundPaint = Paint()..color = backgroundColor,
        currentCirclePaint = Paint()..color = currentCircleColor,
        nextCirclePaint = Paint()..color = nextCircleColor;

  final double baseCircleRadius = 36;
  final Paint backgroundPaint;
  final Paint currentCirclePaint;
  final Paint nextCirclePaint;
  final double transitionPercent;

  @override
  void paint(Canvas canvas, Size size) {
    if (transitionPercent < 0.5) {
      final double expansionPercent = transitionPercent / 0.5;
      _paintExpansion(canvas, size, expansionPercent);
    } else {
      final double contractionPercent = (transitionPercent - 0.5) / 0.5;
      _paintContraction(canvas, size, contractionPercent);
    }
  }

  void _paintExpansion(Canvas canvas, Size size, double expansionPercent) {
    // The max radius that the circle will grow to.
    final double maxRadius = size.height * 200;
    // The Original Circle position and size.
    Offset circlePosition = Offset(size.width / 2, size.height - 66);
    // The left side of the circle , which never moves during expansion.
    final double circleLeftBound = circlePosition.dx - baseCircleRadius;
    // Apply exponential reduction to the expansion rate of that circle
    // expands much much slower
    final num slowedExpansionPercent = pow(expansionPercent, 8);

    final double currentRadius =
        (maxRadius * slowedExpansionPercent) + baseCircleRadius;

    final Offset currentCircleCenter = Offset(
      circleLeftBound + currentRadius,
      circlePosition.dy,
    );

    // Paint the background
    canvas.drawPaint(backgroundPaint);
    //Paint the circle

    canvas.drawCircle(currentCircleCenter, currentRadius, currentCirclePaint);

    // Paint the Icon
    if (expansionPercent < 0.1) {
      _paintChevron(canvas, circlePosition, backgroundPaint.color);
    }
  }

  void _paintContraction(Canvas canvas, Size size, double contractionPercent) {
    // The max radius that the circle will grow to.
    final double maxRadius = size.height * 200;
    // The Original Circle position and size.
    Offset circlePosition = Offset(size.width / 2, size.height - 66);
    // The initial  right side of the circle which will becomes the left side of the circle by the end of the animation
    final double circleStartRightSide = circlePosition.dx - baseCircleRadius;
    // The final right side of the circle
    final double circleEndingRightSide = circlePosition.dx + baseCircleRadius;

    // Apply contraction reduction to the contraction rate of that circle
    // expands much much slower
    final double easedContractionPercent =
        Curves.easeInOut.transform(contractionPercent);
    final double inverseContractionPercent = 1 - contractionPercent;
    final num slowedInverseContractionPercent =
        pow(inverseContractionPercent, 8);

    final double currentRadius =
        (maxRadius * slowedInverseContractionPercent) + baseCircleRadius;

    // Calculate the current right side of the circle
    final double circleCurrentRightSide = circleStartRightSide +
        ((circleEndingRightSide - circleStartRightSide) *
            easedContractionPercent);

    final double circleCurrentCenterX = circleCurrentRightSide - currentRadius;

    final Offset currentCircleCenter = Offset(
      circleCurrentCenterX,
      circlePosition.dy,
    );

    // Paint the background
    canvas.drawPaint(currentCirclePaint);

    //Paint the circle

    canvas.drawCircle(currentCircleCenter, currentRadius, backgroundPaint);

    // Paint the new Expanding Circle
    if (easedContractionPercent > 0.9) {
      double newCircleExpansionPercent = (easedContractionPercent - 0.9) / 0.1;
      double newCircleRadius = baseCircleRadius * newCircleExpansionPercent;
      canvas.drawCircle(currentCircleCenter, newCircleRadius, nextCirclePaint);
    }

    // Paint the Icon
    if (contractionPercent > 0.95) {
      _paintChevron(canvas, circlePosition, currentCirclePaint.color);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

  /// Paint Chevron Method
  void _paintChevron(Canvas canvas, Offset circlePosition, Color color) {
    final IconData chevronIcon = Icons.arrow_forward_ios;

    final ui.ParagraphBuilder paragraphBuilder =
        ui.ParagraphBuilder(ui.ParagraphStyle(
      fontFamily: chevronIcon.fontFamily,
      fontSize: 24,
      textAlign: TextAlign.center,
    ))
          ..pushStyle(ui.TextStyle(color: color))
          ..addText(String.fromCharCode(chevronIcon.codePoint));

    final ui.Paragraph paragraph = paragraphBuilder.build();
    paragraph.layout(ui.ParagraphConstraints(width: baseCircleRadius));
    canvas.drawParagraph(paragraph,
        circlePosition - Offset(paragraph.width / 2, paragraph.height / 2));
  }
}
