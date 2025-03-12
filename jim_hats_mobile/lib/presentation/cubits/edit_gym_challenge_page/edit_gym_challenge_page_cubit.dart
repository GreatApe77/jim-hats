import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jim_hats_mobile/core/utils/application_exception.dart';
import 'package:jim_hats_mobile/core/utils/date_helper.dart';
import 'package:jim_hats_mobile/core/utils/nullable.dart';
import 'package:jim_hats_mobile/data/gym_challenges/dtos/update_gym_challenge_dto.dart';
import 'package:jim_hats_mobile/data/gym_challenges/repositories/gym_challenges_repository.dart';
import 'package:jim_hats_mobile/data/uploads/dtos/upload_dto.dart';
import 'package:jim_hats_mobile/data/uploads/repositories/upload_repository.dart';

part 'edit_gym_challenge_page_state.dart';

class EditGymChallengePageCubit extends Cubit<EditGymChallengePageState> {
  final UploadRepository _uploadRepository;
  final GymChallengesRepository _gymChallengesRepository;
  EditGymChallengePageCubit({
    required UploadRepository uploadRepository,
    required GymChallengesRepository gymChallengesRepository,
  })  : _gymChallengesRepository = gymChallengesRepository,
        _uploadRepository = uploadRepository,
        super(
          EditGymChallengePageState(
              status: EditGymChallengePageStatus.idle,
              description: '',
              name: '',
              endAt: DateTime.now(),
              startAt: DateTime.now(),
              image: null,
              imageUrl: '',
              errorMessage: ''),
        );

  void updateName(String name) {
    emit(
      state.copyWith(
        name: name,
      ),
    );
  }

  void updateDescription(String description) {
    emit(
      state.copyWith(
        description: description,
      ),
    );
  }

  void updateImageUrl(String imageUrl) {
    emit(
      state.copyWith(
        imageUrl: imageUrl,
      ),
    );
  }

  void updateStartAt(DateTime startAt) {
    emit(
      state.copyWith(
        startAt: startAt,
      ),
    );
  }

  void updateEndAt(DateTime endAt) {
    emit(
      state.copyWith(
        endAt: endAt,
      ),
    );
  }

  void updateImageFile(XFile? image) {
    emit(
      state.copyWith(
        image: Nullable(
          image,
        ),
      ),
    );
  }

  Future<void> submitForm(int gymChallengeId) async {
    try {
      emit(
        state.copyWith(
          status: EditGymChallengePageStatus.loading,
        ),
      );

      String url = state.imageUrl;
      if (state.image != null) {
        url = await _uploadRepository.uploadFile(
          UploadDto(
            fileToUpload: state.image!,
          ),
        );
      }
      await _gymChallengesRepository.updateGymChallenge(
        gymChallengeId,
        UpdateGymChallengeDto(
          name: state.name,
          description: state.description,
          endAt: DateHelper.formatDateSlashSeparated(state.endAt),
          startAt: DateHelper.formatDateSlashSeparated(state.startAt),
          image: url.isEmpty? null :url
        )
      );
      emit(
        state.copyWith(
          status: EditGymChallengePageStatus.success,
        ),
      );
    } on ApplicationException catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.getMessage(),
          status: EditGymChallengePageStatus.error,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: 'Unknown error while updating challenge',
          status: EditGymChallengePageStatus.error,
        ),
      );
    }
  }
}
