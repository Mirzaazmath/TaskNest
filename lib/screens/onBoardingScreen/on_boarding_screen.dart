import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

import 'circle_transition_painter.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  double _transitionPercent = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500))
      ..addListener(() {
        setState(() {
          _transitionPercent=animationController.value;
        });
      })
      ..addStatusListener((state) {
        setState(() {});
      });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomPaint(
      painter: CircleTransitionPainter(
        backgroundColor: Colors.cyan,
        currentCircleColor: Colors.black,
        nextCircleColor: Colors.red,
        transitionPercent: _transitionPercent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    animationController.forward();
                  },
                  icon: const Icon(
                    Icons.play_arrow,
                    size: 40,
                  )),
              Expanded(
                  child: Slider(
                      value: animationController.value,
                      onChanged: (val) {
                        setState(() {
                          animationController.value=val;
                        });
                      })),
            ],
          ),
          const SizedBox(
            height: 100,
          )
        ],
      ),
    ));
  }
}
