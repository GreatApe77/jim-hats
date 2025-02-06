part of 'gym_challenge_page_cubit.dart';

@immutable
sealed class GymChallengePageState {}

final class GymChallengePageInitial extends GymChallengePageState {}

final class GymChallengePageDataLoadInProgress extends GymChallengePageState{}

final class GymChallengePageDataSuccess extends GymChallengePageState{
  final List<ExerciseLogWithUser> logs;
  final GymChallenge challenge;

  GymChallengePageDataSuccess({required this.logs,required this.challenge}); 
}