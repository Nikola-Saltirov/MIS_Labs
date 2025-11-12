import 'package:flutter/material.dart';
import 'package:lab1/models/ExamModel.dart';

import 'ExamCard.dart';


class ExamGrid extends StatefulWidget {
  final List<Exam> exams;
  const ExamGrid({super.key, required this.exams});

  @override
  State<StatefulWidget> createState() => _ExamGridState();
}

class _ExamGridState extends State<ExamGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 15,
          crossAxisSpacing: 7,
          childAspectRatio: 100/40
      ),
      itemCount: widget.exams.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return ExamCard(exam: widget.exams[index]);
      },
    );
  }
}
