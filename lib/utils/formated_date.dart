import 'package:intl/intl.dart';

String formatedDate(String dateJson) {
  DateTime dateTime = DateTime.parse(dateJson);
  return DateFormat('dd/MM/yyyy - hh:mm a').format(dateTime);
}
