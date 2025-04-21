import 'package:flutter/material.dart';
class MyCustomAnimatedRoute extends PageRouteBuilder {
  final Widget enterWidget;

  MyCustomAnimatedRoute({required this.enterWidget})
      : super(
    opaque: false,
    pageBuilder: (context, animation, secondaryAnimation) => enterWidget,
    transitionDuration:const  Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      animation = CurvedAnimation(
          parent: animation,
          curve: Curves.linear,
          reverseCurve: Curves.linear);
      return ScaleTransition(
          alignment:const Alignment(0.0, 0.87),
          scale: animation,
          child: child);
    },
  );
}