import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mevolve/app_colors.dart';
import 'package:mevolve/mevolve_calendar/mevolve_calendar.dart';
import 'package:mevolve/mevolve_calendar/models/date_picker_preset.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (context, child) => MaterialApp(
        title: 'Mevolve',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.darkBlue,
              elevation: 0.0,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
              textStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15.sp,
              ),
            ),
          ),
        ),
        home: Material(
            child: MevolveCalendar(
          presets: [
            Preset('Never Ends', Duration.zero),
            Preset('15 days later', const Duration(days: 15)),
            Preset(
              '30 days later',
              const Duration(days: 30),
            ),
            Preset(
              '60 days later',
              const Duration(days: 60),
            ),
            Preset(
              '90 days later',
              const Duration(days: 90),
            ),
            Preset(
              '120 days later',
              const Duration(days: 120),
            ),
          ],
        )),
      ),
    );
  }
}
