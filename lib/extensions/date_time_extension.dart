import 'package:intl/intl.dart';
import 'package:nutrial/constants/constant_strings.dart';

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

  String weekDay() {
    if (weekday == DateTime.monday) return WeekDays.monday;
    if (weekday == DateTime.tuesday) return WeekDays.tuesday;
    if (weekday == DateTime.wednesday) return WeekDays.wednesday;
    if (weekday == DateTime.thursday) return WeekDays.thursday;
    if (weekday == DateTime.friday) return WeekDays.friday;
    if (weekday == DateTime.saturday) return WeekDays.friday;
    if (weekday == DateTime.sunday) return WeekDays.sunday;
    return '';
  }

  DateTime dateOnlyNotString(){
    return DateTime(year, month, day);
  }
}