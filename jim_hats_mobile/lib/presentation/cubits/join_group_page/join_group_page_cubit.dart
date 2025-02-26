import 'package:bloc/bloc.dart';
import 'package:jim_hats_mobile/core/utils/application_exception.dart';
import 'package:jim_hats_mobile/data/gym_challenges/repositories/gym_challenges_repository.dart';

part 'join_group_page_state.dart';

class JoinGroupPageCubit extends Cubit<JoinGroupPageState> {
  final GymChallengesRepository _gymChallengesRepository;
  JoinGroupPageCubit({required GymChallengesRepository gymChallengesRepository})
      : _gymChallengesRepository = gymChallengesRepository,
        super(JoinGroupPageState(
          errorMessage: '',
          groupCode: '',
          status: JoinGroupPageStatus.idle,
        ));

  void updateGroupCode(String groupCode) {
    emit(state.copyWith(groupCode: groupCode));
  }

  void submitForm() async {
    try {
      emit(state.copyWith(status: JoinGroupPageStatus.loading));

      await _gymChallengesRepository.joinChallenge(state.groupCode);
    } on ApplicationException catch (e) {
      emit(state.copyWith(
          errorMessage: e.getMessage(), status: JoinGroupPageStatus.error));
    } catch (e) {
      emit(state.copyWith(
          status: JoinGroupPageStatus.error,
          errorMessage: 'Unknown error while joining group'));
    }
  }
}
