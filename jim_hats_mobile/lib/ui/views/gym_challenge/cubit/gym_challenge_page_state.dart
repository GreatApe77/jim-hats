part of 'gym_challenge_page_cubit.dart';

@immutable
sealed class GymChallengePageState {}

final class GymChallengePageInitial extends GymChallengePageState {}

final class GymChallengePageDataLoadInProgress extends GymChallengePageState{}

final class GymChallengePageDataSuccess extends GymChallengePageState{
  final List<ExerciseLogWithUser> logs;
  final GymChallenge challenge;
  final Ranking leader;
  final Ranking userRanking;
  final Map<String,List<ExerciseLogWithUser>> logsGroupedByDate;
  GymChallengePageDataSuccess({
    required this.logsGroupedByDate,
    required this.leader,
    required this.userRanking,
    required this.logs,required this.challenge}); 
}