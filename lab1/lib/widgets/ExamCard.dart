import 'package:flutter/material.dart';
import 'package:lab1/models/ExamModel.dart';

class ExamCard extends StatelessWidget {
  final Exam exam;

  const ExamCard({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/details", arguments: exam);
      },
      child: Card(
        color: exam.isPassed()?Colors.grey.shade300:Colors.lightGreenAccent.shade100,
        elevation: 4,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: exam.isPassed()?Colors.grey.shade700:Colors.green.shade300, width: 4),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.access_time_outlined,
                size: 36,
                color: exam.isPassed()?Colors.grey.shade600:Colors.green.shade700,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      exam.title,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 26),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 16, color: Colors.black54),
                        const SizedBox(width: 4),
                        Text(
                          exam.getFormattedDate(),
                          style: const TextStyle(fontSize: 17, color: Colors.black54),
                        ),
                      ],

                    ),
                    const SizedBox(height: 8),
                    Text(
                      exam.getRooms(),
                      style: const TextStyle(fontSize: 17, color: Colors.black54)
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
