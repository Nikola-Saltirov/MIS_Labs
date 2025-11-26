import 'package:flutter/material.dart';
import 'package:lab2/screens/home.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Categories - 221231',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent.shade100),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const MyHomePage(title: 'Categories - 221231'),
      },
    );
  }
}