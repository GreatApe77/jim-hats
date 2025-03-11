import 'package:bloc/bloc.dart';
import 'package:jim_hats_mobile/core/utils/application_exception.dart';
import 'package:jim_hats_mobile/data/exercise_logs/repositories/exercise_logs_repository.dart';

part 'check_in_page_state.dart';

class CheckInPageCubit extends Cubit<CheckInPageState> {
  final ExerciseLogsRepository _exerciseLogsRepository;
  CheckInPageCubit({
    required ExerciseLogsRepository exerciseLogsRepository,
  })  : _exerciseLogsRepository = exerciseLogsRepository,
        super(CheckInPageInitial());

  void deleteCheckIn({
    required int challengeId,
    required int exerciseLogId,
  }) async {
    try {
      emit(CheckInPageLoading());
      await _exerciseLogsRepository.deleteExerciseLog(
        exerciseLogId,
        challengeId,
      );
      emit(CheckInPageSuccess());
    } on ApplicationException catch (e) {
      emit(
        CheckInPageError(
          errorMessage: e.getMessage(),
        ),
      );
    } catch (e) {
      emit(
        CheckInPageError(
          errorMessage: 'Unknown error while deleting exercise log',
        ),
      );
    }
  }
}
