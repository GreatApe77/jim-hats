import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'gym_challenge_details_page_state.dart';

class GymChallengeDetailsPageCubit extends Cubit<GymChallengeDetailsPageState> {
  GymChallengeDetailsPageCubit() : super(GymChallengeDetailsPageInitial());
}
