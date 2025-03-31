import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/core/constants/app_spacings.dart';
import 'package:jim_hats_mobile/core/utils/date_helper.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/presentation/cubits/ranking_page/ranking_page_cubit.dart';
import 'package:jim_hats_mobile/presentation/views/ranking/ranking_page_arguments.dart';
import 'package:jim_hats_mobile/presentation/widgets/user_circle_avatar/user_circle_avatar.dart';

class RankingPage extends StatelessWidget {
  final RankingPageArguments rankingPageArguments;
  const RankingPage({
    super.key,
    required this.rankingPageArguments,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RankingPageCubit>(
      create: (context) => locator.get<RankingPageCubit>()
        ..loadData(rankingPageArguments.challengeId),
      child: const RankingView(),
    );
  }
}

class RankingView extends StatelessWidget {
  const RankingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<RankingPageCubit, RankingPageState>(
        bloc: context.read<RankingPageCubit>(),
        builder: (context, state) {
          if (state is RankingPageDataLoadInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is RankingPagedDataLoadSuccess) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppSpacings.horizontalPadding),
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
                            'Starts ${DateHelper.formatDateShort(state.challenge.startAt)}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            'Finishes ${DateHelper.formatDateShort(state.challenge.endAt)}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
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
                          leading: UserCircleAvatar(
                            username: state.rankings[index].username,
                            avatarUrl: state.rankings[index].profilePicture,
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
                          key: Key('RankingView.total_count_text'),
                          '${context.read<RankingPageCubit>().countTotalOfLogs(state.rankings)}'),
                      subtitle: Text('Total check-ins'),
                      leading: Icon(Icons.monitor_heart),
                    )
                  ],
                ),
              ),
            );
          }
          return SizedBox.shrink(
            key: Key('RankingView.shrinked_sized_box'),
          );
        },
      ),
    );
  }

  double _getRemainingDaysPercentage({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    final today = DateTime.now();

    final challengeTimeInDays = endDate.difference(startDate).inDays;
    final daysPassed = today.difference(startDate).inDays;
    if (daysPassed <= 0) return 0;
    final percentage = daysPassed.toDouble() / challengeTimeInDays.toDouble();

    return percentage.isNaN ? 0 : percentage;
  }
}
