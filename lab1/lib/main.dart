import 'package:flutter/material.dart';
import 'package:lab1/screens/Details.dart';
import 'package:lab1/screens/Home.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Raspored na Ispiti - 221231',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const MyHomePage(title: 'Raspored na Ispiti - 221231'),
        "/details": (context) => const DetailsPage(),
      },
    );
  }
}