import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tickertape/viewmodel/home_viewmodel.dart';
import 'package:tickertape/views/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of our application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
      ],
      child: HomeScreen(),
    );
  }
}
