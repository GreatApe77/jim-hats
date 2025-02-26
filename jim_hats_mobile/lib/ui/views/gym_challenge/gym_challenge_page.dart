import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log_with_user.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/gym_challenge.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/routing/app_routes.dart';
import 'package:jim_hats_mobile/shared/ui/constants/app_spacings.dart';
import 'package:jim_hats_mobile/shared/ui/widgets/app_drawer/app_drawer.dart';
import 'package:jim_hats_mobile/shared/ui/widgets/app_drawer/cubit/app_drawer_cubit.dart';
import 'package:jim_hats_mobile/shared/ui/widgets/exercise_log_tile/exercise_log_tile.dart';
import 'package:jim_hats_mobile/shared/ui/widgets/take_photo_widget/take_photo_widget.dart';
import 'package:jim_hats_mobile/shared/utils/readable_date.dart';
import 'package:jim_hats_mobile/ui/views/check_in_page/check_in_page_arguments.dart';
import 'package:jim_hats_mobile/ui/views/gym_challenge/cubit/gym_challenge_page_cubit.dart';
import 'package:jim_hats_mobile/ui/views/gym_challenge/gym_challenge_page_arguments.dart';
import 'package:jim_hats_mobile/ui/views/gym_challenge/widgets/challenge_banner.dart';
import 'package:jim_hats_mobile/ui/views/new_check_in/new_check_in_page_arguments.dart';

class GymChallengePage extends StatefulWidget {
  final GymChallengePageCubit gymChallengePageCubit;
  final GymChallengePageArguments gymChallengePageArguments;
  const GymChallengePage(
      {super.key,
      required this.gymChallengePageArguments,
      required this.gymChallengePageCubit});

  @override
  State<GymChallengePage> createState() => _GymChallengePageState();
}

class _GymChallengePageState extends State<GymChallengePage> {
  @override
  void initState() {
    super.initState();
    int challengeIdFromRouteArguments =
        widget.gymChallengePageArguments.challengeId;
    widget.gymChallengePageCubit.loadLogs(challengeIdFromRouteArguments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        indicatorColor: Colors.transparent,
        onDestinationSelected: (value) {
          switch (value) {
            case 0:
              Navigator.of(context).pushNamed(AppRoutes.gymChallengeDetails,
                  arguments: widget.gymChallengePageArguments);
              break;
            case 1:
              Navigator.of(context).pushNamed(AppRoutes.ranking,
                  arguments: widget.gymChallengePageArguments);
              break;
            case 2:
              break;
            default:
          }
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.book), label: 'Details'),
          NavigationDestination(icon: Icon(Icons.list), label: 'Rankings'),
          NavigationDestination(icon: Icon(Icons.chat), label: 'Chat'),
        ],
      ),
      drawer: AppDrawer(appDrawerCubit: locator.get<AppDrawerCubit>()),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => TakePhotoWidget(
              onPhotoChosen: (photo) {
                if(photo==null) {
                  Navigator.of(context).pop();
                  return;
                }
                Navigator.of(context).pushNamed(AppRoutes.newCheckIn,
                    arguments: NewCheckInPageArguments(
                        photo: photo,
                        challengeId:
                            widget.gymChallengePageArguments.challengeId));
              },
            ),
          ));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))
        ],
      ),
      body: BlocBuilder<GymChallengePageCubit, GymChallengePageState>(
        bloc: widget.gymChallengePageCubit,
        builder: (context, state) {
          if (state is GymChallengePageInitial) {
            return SizedBox.shrink();
          }
          if (state is GymChallengePageDataLoadInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is GymChallengePageDataLoadFailure) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is GymChallengePageDataSuccess) {
            return SafeArea(
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppSpacings.horizontalPadding.toDouble()),
                  child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Text(
                            state.challenge.name,
                            style: Theme.of(context).textTheme.headlineMedium,
                          );
                        }
                        if (index == 1) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 25),
                            child: ChallengeBanner(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    AppRoutes.ranking,
                                    arguments:
                                        widget.gymChallengePageArguments);
                              },
                              leader: state.leader,
                              user: state.userRanking,
                              challenge: state.challenge,
                            ),
                          );
                        }
                        return ListView.builder(
                          reverse: true,
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.logsGroupedByDate.keys.length,
                          itemBuilder: (context, index1) {
                            String date =
                                state.logsGroupedByDate.keys.elementAt(index1);

                            //final String year = date.substring(0,5);

                            return Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    _formatDayStringFromKey(date),
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                ListView.builder(
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      state.logsGroupedByDate[date]!.length,
                                  itemBuilder: (context, index2) {
                                    final exerciseLog =
                                        state.logsGroupedByDate[date]![index2];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2),
                                      child: ExerciseLogTile(
                                        onTap: () {
                                          final arguments =
                                              CheckInPageArguments(
                                                  exerciseLog: exerciseLog);
                                          Navigator.of(context).pushNamed(
                                              AppRoutes.checkIn,
                                              arguments: arguments);
                                        },
                                        exerciseLogWithUser: exerciseLog,
                                      ),
                                    );
                                  },
                                )
                              ],
                            );
                          },
                        );
                      })
                  // ListView.builder(
                  //   itemCount: state.logs.length + 2,
                  //   itemBuilder: (context, index) {
                  //     if (index == 0) {
                  //       return Text(
                  //         state.challenge.name,
                  //         style: Theme.of(context).textTheme.headlineMedium,
                  //       );
                  //     }
                  //     if (index == 1) {
                  //       return Padding(
                  //         padding: const EdgeInsets.symmetric(vertical: 25),
                  //         child: ChallengeBanner(
                  //           onTap: () {
                  //             Navigator.of(context).pushNamed(
                  //                 AppRoutes.gymChallengeDetails,
                  //                 arguments: widget.gymChallengePageArguments);
                  //           },
                  //           leader: state.leader,
                  //           user: state.userRanking,
                  //           challenge: state.challenge,
                  //         ),
                  //       );
                  //     }
                  //     return Padding(
                  //       padding: const EdgeInsets.symmetric(vertical: 2),
                  //       child: ExerciseLogTile(
                  //         exerciseLogWithUser: state.logs[index - 2],
                  //       ),
                  //     );
                  //   },
                  // ),
                  ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  String _formatDayStringFromKey(String key) {
    final splittedDate = key.split('-');
    final int year = int.parse(splittedDate[0]);
    final int month = int.parse(splittedDate[1]);
    final int day = int.parse(splittedDate[2]);
    final dayOfChallenges = DateTime(year, month, day);
    switch (_calculateDifference(dayOfChallenges)) {
      case 0:
        return 'Today';
      case -1:
        return 'Yesterday';
      default:
        return key;
    }
  }

  int _calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }
}
