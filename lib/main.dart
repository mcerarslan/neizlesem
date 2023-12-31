import 'package:flutter/material.dart';
import 'package:ne_izlesem/screens/splash_screen.dart';

import 'colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ne İzlesem?',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor:  Colours.scaffoldBgColor,
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}