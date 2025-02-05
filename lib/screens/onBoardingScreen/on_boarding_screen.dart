import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

import 'circle_transition_painter.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>with SingleTickerProviderStateMixin {
 late  AnimationController animationController;
  double value=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController=AnimationController(vsync: this);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: CircleTransitionPainter(
          backgroundColor: Colors.cyan,
          currentCircleColor:  Colors.black,
          nextCircleColor: Colors.red,
            transitionPercent: 0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                IconButton(onPressed: (){}, icon:const  Icon(Icons.play_arrow,size: 40,)),
                Expanded(child: Slider(value: value, onChanged: (val){
                  setState(() {
                    value=val;
                  });
                })),
              ],
            ),
            const  SizedBox(height: 100,)
          ],
        ),
      )
    );
  }
}
