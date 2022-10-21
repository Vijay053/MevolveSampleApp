import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mevolve/mevolve_calendar/mevolve_calendar.dart';

import 'mevolve_calendar/models/date_picker_preset.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mevolve Sample App'),
      ),
      body: SafeArea(
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.7,
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              selectedDate =
                                  await showDatePickerWithoutPresets(context);
                              setState(() {});
                            },
                            child: const Text('Date Picker (Without presets)'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              selectedDate =
                                  await showDatePickerWithPresets(context);
                              setState(() {});
                            },
                            child: const Text('Date Picker (With presets)'),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            'Selected Date is',
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            selectedDate == null
                                ? '-'
                                : DateFormat('d MMM y').format(selectedDate!),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Vijay Kumar Meena',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<DateTime?> showDatePickerWithoutPresets(BuildContext context) {
    return showDialog<DateTime>(
      context: context,
      builder: (context) => const MevolveCalendar(),
    );
  }

  Future<DateTime?> showDatePickerWithPresets(BuildContext context) {
    return showDialog<DateTime>(
      context: context,
      builder: (context) => MevolveCalendar(
        presets: [
          Preset('Today', Duration.zero),
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
      ),
    );
  }
}
