import 'package:flutter/material.dart';
import 'package:jim_hats_mobile/core/constants/app_spacings.dart';
import 'package:jim_hats_mobile/presentation/views/user_calendars_page/user_calendars_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/widgets/calendar/calendar.dart';

class UserCalendarsPage extends StatelessWidget {
  final UserCalendarsPageArguments calendarsPageArguments;
  const UserCalendarsPage({super.key, required this.calendarsPageArguments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacings.horizontalPadding.toDouble(),
        ),
        child: SafeArea(
          child: ListView.separated(
           separatorBuilder: (context, index) => SizedBox(
            height: 48,
           ),
            itemCount:
                calendarsPageArguments.exerciseLogsGroupedByDate.keys.length,
            itemBuilder: (context, index) => Calendar(
              date: calendarsPageArguments
                  .exerciseLogsGroupedByDate[calendarsPageArguments
                      .exerciseLogsGroupedByDate.keys
                      .toList()[index]]![0]
                  .date,
              logsOfTheMonth: calendarsPageArguments.exerciseLogsGroupedByDate[
                  calendarsPageArguments.exerciseLogsGroupedByDate.keys
                      .toList()[index]]!,
              onDayTap: (day, logs) {},
            ),
          ),
        ),
      ),
    );
  }
}
