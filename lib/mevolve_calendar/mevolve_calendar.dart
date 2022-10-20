import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mevolve/mevolve_calendar/custom_widgets/calendar.dart';
import 'package:mevolve/mevolve_calendar/custom_widgets/presets_widget.dart';
import 'package:mevolve/mevolve_calendar/date_picker_controller.dart';
import 'package:mevolve/mevolve_calendar/models/date_picker_preset.dart';
import 'package:provider/provider.dart';

import '../custom_widgets/buttons/cancel_button.dart';

class MevolveCalendar extends StatefulWidget {
  final List<Preset>? presets;

  const MevolveCalendar({this.presets, Key? key}) : super(key: key);

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
                PresetsWidget(widget.presets),
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
                          ValueListenableBuilder(
                            valueListenable: datePickerController.selectedDate,
                            builder: (context, value, child) =>
                                Text(DateFormat('d MMM y').format(value)),
                          )
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
