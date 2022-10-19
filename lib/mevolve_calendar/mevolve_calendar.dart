import 'package:flutter/material.dart';
import 'package:mevolve/mevolve_calendar/custom_widgets/calendar.dart';
import 'package:mevolve/mevolve_calendar/date_picker_controller.dart';
import 'package:provider/provider.dart';

class MevolveCalendar extends StatefulWidget {
  const MevolveCalendar({Key? key}) : super(key: key);

  @override
  State<MevolveCalendar> createState() => _MevolveCalendarState();
}

class _MevolveCalendarState extends State<MevolveCalendar> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DatePickerController>(create: (_) => DatePickerController()),
      ],
      child: Builder(
        builder: (context) => Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              Row(
                children: const [Text('')],
              ),
              const CalenderWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
