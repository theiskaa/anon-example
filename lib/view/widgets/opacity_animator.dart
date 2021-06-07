import 'package:flutter/material.dart';

import 'anon_widgets.dart';

class OpacityAnimator extends AnonStatelessWidget {
  final Widget? child;
  final Duration duration;
  final double beginingOpacity;

  OpacityAnimator({
    Key? key,
    required this.child,
    this.duration = const Duration(seconds: 1),
    this.beginingOpacity = 0.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      key: Key('opacity.animator'),
      tween: Tween<double>(begin: beginingOpacity, end: 1),
      duration: duration,
      builder: (context, double value, Widget? child) => Opacity(
        opacity: value,
        child: child,
      ),
      child: child,
    );
  }
}
