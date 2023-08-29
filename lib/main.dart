import 'package:flutter/material.dart';
import 'package:rest_api/screen/another_screen.dart';
import 'package:rest_api/screen/home_screen.dart';
import 'package:rest_api/screen/second_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const AnotherScreen(),
    );
  }
}
