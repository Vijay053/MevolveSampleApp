import 'package:flutter/cupertino.dart';

class DatePickerController {
  DateTime startDate = DateTime(2021, 1, 1);
  DateTime endDate = DateTime(2023, 12, 31);
  DateTime selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  ValueNotifier<int> currentPageIndex = ValueNotifier(0);

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
