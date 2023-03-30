import 'package:intl/intl.dart';

extension DateTimeFormat on DateTime{
  String dateOnly(){
    return DateFormat("dd/MM/yyyy").format(this);
  }
  String dateForFirebase(){
    return DateFormat("dd-MM-yyyy").format(this);
  }
  String hoursMinutes(){
    return DateFormat("hh:mm").format(this);
  }
}