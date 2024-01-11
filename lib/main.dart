import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ne_izlesem/screens/splash_screen.dart';

import 'colors.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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