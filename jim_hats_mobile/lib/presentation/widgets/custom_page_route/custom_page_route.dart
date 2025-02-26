import 'package:flutter/material.dart';

class CustomPageRouteBuilder extends PageRouteBuilder {
  final Widget child;
  CustomPageRouteBuilder({required super.settings, required this.child})
      : super(
          transitionDuration: Duration(milliseconds: 150),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
