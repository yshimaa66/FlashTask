import 'package:intl/intl.dart';

formatDate(String unFormattedDate){

  DateTime date = new DateTime.fromMillisecondsSinceEpoch(int.parse(unFormattedDate)* 1000);
  var format = new DateFormat("dd/MM/yyyy hh:mm a");
  var dateString = format.format(date);
  return dateString;
}

Duration daysBetween(String startTime) {
  var currentTime = DateTime.now();
  DateTime startTimeFormatted = new DateTime.fromMillisecondsSinceEpoch(
      int.parse(startTime)* 1000);
  var diff = startTimeFormatted.difference(currentTime);
  print(diff);
  return diff;
}