import 'package:flutter/cupertino.dart';

class DatePickerController {
  DateTime startDate = DateTime(2021, 1, 1);
  DateTime endDate = DateTime(2023, 12, 31);
  ValueNotifier<DateTime> selectedDate = ValueNotifier(
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));
  ValueNotifier<int> currentPageIndex = ValueNotifier(0);
  ValueNotifier<int?> selectedPreset = ValueNotifier(null);

  DateTime get currentIndexMonthDate {
    return DateTime(startDate.year + currentPageIndex.value ~/ 12,
        (startDate.month - 1) + (currentPageIndex.value.remainder(12)), 1);
  }

  int getSelectedDatePageIndex() {
    if (startDate.year == selectedDate.value.year) {
      currentPageIndex.value = selectedDate.value.month;
    } else {
      currentPageIndex.value =
          ((selectedDate.value.year - startDate.year) * 12) +
              selectedDate.value.month;
    }
    return currentPageIndex.value;
  }

  void selectDateWithDuration(Duration duration) {
    selectedDate.value =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
            .add(duration);
    getSelectedDatePageIndex();
  }
}
