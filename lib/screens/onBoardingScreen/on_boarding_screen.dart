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
    // Calculate the position of the onboarding content.
    final double maxOffset=MediaQuery.sizeOf(context).width;
    double offsetPercent=1;
    if(_transitionPercent<=0.25){
      offsetPercent=-_transitionPercent/0.25;
    }else if( _transitionPercent>=0.7){
      offsetPercent =(1.0-_transitionPercent)/0.3;
      offsetPercent=Curves.easeInCubic.transform(offsetPercent);
    }
    final double contentOffset =offsetPercent*maxOffset;
    final double  contentScale = 0.6+(0.4*(1.0-offsetPercent.abs()));
    return Scaffold(
        body: CustomPaint(
      painter: CircleTransitionPainter(
        backgroundColor: Colors.cyan,
        currentCircleColor: Colors.black,
        nextCircleColor: Colors.red,
        transitionPercent: _transitionPercent,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Transform(
            transform: Matrix4.translationValues(contentOffset, 0, 0)..scale(contentScale,contentScale),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(flex: 20,),
                CircleAvatar(
                  radius: 100,),
                Spacer(flex: 20,),
                Text("Hello World",style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold),),
                Spacer(flex: 50,),

              ],
            ),
          ),
          Column(
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
        ],
      ),
    ));
  }
}
