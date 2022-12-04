import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({super.key, required Animation<double> animation})
      : super(listenable: animation);
  static int t=0;

  // Make the Tweens static because they don't change.
  static final _opacityTween = Tween<double>(begin: 0, end: 2);
  //static final _sizeTween = Tween<double>(begin: 0, end: 300);

  @override
  Widget build(BuildContext context){
    t=t+1;
    final animation = listenable as Animation<double>;
    print(_opacityTween.evaluate(animation).toString()+" angle="+math.pi.toString());
    return Stack(
      alignment: Alignment.center,
      children:[
        SizedBox(height: 400,width: 400,child: Image.asset("assets/icosn/testGif3.gif"),),
      ]
      ///opacity
    //  child: Opacity(
    //    opacity: _opacityTween.evaluate(animation),
    //    child: Container(
    //      margin: const EdgeInsets.symmetric(vertical: 10),
    //      height:200, //_sizeTween.evaluate(animation),
    //      width:200, //_sizeTween.evaluate(animation),
    //      child: const FlutterLogo(),
    //    ),
    //  ),
    );
  }
}

class LogoApp extends StatefulWidget {
  const LogoApp({super.key});

  @override
  State<LogoApp> createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.linear)
      ..addStatusListener((status) {

        if (status == AnimationStatus.completed) {
          controller.repeat(period:const Duration(seconds: 2));
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) => AnimatedLogo(animation: animation);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}