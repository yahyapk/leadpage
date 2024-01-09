import 'package:intl/intl.dart';

extension DateTimeFormat on DateTime{
  String fullDate(){
    return DateFormat.yMMMMd('en_Us').format(
      DateTime.fromMicrosecondsSinceEpoch((this).microsecondsSinceEpoch)
    );
  }
}