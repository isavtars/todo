//date formatteds
import 'package:intl/intl.dart';

dynamic formatDate(String date) {
  final dynamic newDate = DateTime.parse(date);
  final DateFormat formatter = DateFormat('E, d MMMM');
  final dynamic formatted = formatter.format(newDate);
  return formatted;
}
