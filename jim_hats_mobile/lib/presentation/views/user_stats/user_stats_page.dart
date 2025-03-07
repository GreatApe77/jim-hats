import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/app.dart';
import 'package:jim_hats_mobile/core/constants/app_spacings.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log_with_user.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/cubits/app_drawer/app_drawer_cubit.dart';
import 'package:jim_hats_mobile/presentation/cubits/user_stats_page/user_stats_cubit.dart';
import 'package:jim_hats_mobile/presentation/routing/app_routes.dart';
import 'package:jim_hats_mobile/presentation/views/check_in_page/check_in_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/views/user_stats/widgets/stats_item.dart';
import 'package:jim_hats_mobile/presentation/widgets/app_drawer/app_drawer.dart';
import 'package:jim_hats_mobile/presentation/widgets/calendar/calendar.dart';
import 'package:jim_hats_mobile/presentation/widgets/exercise_log_tile/exercise_log_tile.dart';

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
          if (state is UserStatsInitial) {
            return SizedBox.shrink();
          }
          if (state is UserStatsDataLoadInProgess) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UsersStatsDataSuccess) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSpacings.horizontalPadding.toDouble()),
              child: SafeArea(
                  child: ListView(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(state.loggedUser.profilePicture ?? ''),
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
                          // scaffoldMessengerKey.currentState?.showSnackBar(
                          //   SnackBar(
                          //     content: Text(
                          //       'Day: ${day} amount: ${logs.length}',
                          //     ),
                          //   ),
                          // );
                          showModalBottomSheet(
                            showDragHandle: true,
                            context: context,
                            builder: (context) => SafeArea(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
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
                            ),
                          );
                        },
                        date: DateTime.now(),
                        logsOfTheMonth: [
                          ExerciseLog(
                              id: 1,
                              title: 'Title 1',
                              date: DateTime(2025, 2, 5),
                              userId: state.loggedUser.id,
                              gymChallengeId: 8),
                          ExerciseLog(
                              id: 1,
                              title: 'Title 2',
                              date: DateTime(2025, 2, 5),
                              userId: state.loggedUser.id,
                              gymChallengeId: 8),
                          ExerciseLog(
                              id: 1,
                              title: 'Title 3',
                              date: DateTime(2025, 2, 5),
                              userId: state.loggedUser.id,
                              gymChallengeId: 8),
                          ExerciseLog(
                              id: 1,
                              title: 'Title 4',
                              date: DateTime(2025, 2, 7),
                              userId: state.loggedUser.id,
                              gymChallengeId: 8),
                        ],
                      )
                    ],
                  )
                ],
              )),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
