import 'package:flutter/material.dart';
import 'package:students/screen.dart';
import 'package:students/spalsh.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'student',
      theme: ThemeData(),
      home: const splashscreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
