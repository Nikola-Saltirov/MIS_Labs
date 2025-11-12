import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab1/widgets/ExamGrid.dart';

import '../models/ExamModel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Exam> exams=[];
  @override
  void initState() {
    super.initState();
    List<String> roomsTemp=[];
    roomsTemp.add("B 2.1");
    roomsTemp.add("B 3.1");
    roomsTemp.add("B 2.2");
    roomsTemp.add("B 2.3");
    roomsTemp.add("B 1");
    exams = [
      Exam(title: "1", date: DateTime(2025,1,20), rooms: roomsTemp),
      Exam(title: "2", date: DateTime(2025,1,20), rooms: roomsTemp),
      Exam(title: "3", date: DateTime(2025,1,20), rooms: roomsTemp),
      Exam(title: "4", date: DateTime(2025,1,20), rooms: roomsTemp),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: ExamGrid(exams: exams),
              ),
            ),
          ]
      ),
    );
  }
}
