part of 'gym_challenge_details_page_cubit.dart';

@immutable
sealed class GymChallengeDetailsPageState {}

final class GymChallengeDetailsPageInitial
    extends GymChallengeDetailsPageState {}

final class GymChallengeDetailsPageLoadDataInProgress
    extends GymChallengeDetailsPageState {}

final class GymChallengeDetailsPageLoadError
    extends GymChallengeDetailsPageState {}

final class GymChallengeDetailsPageLoadSuccess
    extends GymChallengeDetailsPageState {
  final ChallengeMember admin;
  final List<ChallengeMember> members;
  final GymChallenge challenge;
  GymChallengeDetailsPageLoadSuccess( 
      {required this.members, required this.admin,required this.challenge});
}
