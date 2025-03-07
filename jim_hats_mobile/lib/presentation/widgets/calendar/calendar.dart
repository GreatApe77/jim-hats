import 'package:flutter/material.dart';
import 'package:jim_hats_mobile/core/utils/date_helper.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log.dart';


class Calendar extends StatelessWidget {
  final DateTime date;
  final List<ExerciseLog> logsOfTheMonth;
  final Function(int day, List<ExerciseLog> logs) onDayTap;
  const Calendar(
      {super.key,
      required this.date,
      required this.logsOfTheMonth,
      required this.onDayTap});

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
    final groupedByDay = _groupByDay(logsOfTheMonth);
    List<Widget> dayWidgets = [];
    for (int i = 0; i < firstWeekday; i++) {
      dayWidgets.add(Container());
    }

    for (int day = 1; day <= daysInMonth; day++) {
      dayWidgets.add(
        Container(
          margin: EdgeInsets.all(4),
          child: groupedByDay.containsKey(day)
              ? Stack(
                fit: StackFit.expand,
                  children: [
                    GestureDetector(
                      onTap: () => onDayTap(day,groupedByDay[day]!),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          day.toString(),
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ),
                    // Align(
                    //   alignment: Alignment.center,
                    //   child: Container(
                    //     width: 4,
                    //     decoration: BoxDecoration(
                    //         color: Theme.of(context).colorScheme.error,
                    //         shape: BoxShape.circle),
                    //   ),
                    // )
                  ],
                )
              : Center(
                child: Text(
                    day.toString(),
                  ),
              ),
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

  Map<int, List<ExerciseLog>> _groupByDay(List<ExerciseLog> exerciseLogs) {
    Map<int, List<ExerciseLog>> groupedByDay = {};
    for (var log in exerciseLogs) {
      final int day = log.date.day;
      if (!groupedByDay.containsKey(day)) {
        groupedByDay[day] = [];
      }
      groupedByDay[day]!.add(log);
    }
    return groupedByDay;
    //   for (var exerciseLog in exerciseLogs) {
    //     final String formatedDateByDay = _formatDateText(exerciseLog.date);
    //     if (!grouped.containsKey(_formatDateText(exerciseLog.date))) {
    //       grouped[formatedDateByDay] = [];
    //     }
    //     grouped[formatedDateByDay]!.add(exerciseLog);
    //   }
    //   return grouped;
    // }
  }
}
