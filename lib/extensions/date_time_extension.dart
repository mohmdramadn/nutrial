import 'package:intl/intl.dart';

extension DateTimeFormat on DateTime{
  String dateOnly(){
    return DateFormat("dd/MM/yyyy").format(this);
  }
  //TODO
  String dateForFirebase(){
    return DateFormat("dd-MM-yyyy").format(this);
  }
}