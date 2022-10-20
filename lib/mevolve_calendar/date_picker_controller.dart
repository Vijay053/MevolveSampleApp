import 'package:flutter/cupertino.dart';

class DatePickerController {
  DateTime startDate = DateTime(2021, 1, 1);
  DateTime endDate = DateTime(2023, 12, 31);
  DateTime selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  ValueNotifier<int> currentPageIndex = ValueNotifier(0);

  DateTime get currentIndexMonthDate {
    return DateTime(startDate.year + currentPageIndex.value ~/ 12,
        (startDate.month - 1) + (currentPageIndex.value.remainder(12)), 1);
  }

  int getInitialPageIndex() {
    if (startDate.year == selectedDate.year) {
      currentPageIndex.value = selectedDate.month;
    } else {
      currentPageIndex.value =
          ((selectedDate.year - startDate.year) * 12) + selectedDate.month;
    }
    return currentPageIndex.value;
  }
}
