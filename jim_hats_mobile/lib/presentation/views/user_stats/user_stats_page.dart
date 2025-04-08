import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/core/constants/app_spacings.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log_with_user.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/cubits/app_drawer/app_drawer_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/user_stats_page/user_stats_cubit.dart';
import 'package:jim_hats_mobile/presentation/routing/app_routes.dart';
import 'package:jim_hats_mobile/presentation/views/user_calendars_page/user_calendars_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/views/check_in_page/check_in_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/views/user_stats/widgets/stats_item.dart';
import 'package:jim_hats_mobile/presentation/widgets/app_drawer/app_drawer.dart';
import 'package:jim_hats_mobile/presentation/widgets/calendar/calendar.dart';
import 'package:jim_hats_mobile/presentation/widgets/exercise_log_tile/exercise_log_tile.dart';
import 'package:jim_hats_mobile/core/utils/group_by_extension.dart';

class UserStatsPage extends StatelessWidget {
  const UserStatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserStatsCubit>(
      create: (context) => locator.get<UserStatsCubit>()..loadUserStatsData(),
      child: const _UserStatsView(),
    );
  }
}

class _UserStatsView extends StatelessWidget {
  const _UserStatsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: AppDrawer(appDrawerCubit: locator.get<AppDrawerCubit>()),
      body: BlocBuilder<UserStatsCubit, UserStatsState>(
        bloc: context.read<UserStatsCubit>(),
        builder: (context, state) {
          if (state is UserStatsDataLoadInProgess) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UsersStatsDataSuccess) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSpacings.horizontalPadding),
              child: SafeArea(
                child: ListView(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              state.loggedUser.profilePicture ?? ''),
                          radius: 50,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          state.loggedUser.username,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            StatsItem(
                              key: Key('UserStatsView.total_stats_item'),
                              label: 'Check-ins',
                              value: state.logsOfUser.length.toString(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Calendar(
                          onDayTap: (day, logs) {
                            showModalBottomSheet(
                              useSafeArea: true,
                              showDragHandle: true,
                              context: context,
                              builder: (context) => ListView(
                                children: logs.map(
                                  (log) {
                                    final mappedExerciseLog =
                                        ExerciseLogWithUser(
                                      user: User(
                                        username: state.loggedUser.username,
                                        profilePicture:
                                            state.loggedUser.profilePicture,
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
                          date: DateTime.now(),
                          logsOfTheMonth: [
                            ...state.logsOfUser.where(
                              (element) =>
                                  element.date.year == DateTime.now().year &&
                                  element.date.month == DateTime.now().month,
                            )

                            // )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          final arguments = UserCalendarsPageArguments(
                            loggedUser: state.loggedUser,
                            exerciseLogsGroupedByDate:
                                _groupByMonthAndYear(state.logsOfUser),
                          );
                          Navigator.of(context).pushNamed(
                            AppRoutes.userCalendars,
                            arguments: arguments,
                          );
                        },
                        child: Text('View all check-ins'),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return SizedBox.shrink(
            key: Key('UserStatsView.shrinked_sized_box'),
          );
        },
      ),
    );
  }

  Map<String, List<ExerciseLog>> _groupByMonthAndYear(
      List<ExerciseLog> exerciseLogs) {
    final groupedLogs = exerciseLogs.groupBy<String>(
      (log) => '${log.date.month.toString().padLeft(2, '0')}/${log.date.year}',
    );

    // Sort the groups by DateTime (earliest to latest)
    final sortedKeys = groupedLogs.keys.toList()
      ..sort((a, b) {
        final dateA =
            DateTime(int.parse(a.split('/')[1]), int.parse(a.split('/')[0]));
        final dateB =
            DateTime(int.parse(b.split('/')[1]), int.parse(b.split('/')[0]));
        return dateA.compareTo(dateB);
      });

    // Reconstruct sorted map
    return {for (var key in sortedKeys) key: groupedLogs[key]!};
  }
}
