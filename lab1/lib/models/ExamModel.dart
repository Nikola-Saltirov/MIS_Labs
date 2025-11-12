class Exam{
String title;
DateTime date;
List<String> rooms;

Exam({
  required this.title,
  required this.date,
  required this.rooms,
});

String getFormattedDate() {
  String day = date.day.toString().padLeft(2, '0');
  String month = date.month.toString().padLeft(2, '0');
  String year = date.year.toString();
  String hour= date.hour.toString().padLeft(2, '0');
  String minute= date.minute.toString().padLeft(2, '0');


  return "$day/$month/$year Time: $hour:$minute";
}

bool isPassed() {
  return date.isBefore(DateTime.now());
}

  String getRooms() {
    return rooms.join(", ");
  }

String getTimeDifferenceFromNow() {
  final now = DateTime.now();
  final diff = date.difference(now);

  final duration = diff.isNegative ? diff.abs() : diff;

  final days = duration.inDays;
  final hours = duration.inHours % 24;

  if (diff.isNegative) {
    return "Поминато пред: $days Дена, $hours часа";
  } else {
    return "Преостанува: $days Дена, $hours часа";
  }
}
}