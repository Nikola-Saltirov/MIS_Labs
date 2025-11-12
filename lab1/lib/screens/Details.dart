import 'package:flutter/material.dart';

import '../models/ExamModel.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final exam = ModalRoute.of(context)!.settings.arguments as Exam;
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exam.title,
                    style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.green),
                      const SizedBox(width: 8),
                      Text(
                        exam.getFormattedDate(),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Rooms:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: exam.rooms.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: exam.isPassed()?Colors.grey.shade400:Colors.green.shade300,
                        child: ListTile(
                          leading: const Icon(Icons.meeting_room),
                          title: Text(exam.rooms[index]),
                        ),
                      );
                    },
                  ),
                  Text(
                    exam.getTimeDifferenceFromNow(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
