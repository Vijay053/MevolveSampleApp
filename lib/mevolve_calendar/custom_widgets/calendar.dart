import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mevolve/mevolve_calendar/date_picker_controller.dart';
import 'package:provider/provider.dart';

class CalenderWidget extends StatefulWidget {
  const CalenderWidget({Key? key}) : super(key: key);

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  late PageController _pageController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final datePickerController = Provider.of<DatePickerController>(context);
    _pageController =
        PageController(initialPage: datePickerController.getInitialPageIndex());
  }

  @override
  Widget build(BuildContext context) {
    final datePickerController = Provider.of<DatePickerController>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                datePickerController.currentPageIndex.value--;
                _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.bounceInOut);
              },
              child: const Icon(
                Icons.arrow_left_rounded,
                color: Colors.grey,
              ),
            ),
            ValueListenableBuilder(
                valueListenable: datePickerController.currentPageIndex,
                builder: (context, value, child) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        DateFormat.yMMMM()
                            .format(datePickerController.currentIndexMonthDate),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                        ),
                      ),
                    )),
            InkWell(
              onTap: () {
                datePickerController.currentPageIndex.value++;
                _pageController.nextPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.bounceInOut);
              },
              child: const Icon(
                Icons.arrow_right_rounded,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        SizedBox(
            height: 340,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                datePickerController.currentPageIndex.value = index;
              },
              itemBuilder: (context, index) {
                return const _DateViewWidget();
              },
            )),
      ],
    );
  }
}

class _DateViewWidget extends StatelessWidget {
  const _DateViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final datePickerController = Provider.of<DatePickerController>(context);
    final monthToShowDate = datePickerController.currentIndexMonthDate;
    final monthStartDate =
        DateTime(monthToShowDate.year, monthToShowDate.month, 1);
    final monthEndDate =
        DateTime(monthToShowDate.year, monthToShowDate.month + 1, 0);
    final startDate =
        monthStartDate.subtract(Duration(days: monthStartDate.weekday));
    final endDate = monthEndDate.add(Duration(days: 7 - monthEndDate.weekday));
    return GridView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: endDate.difference(startDate).inDays + 7,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
      ),
      itemBuilder: (context, index) {
        if (index < 7) return _getHeaderWidget(index);
        final date = startDate.add(Duration(days: (index - 7)));
        if ((date.isAfter(monthStartDate) ||
                date.isAtSameMomentAs(monthStartDate)) &&
            (date.isBefore(monthEndDate) ||
                date.isAtSameMomentAs(monthEndDate))) {
          if (date.isAtSameMomentAs(datePickerController.selectedDate)) {
            return _DateTextWidget(
              date,
              isSelected: true,
            );
          } else {
            return _DateTextWidget(date);
          }
        } else {
          return _DateTextWidget(
            date,
            isCurrentMonthDate: false,
          );
        }
      },
    );
  }

  Widget _getHeaderWidget(int index) {
    switch (index) {
      case 0:
        return const _DayNameWidget('Sun');
      case 1:
        return const _DayNameWidget('Mon');
      case 2:
        return const _DayNameWidget('Tue');
      case 3:
        return const _DayNameWidget('Wed');
      case 4:
        return const _DayNameWidget('Thu');
      case 5:
        return const _DayNameWidget('Fri');
      case 6:
        return const _DayNameWidget('Sat');
      default:
        return Container();
    }
  }
}

class _DateTextWidget extends StatelessWidget {
  final DateTime dateToShow;
  final bool isSelected;
  final bool isCurrentMonthDate;

  const _DateTextWidget(this.dateToShow,
      {Key? key, this.isSelected = false, this.isCurrentMonthDate = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final datePickerController = Provider.of<DatePickerController>(context);
    return InkWell(
      onTap: () {
        datePickerController.selectedDate = dateToShow;
      },
      borderRadius: BorderRadius.circular(25),
      child: isSelected
          ? Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.blue),
              child: Center(
                  child: Text(
                dateToShow.day.toString(),
                style: const TextStyle(color: Colors.white),
              )),
            )
          : Center(
              child: Text(
              dateToShow.day.toString(),
              style: TextStyle(
                  color: isCurrentMonthDate ? Colors.black : Colors.grey),
            )),
    );
  }
}

class _DayNameWidget extends StatelessWidget {
  final String dayName;

  const _DayNameWidget(this.dayName, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      dayName,
      style: TextStyle(fontWeight: FontWeight.w400),
    ));
  }
}
