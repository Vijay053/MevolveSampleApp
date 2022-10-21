import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mevolve/app_colors.dart';
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
    _pageController = PageController(
        initialPage: datePickerController.getSelectedDatePageIndex());
    datePickerController.currentPageIndex.addListener(() {
      _pageController.jumpToPage(datePickerController.currentPageIndex.value);
    });
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
              borderRadius: BorderRadius.circular(25),
              onTap: () {
                _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.bounceInOut);
              },
              child: const Icon(
                Icons.arrow_left_rounded,
                color: Colors.grey,
                size: 35,
              ),
            ),
            ValueListenableBuilder(
                valueListenable: datePickerController.currentPageIndex,
                builder: (context, value, child) => Container(
                      //So that Icons should not move from their position
                      constraints: BoxConstraints(minWidth: 140.w),
                      child: Text(
                        DateFormat.yMMMM()
                            .format(datePickerController.currentIndexMonthDate),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                        ),
                      ),
                    )),
            InkWell(
              borderRadius: BorderRadius.circular(25),
              onTap: () {
                _pageController.nextPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.bounceInOut);
              },
              child: const Icon(
                Icons.arrow_right_rounded,
                color: Colors.grey,
                size: 35,
              ),
            ),
          ],
        ),
        SizedBox(
            height: 290.h,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                datePickerController.currentPageIndex.value = index;
              },
              itemBuilder: (context, index) {
                return _DateViewWidget(index);
              },
            )),
      ],
    );
  }
}

class _DateViewWidget extends StatelessWidget {
  final int pageIndex;

  const _DateViewWidget(this.pageIndex, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final datePickerController = Provider.of<DatePickerController>(context);
    final monthToShowDate = datePickerController.getDateFromIndex(pageIndex);
    final monthStartDate =
        DateTime(monthToShowDate.year, monthToShowDate.month, 1);
    final monthEndDate =
        DateTime(monthToShowDate.year, monthToShowDate.month + 1, 0);
    final startDate = monthStartDate
        .subtract(Duration(days: monthStartDate.weekday.remainder(7)));
    final endDate = monthEndDate.add(Duration(days: 7 - monthEndDate.weekday));
    return ValueListenableBuilder(
      valueListenable: datePickerController.selectedDate,
      builder: (context, selectedDate, child) => Column(
        children: getItems(startDate, monthStartDate, monthEndDate,
            selectedDate, endDate.difference(startDate).inDays + 7),
      ),
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

  List<Widget> getItems(DateTime startDate, DateTime monthStartDate,
      DateTime monthEndDate, DateTime selectedDate, int totalItems) {
    List<Widget> widgets = [];
    for (int row = 0; row < (totalItems / 7); row++) {
      List<Widget> rowItems = [];
      for (int column = 0; column < 7; column++) {
        int index = (row * 7) + column;
        if (index < 7) {
          rowItems.add(_getHeaderWidget(index));
        } else {
          final date = startDate.add(Duration(days: (index - 7)));
          if ((date.isAfter(monthStartDate) ||
                  date.isAtSameMomentAs(monthStartDate)) &&
              (date.isBefore(monthEndDate) ||
                  date.isAtSameMomentAs(monthEndDate))) {
            if (date.isAtSameMomentAs(selectedDate)) {
              rowItems.add(_DateTextWidget(
                date,
                isSelected: true,
              ));
            } else {
              rowItems.add(_DateTextWidget(date));
            }
          } else {
            rowItems.add(_DateTextWidget(
              date,
              isCurrentMonthDate: false,
            ));
          }
        }
      }
      widgets.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: rowItems,
      ));
    }
    return widgets;
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
    return Flexible(
      child: SizedBox(
        height: 40.h,
        child: InkWell(
          onTap: () {
            datePickerController.selectedDate.value = dateToShow;
          },
          borderRadius: BorderRadius.circular(25),
          child: isSelected
              ? Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.darkBlue),
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
        ),
      ),
    );
  }
}

class _DayNameWidget extends StatelessWidget {
  final String dayName;

  const _DayNameWidget(this.dayName, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        height: 40.h,
        child: Center(
            child: Text(
          dayName,
        )),
      ),
    );
  }
}
