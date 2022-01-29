import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jobs_ui/screens/language.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage("assets/images/launch.png"), context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Language(),
    );
  }
}
