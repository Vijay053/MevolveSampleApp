import 'package:flutter/material.dart';

class CalenderWidget extends StatefulWidget {
  const CalenderWidget({Key? key}) : super(key: key);

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.arrow_left_rounded,
              color: Colors.grey,
            ),
            Text('September 2022'),
            Icon(
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
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
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
              _DateViewWidget(),
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
    return Expanded(
      child: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
        itemBuilder: (context, index) {
          return GridTile(child: Center(child: Text('Hi')));
        },
      ),
    );
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
