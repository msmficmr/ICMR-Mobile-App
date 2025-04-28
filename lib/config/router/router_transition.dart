import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouterTransition extends CustomTransitionPage {
  RouterTransition({
    LocalKey? key,
    required Widget child,
  }) : super(
    key: key,
    transitionsBuilder: (BuildContext context, Animation<double> primaryAnimation, Animation<double> secondaryAnimation, Widget child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(primaryAnimation),
        child: child,
      );
    },
    child: child,
  );
}

/// Animation for the Material routing. we have set it as default in app theme.
class CustomTransitionBuilder extends PageTransitionsBuilder {
  const CustomTransitionBuilder();

  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }
}
