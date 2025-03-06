import 'package:flutter/material.dart';
import 'package:jim_hats_mobile/core/utils/date_helper.dart';

class Calendar extends StatelessWidget {
  final DateTime date;
  final DateTime selectedDate = DateTime.now();
   Calendar({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${DateHelper.monthNumberToName[date.month]} ${date.year}',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Row(),
        _buildWeekDays(context),
        _buildCalendar(context),
      ],
    );
  }

  Widget _buildWeekDays(BuildContext context) {
    final weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    final widgets = weekDays
        .map(
          (e) => Container(
            margin: EdgeInsets.all(4),
            child: Center(
              child: Text(
                e,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ),
        )
        .toList();
    return GridView.count(
      crossAxisCount: weekDays.length,
      shrinkWrap: true,
      children: widgets,
    );
  }

  Widget _buildCalendar(BuildContext context) {
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    final lastDayOfMonth = DateTime(date.year, date.month + 1, 0);
    final daysInMonth = lastDayOfMonth.day;
    final firstWeekday = firstDayOfMonth.weekday;

    List<Widget> dayWidgets = [];
    for (int i = 0; i < firstWeekday; i++) {
      dayWidgets.add(Container());
    }

    for (int day = 1; day <= daysInMonth; day++) {
      dayWidgets.add(
        Container(
          margin: EdgeInsets.all(4),
          child: Center(child: Text(day.toString())),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.onInverseSurface),
      child: GridView.count(
        crossAxisCount: 7,
        shrinkWrap: true,
        children: dayWidgets,
      ),
    );
  }
}
