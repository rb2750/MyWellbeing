import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeUp extends StatelessWidget {
  final double delay;
  final Widget child;
  bool animate;

  FadeUp(this.delay, this.child, {this.animate=true});

  @override
  Widget build(BuildContext context) {
    if (!animate) return child;

    final tween = MultiTrackTween(
        [Track("opacity").add(Duration(milliseconds: 1000), Tween(begin: 0.0, end: 1.0)), Track("translateY").add(Duration(milliseconds: 1000), Tween(begin: 130.0, end: 0.0), curve: Curves.easeOut)]);

    return ControlledAnimation(
      delay: Duration(milliseconds: (300 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: Transform.translate(offset: Offset(0, animation["translateY"]), child: child),
      ),
    );
  }
}

class FadeOut extends StatelessWidget {
  final double delay;
  final Widget child;
  bool animate = true;

  FadeOut(this.delay, this.child, {this.animate});

  @override
  Widget build(BuildContext context) {
    if (!animate) return child;
    final tween = MultiTrackTween(
        [Track("opacity").add(Duration(milliseconds: 500), Tween(begin: 1.0, end: 0.0)), Track("translateY").add(Duration(milliseconds: 500), Tween(begin: 0.0, end: -130.0), curve: Curves.easeOut)]);

    return ControlledAnimation(
      delay: Duration(milliseconds: (300 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: Transform.translate(offset: Offset(0, animation["translateY"]), child: child),
      ),
    );
  }
}
