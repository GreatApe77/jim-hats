part of 'ranking_page_cubit.dart';

@immutable
sealed class RankingPageState {}

final class RankingPageInitial extends RankingPageState {}

final class RankingPageDataLoadInProgress extends RankingPageState {}

final class RankingPagedDataLoadSuccess extends RankingPageState {
  final List<Ranking> rankings;
  final GymChallenge challenge;

  RankingPagedDataLoadSuccess(
      {required this.rankings, required this.challenge});
}
