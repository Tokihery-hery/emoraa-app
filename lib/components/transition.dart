import 'package:flutter/material.dart';

class TransitionPage extends AnimatedWidget {
  const TransitionPage({Key? key, required Animation<double> animation, required this.child})
      : super(key: key, listenable: animation);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Animation<double> animation = listenable as Animation<double>;
    return SlideTransition(
      position: Tween(
        begin: const Offset(1, 0), 
        end: const Offset(0,0)
      ).animate(animation),
      child: child,
    );
  }
}
