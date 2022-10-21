import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mevolve/app_colors.dart';
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
    return Center(
      child: Material(
        color: Colors.transparent,
        child: MultiProvider(
          providers: [
            Provider<DatePickerController>(
                create: (_) => DatePickerController()),
          ],
          child: Builder(
            builder: (context) {
              final datePickerController =
                  Provider.of<DatePickerController>(context);
              return FractionallySizedBox(
                widthFactor: 0.9,
                child: SingleChildScrollView(
                  child: Center(
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 420.h),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.darkBlue)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          PresetsWidget(widget.presets),
                          const CalenderWidget(),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: FittedBox(
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/svgs/calendar.svg'),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        ValueListenableBuilder(
                                          valueListenable:
                                              datePickerController.selectedDate,
                                          builder: (context, value, child) =>
                                              Text(DateFormat('d MMM y')
                                                  .format(value)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: FittedBox(
                                    child: Row(
                                      children: [
                                        CancelButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Cancel')),
                                        SizedBox(
                                          width: 12.w,
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(
                                                  context,
                                                  datePickerController
                                                      .selectedDate.value);
                                            },
                                            child: const Text('Save')),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
