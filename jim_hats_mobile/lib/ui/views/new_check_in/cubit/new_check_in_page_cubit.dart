import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:jim_hats_mobile/data/exercise_logs/dtos/add_exercise_log_to_challenge_dto.dart';
import 'package:jim_hats_mobile/data/exercise_logs/repositories/exercise_logs_repository.dart';
import 'package:jim_hats_mobile/data/uploads/dtos/upload_dto.dart';
import 'package:jim_hats_mobile/data/uploads/repositories/upload_repository.dart';
import 'package:jim_hats_mobile/shared/utils/nullable.dart';

part 'new_check_in_page_state.dart';

class NewCheckInPageCubit extends Cubit<NewCheckInPageState> {
  final ExerciseLogsRepository _exerciseLogsRepository;
  final UploadRepository _uploadRepository;
  NewCheckInPageCubit({
    required XFile checkInPhoto,
    required ExerciseLogsRepository exerciseLogsRepositoy,
    required UploadRepository uploadRepository,
  })  : _uploadRepository = uploadRepository,
        _exerciseLogsRepository = exerciseLogsRepositoy,
        super(NewCheckInPageState(
            status: NewCheckInPageStatus.idle,
            photo: checkInPhoto,
            title: '',
            description: ''));

  void updateTitle(String title) {
    emit(state.copyWith(title: title));
  }

  void updateDescription(String description) {
    emit(state.copyWith(description: description));
  }

  void updateImage(XFile? image) {
    emit(state.copyWith(photo: Nullable(image)));
  }

  void submitForm(int challengeId) async {
    try {
      emit(state.copyWith(status: NewCheckInPageStatus.loading));

      String? photoUrl;
      if (state.photo != null) {
        photoUrl = await _uploadRepository
            .uploadFile(UploadDto(fileToUpload: state.photo!));
      }

      final dto = AddExerciseLogToChallengeDto(
          title: state.title, description: state.description, image: photoUrl);

      await _exerciseLogsRepository.addExerciseLogToChallenge(challengeId, dto);
      emit(state.copyWith(status: NewCheckInPageStatus.success));
    } catch (e) {
      emit(state.copyWith(status: NewCheckInPageStatus.failed));
    }
  }
}
