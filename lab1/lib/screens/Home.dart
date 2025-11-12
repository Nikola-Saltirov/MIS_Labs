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
      Exam(title: "Софтверски квалитет и тестирање", date: DateTime(2025,5,22,10,0), rooms: roomsTemp),
      Exam(title: "Машинско учење", date: DateTime(2025,5,20,10,0), rooms: roomsTemp),
      Exam(title: "Интегрирани системи", date: DateTime(2025,1,24,10,0), rooms: roomsTemp),
      Exam(title: "Дизајн на интеракцијата човек-компјутер", date: DateTime(2025,1,20,10,0), rooms: roomsTemp),
      Exam(title: "Дизајн и архитектура на софтвер", date: DateTime(2025,1,20,10,0), rooms: roomsTemp),
      Exam(title: "Вовед во науката за податоци", date: DateTime(2025,1,20,10,0), rooms: roomsTemp),
      Exam(title: "Веб програмирање", date: DateTime(2025,11,20,10,0), rooms: roomsTemp),
      Exam(title: "Бази на податоци", date: DateTime(2025,1,20,10,0), rooms: roomsTemp),
      Exam(title: "Оперативни системи", date: DateTime(2025,12,20,10,0), rooms: roomsTemp),
      Exam(title: "Дизајн на алгоритми", date: DateTime(2025,12,20,10,0), rooms: roomsTemp),
      Exam(title: "Визуелно програмирање", date: DateTime(2025,12,20,10,0), rooms: roomsTemp),
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
