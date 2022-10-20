import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mevolve/mevolve_calendar/custom_widgets/calendar.dart';
import 'package:mevolve/mevolve_calendar/date_picker_controller.dart';
import 'package:provider/provider.dart';

import '../custom_widgets/buttons/cancel_button.dart';

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
        builder: (context) {
          final datePickerController =
              Provider.of<DatePickerController>(context);
          return Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Row(
                  children: const [Text('')],
                ),
                const CalenderWidget(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('assets/svgs/calendar.svg'),
                          SizedBox(
                            width: 12.w,
                          ),
                          Text(DateFormat('d MMM y')
                              .format(datePickerController.selectedDate))
                        ],
                      ),
                      Row(
                        children: [
                          CancelButton(
                              onPressed: () {}, child: const Text('Cancel')),
                          SizedBox(
                            width: 16.w,
                          ),
                          ElevatedButton(
                              onPressed: () {}, child: const Text('Save')),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
