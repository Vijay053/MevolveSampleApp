import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mevolve/mevolve_calendar/date_picker_controller.dart';
import 'package:provider/provider.dart';

class CalenderWidget extends StatefulWidget {
  const CalenderWidget({Key? key}) : super(key: key);

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  @override
  Widget build(BuildContext context) {
    final datePickerController = Provider.of<DatePickerController>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.arrow_left_rounded,
              color: Colors.grey,
            ),
            Text(DateFormat.yMMMM().format(datePickerController.selectedDate)),
            const Icon(
              Icons.arrow_right_rounded,
              color: Colors.grey,
            ),
          ],
        ),
        const _SwipeableCalendar(),
      ],
    );
  }
}

class _SwipeableCalendar extends StatefulWidget {
  const _SwipeableCalendar({Key? key}) : super(key: key);

  @override
  State<_SwipeableCalendar> createState() => _SwipeableCalendarState();
}

class _SwipeableCalendarState extends State<_SwipeableCalendar> {
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
    print(_pageController.initialPage);
    return SizedBox(
      height: 500,
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          print(index);
          setState(() {});
        },
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  _DayNameWidget('Sun'),
                  _DayNameWidget('Mon'),
                  _DayNameWidget('Tue'),
                  _DayNameWidget('Wed'),
                  _DayNameWidget('Thu'),
                  _DayNameWidget('Fri'),
                  _DayNameWidget('Sat'),
                ],
              ),
              const _DateViewWidget(),
            ],
          );
        },
      ),
    );
  }
}

class _DateViewWidget extends StatelessWidget {
  const _DateViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final datePickerController = Provider.of<DatePickerController>(context);
    final selectedDate = datePickerController.selectedDate;
    final monthStartDate = DateTime(selectedDate.year, selectedDate.month, 1);
    final monthEndDate = DateTime(selectedDate.year, selectedDate.month + 1, 0);
    final startDate =
        monthStartDate.subtract(Duration(days: monthStartDate.weekday));
    return Expanded(
      child: GridView.builder(
        itemCount: 42,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
        itemBuilder: (context, index) {
          final date = startDate.add(Duration(days: index));
          if ((date.isAfter(monthStartDate) ||
                  date.isAtSameMomentAs(monthStartDate)) &&
              (date.isBefore(monthEndDate) ||
                  date.isAtSameMomentAs(monthEndDate))) {
            if (date.isAtSameMomentAs(selectedDate)) {
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
      ),
    );
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
    if (isSelected) {
      return Container(
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
        child: Center(
            child: Text(
          dateToShow.day.toString(),
          style: const TextStyle(color: Colors.white),
        )),
      );
    } else {
      return Center(
          child: Text(
        dateToShow.day.toString(),
        style:
            TextStyle(color: isCurrentMonthDate ? Colors.black : Colors.grey),
      ));
    }
  }
}

class _DayNameWidget extends StatelessWidget {
  final String dayName;

  const _DayNameWidget(this.dayName, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(dayName));
  }
}
