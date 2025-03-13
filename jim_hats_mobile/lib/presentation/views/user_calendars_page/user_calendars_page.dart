import 'package:flutter/material.dart';
import 'package:jim_hats_mobile/core/constants/app_spacings.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log_with_user.dart';
import 'package:jim_hats_mobile/presentation/routing/app_routes.dart';
import 'package:jim_hats_mobile/presentation/views/check_in_page/check_in_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/views/user_calendars_page/user_calendars_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/widgets/calendar/calendar.dart';
import 'package:jim_hats_mobile/presentation/widgets/exercise_log_tile/exercise_log_tile.dart';

class UserCalendarsPage extends StatelessWidget {
  final UserCalendarsPageArguments calendarsPageArguments;
  const UserCalendarsPage({super.key, required this.calendarsPageArguments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacings.horizontalPadding,
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
              onDayTap: (day, logs) {
                showModalBottomSheet(
                  useSafeArea: true,
                  showDragHandle: true,
                  context: context,
                  builder: (context) => ListView(
                    children: logs.map(
                      (log) {
                        final mappedExerciseLog = ExerciseLogWithUser(
                          user: User(
                            username:
                                calendarsPageArguments.loggedUser.username,
                            profilePicture: calendarsPageArguments
                                .loggedUser.profilePicture,
                          ),
                          id: log.id,
                          title: log.title,
                          date: log.date,
                          userId: log.userId,
                          gymChallengeId: log.gymChallengeId,
                        );
                        return ExerciseLogTile(
                          exerciseLogWithUser: mappedExerciseLog,
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              AppRoutes.checkIn,
                              arguments: CheckInPageArguments(
                                exerciseLog: mappedExerciseLog,
                              ),
                            );
                          },
                        );
                      },
                    ).toList(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
