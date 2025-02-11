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
                        Text(state.challenge.name),
                      ],
                    )));
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
