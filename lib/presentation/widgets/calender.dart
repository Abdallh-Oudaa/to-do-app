
import 'package:calendar_timeline/calendar_timeline.dart';

import 'package:flutter/material.dart';

class Calender extends StatelessWidget {
 static DateTime? selectedDate=DateTime.now();
 const  Calender({super.key});

  @override
  Widget build(BuildContext context) {
    return CalendarTimeline(

     width: 60,
        height: 70,
      dayNameFontSize: 10,
      fontSize: 25,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      onDateSelected: (date){
       selectedDate=date;

      },
      leftMargin: 5,
      monthColor: Colors.blue,
      dayColor: Colors.blue,
      activeDayColor: Colors.white,
      activeBackgroundDayColor:const Color(0xf41243FB),
      dotColor:Colors.white,

      locale: 'en_ISO',
    );
  }
}
