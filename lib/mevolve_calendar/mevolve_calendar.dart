import 'package:flutter/material.dart';
import 'package:mevolve/mevolve_calendar/custom_widgets/calendar.dart';

class MevolveCalendar extends StatefulWidget {
  const MevolveCalendar({Key? key}) : super(key: key);

  @override
  State<MevolveCalendar> createState() => _MevolveCalendarState();
}

class _MevolveCalendarState extends State<MevolveCalendar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Row(
            children: [Text('')],
          ),
          const CalenderWidget(),
        ],
      ),
    );
  }
}
