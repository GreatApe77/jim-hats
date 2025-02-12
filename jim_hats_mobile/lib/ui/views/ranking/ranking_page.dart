import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/shared/ui/constants/app_spacings.dart';
import 'package:jim_hats_mobile/ui/views/gym_challenge/gym_challenge_page_arguments.dart';
import 'package:jim_hats_mobile/ui/views/ranking/cubit/ranking_page_cubit.dart';

class RankingPage extends StatefulWidget {
  final GymChallengePageArguments arguments;
  final RankingPageCubit rankingPageCubit;
  const RankingPage(
      {super.key, required this.arguments, required this.rankingPageCubit});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  @override
  void initState() {
    super.initState();
    widget.rankingPageCubit.loadData(widget.arguments.challengeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<RankingPageCubit, RankingPageState>(
        bloc: widget.rankingPageCubit,
        builder: (context, state) {
          if (state is RankingPageInitial) {
            return SizedBox.shrink();
          }
          if (state is RankingPageDataLoadInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is RankingPagedDataLoadSuccess) {
            return SafeArea(
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSpacings.horizontalPadding.toDouble()),
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            state.challenge.name,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        LinearProgressIndicator(
                          value: _getRemainingDaysPercentage(
                              startDate: state.challenge.startAt,
                              endDate: state.challenge.endAt),
                          minHeight: 20,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'Starts ${_formatDateToString(state.challenge.startAt)}'),
                              Text(
                                  'Finishes ${_formatDateToString(state.challenge.endAt)}'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Rankings',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        ListView.builder(
                          itemCount: state.rankings.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(state.rankings[index].username),
                              subtitle: Text(
                                  '${state.rankings[index].logCount} days active'),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    state.rankings[index].profilePicture ?? ''),
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Group stats',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        ListTile(
                          title: Text(
                              '${widget.rankingPageCubit.countTotalOfLogs(state.rankings)}'),
                        subtitle: Text('Total check-ins'),
                        leading: Icon(Icons.monitor_heart),
                        )
                      ],
                    )));
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  String _formatDateToString(DateTime date) {
    Map<int, String> monthNumberToName = {
      1: 'January',
      2: 'February',
      3: 'March',
      4: 'April',
      5: 'May',
      6: 'June',
      7: 'July',
      8: 'August',
      9: 'September',
      10: 'October',
      11: 'November',
      12: 'December',
    };
    return '${monthNumberToName[date.month]} ${date.day}, ${date.year}';
  }

  double _getRemainingDaysPercentage({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    final today = DateTime.now();

    final challengeTimeInDays = endDate.difference(startDate).inDays;
    final daysPassed = today.difference(startDate).inDays;
    final percentage = daysPassed.toDouble() / challengeTimeInDays.toDouble();

    return percentage.isNaN?0:percentage;
  }
}
