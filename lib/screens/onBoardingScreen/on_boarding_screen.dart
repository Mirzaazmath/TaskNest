import 'package:flutter/material.dart';
import 'package:task_nest/constants/app_colors.dart';
import 'package:task_nest/utils/animated_screen_curve.dart';
import 'package:task_nest/utils/show_animation_util.dart';
import '../../constants/app_strings.dart';
import '../../model/onboarding_model.dart';
import '../../utils/page_transition_utils.dart' show MyCustomAnimatedRoute;
import '../home_screen.dart';
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
  int selectedIndex = 0;
  bool startTransition = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500))
      ..addListener(() {
        setState(() {
          _transitionPercent = animationController.value;
        });
      })
      ..addStatusListener((state) {
        setState(() {
          if (state == AnimationStatus.completed) {
            if (selectedIndex < 1) {
              selectedIndex++;
              animationController.value = 0;
              _transitionPercent = 0;
            }
          }
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the position of the onboarding content.
    final double maxOffset = MediaQuery.sizeOf(context).width;
    double offsetPercent = 1;
    if (_transitionPercent <= 0.25) {
      offsetPercent = -_transitionPercent / 0.25;
    } else if (_transitionPercent >= 0.7) {
      offsetPercent = (1.0 - _transitionPercent) / 0.3;
      offsetPercent = Curves.easeInCubic.transform(offsetPercent);
    }
    final double contentOffset = offsetPercent * maxOffset;
    final double contentScale = 0.5 + (0.4 * (1.0 - offsetPercent.abs()));

    return Scaffold(
        body: CustomPaint(
      painter: CircleTransitionPainter(
        backgroundColor: onboardingDataList[selectedIndex].backgroundColor,
        currentCircleColor:
            onboardingDataList[selectedIndex].currentCircleColor,
        nextCircleColor: onboardingDataList[selectedIndex].nextCircleColor,
        transitionPercent: _transitionPercent,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Transform(
              transform: Matrix4.translationValues(contentOffset, 0, 0)
                ..scale(contentScale, contentScale),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(onboardingDataList[_transitionPercent < 0.5
                          ? selectedIndex
                          : selectedIndex + 1]
                      .image),
                  Text(
                    onboardingDataList[_transitionPercent < 0.5
                            ? selectedIndex
                            : selectedIndex + 1]
                        .title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: onboardingDataList[_transitionPercent < 0.5
                                    ? selectedIndex
                                    : selectedIndex + 1]
                                .textColor ??
                            AppColors.primaryColor,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () async {
                  if (_transitionPercent > 0.5 && selectedIndex + 1 == 2) {
                    // Todo : Need to Add Navigation
                    // Obtain shared preferences.
                    setState(() {
                      startTransition = true;
                      Future.delayed(const Duration(milliseconds: 500), () {
                        Navigator.of(context).push(MyCustomAnimatedRoute(
                          enterWidget:
                              const AnimatedScreenCurve(child: HomeScreen()),
                        ));
                      });
                    });
                  } else {
                    animationController.forward();
                  }
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedContainer(
                      height:startTransition?60: 72,
                      width: _transitionPercent > 0.5 && selectedIndex + 1 == 2
                          ?startTransition? 60:250
                          : 72,
                      duration: Duration(milliseconds: startTransition ?1200:1800),
                      curve: Curves.elasticInOut,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color:
                            _transitionPercent > 0.5 && selectedIndex + 1 == 2
                                ? AppColors.primaryColor
                                : Colors.transparent,
                      ),
                      alignment: Alignment.center,
                    ),
                    _transitionPercent > 0.5 && selectedIndex + 1 == 2
                        ? AnimatedPositioned(
                            bottom: startTransition ? 100 : 18,
                            duration: const Duration(milliseconds: 300),
                            child: ShowUpAnimation(
                                delay: 1100,
                                child: Text(
                                  AppStrings.letStart,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                          color: AppColors.backgroundColor),
                                )),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
