import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tickertape/views/home.dart';

/// navigateTo -> Function to navigate to a particular widget with animation
Future navigateTo(Widget navigate, BuildContext context) {
  return Navigator.of(context).push(PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => navigate,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.easeIn;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  ));
}

/// navigateWithProvider -> navigate to another widget with provider
Future navigateWithProvider(
  Widget navigate,
  ChangeNotifier provider,
  BuildContext context,
) {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => provider)],
        child: navigate,
      ),
    ),
  );
}

/// finish-> pushing and removing until given route
void finish(String route, BuildContext context) {
  Navigator.of(context).pushNamedAndRemoveUntil(
    route,
    (Route<dynamic> route) => false,
  );
}

/// finishWithParams -> pushing and removing until given route with params
void finishWithParams(String route, BuildContext context, int index) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
    ModalRoute.withName(route),
  );
}

/// justFinish -> popping one screen
void justFinish(BuildContext context) {
  Navigator.pop(context);
}

/// Pops the stack [times] number of times.
void popRepeated({required BuildContext context, required int times}) {
  for (var index = 0; index < times; index++) {
    Navigator.pop(context);
  }
}
