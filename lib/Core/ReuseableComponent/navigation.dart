import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
navigation_back({required BuildContext context, required Widget page}) {
  return Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: ((context) => page)),
    (route) => false,
  );
}

navigation({required BuildContext context, required Widget page}) {
  return Navigator.of(context)
      .push(MaterialPageRoute(builder: ((context) => page)));
}

// ignore: non_constant_identifier_names
void animated_navigation(
    {required BuildContext context, required Widget widget}) {
  Navigator.pushReplacement(context, Custompageroute(widget: widget));
}

class Custompageroute extends PageRouteBuilder {
  Widget widget;
  Custompageroute({required this.widget})
      : super(
            transitionDuration: Duration(seconds: 1),
            pageBuilder: (context, animation, secondaryanimation) => widget);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(0, 1), end: Offset.zero)
          .animate(animation),
      child: child,
    );
  }
}
