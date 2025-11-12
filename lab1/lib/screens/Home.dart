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
      Exam(title: "AAAAAAAAAAAAAAAAAAAAAAAAA", date: DateTime(2025,1,20,10,0), rooms: roomsTemp),
      Exam(title: "2", date: DateTime(2025,1,20,10,0), rooms: roomsTemp),
      Exam(title: "3", date: DateTime(2025,1,20,10,0), rooms: roomsTemp),
      Exam(title: "4", date: DateTime(2025,1,20,10,0), rooms: roomsTemp),
      Exam(title: "5", date: DateTime(2025,1,20,10,0), rooms: roomsTemp),
      Exam(title: "6", date: DateTime(2025,1,20,10,0), rooms: roomsTemp),
      Exam(title: "7", date: DateTime(2025,11,20,10,0), rooms: roomsTemp),
      Exam(title: "8", date: DateTime(2025,1,20,10,0), rooms: roomsTemp),
      Exam(title: "9", date: DateTime(2025,12,20,10,0), rooms: roomsTemp),
      Exam(title: "10", date: DateTime(2025,12,20,10,0), rooms: roomsTemp),
      Exam(title: "11", date: DateTime(2025,12,20,10,0), rooms: roomsTemp),
    ];

    exams.sort((a, b) => a.date.compareTo(b.date));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade100,
        title: Text(widget.title),
      ),
      body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: ExamGrid(exams: exams),
              ),
            ),
          ]
      ),
      bottomNavigationBar: Container(
        color: Colors.blueGrey[100],
        padding: EdgeInsets.all(10),
        child: Text(
          "Број на Испити: "+exams.length.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: Colors.black54),
        ),
      ),
    );
  }
}
