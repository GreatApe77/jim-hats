import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:jim_hats_mobile/data/gym_challenges/dtos/create_gym_challenge_dto.dart';
import 'package:jim_hats_mobile/data/gym_challenges/repositories/gym_challenges_repository.dart';
import 'package:jim_hats_mobile/data/uploads/dtos/upload_dto.dart';
import 'package:jim_hats_mobile/data/uploads/repositories/upload_repository.dart';
import 'package:jim_hats_mobile/shared/utils/nullable.dart';

part 'create_challenge_page_state.dart';

class CreateChallengePageCubit extends Cubit<CreateChallengePageState> {
  final UploadRepository _uploadRepository;
  final GymChallengesRepository _gymChallengesRepository;
  CreateChallengePageCubit({
    required UploadRepository uploadRepository,
    required GymChallengesRepository gymChallengesRepository,
  })  : _gymChallengesRepository = gymChallengesRepository,
        _uploadRepository = uploadRepository,
        super(CreateChallengePageState(
          startAt: DateTime.now(),
          endAt: DateUtils.addDaysToDate(DateTime.now(), 30),
          status: CreateChallengePageStatus.idle,
          name: '',
          description: '',
          image: null,
          errorMessage: '',
        ));

  void updateName(String name) {
    emit(state.copyWith(name: name));
  }

  void updateDescription(String description) {
    emit(state.copyWith(description: description));
  }

  void updateImage(XFile? image) {
    emit(state.copyWith(image: Nullable(image)));
  }

  void submitForm() async {
    try {
      emit(state.copyWith(status: CreateChallengePageStatus.loading));
      String? uploadedUrl;
      if (state.image != null) {
        uploadedUrl = await _uploadRepository
            .uploadFile(UploadDto(fileToUpload: state.image!));
      }
      await _gymChallengesRepository.createGymChallenge(
        CreateGymChallengeDto(
          name: state.name,
          description: state.description,
          image: uploadedUrl,
          startAt: formatDate(state.startAt),
          endAt: formatDate(state.endAt),
        ),
      );
      emit(state.copyWith(status: CreateChallengePageStatus.success));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void getDayCount(DateTime startAt, DateTime endAt) {
    final days = endAt.difference(startAt).inDays;
    emit(state.copyWith(endAt: DateUtils.addDaysToDate(startAt, days)));
  }
  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
