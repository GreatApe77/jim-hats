import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jim_hats_mobile/core/utils/application_exception.dart';
import 'package:jim_hats_mobile/core/utils/nullable.dart';
import 'package:jim_hats_mobile/data/exercise_logs/dtos/update_exercise_log_dto.dart';
import 'package:jim_hats_mobile/data/exercise_logs/repositories/exercise_logs_repository.dart';
import 'package:jim_hats_mobile/data/uploads/dtos/upload_dto.dart';
import 'package:jim_hats_mobile/data/uploads/repositories/upload_repository.dart';

part 'edit_check_in_page_state.dart';

class EditCheckInPageCubit extends Cubit<EditCheckInPageState> {
  final ExerciseLogsRepository _exerciseLogsRepository;
  final UploadRepository _uploadRepository;
  EditCheckInPageCubit({
    required UploadRepository uploadRepository,
    required ExerciseLogsRepository exerciseLogsRepository,
  })  : _exerciseLogsRepository = exerciseLogsRepository,
        _uploadRepository = uploadRepository,
        super(
          EditCheckInPageState(
            imageUrl: '',
            errorMessage: '',
            title: '',
            description: '',
            image: null,
            status: EditCheckInPageStatus.idle,
          ),
        );

  void updateTitle(String title) {
    emit(
      state.copyWith(
        title: title,
      ),
    );
  }

  void updateDescription(String? description) {
    emit(
      state.copyWith(description: Nullable(description)),
    );
  }

  void updateImageUrl(String imageUrl) {
    emit(
      state.copyWith(
        imageUrl: imageUrl,
      ),
    );
  }

  void updateImageFile(XFile? image) {
    emit(
      state.copyWith(
        image: Nullable(image),
      ),
    );
  }

  void submitForm({
    required int challengeId,
    required int exerciseLogId,
  }) async {
    try {
      emit(
        state.copyWith(status: EditCheckInPageStatus.loading),
      );
      String url = state.imageUrl;
      if (state.image != null) {
        url = await _uploadRepository.uploadFile(
          UploadDto(fileToUpload: state.image!),
        );
      }
      await _exerciseLogsRepository.updateExerciseLog(
        challengeId: challengeId,
        exerciseLogId: exerciseLogId,
        updateExerciseLogDto: UpdateExerciseLogDto(
          title: state.title,
          description: state.description,
          image: url,
        ),
      );
      emit(state.copyWith(
        status: EditCheckInPageStatus.success,
      ));
    } on ApplicationException catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.getMessage(),
          status: EditCheckInPageStatus.error,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: 'Unknown error while updating check in',
          status: EditCheckInPageStatus.error,
        ),
      );
    }
  }
}
