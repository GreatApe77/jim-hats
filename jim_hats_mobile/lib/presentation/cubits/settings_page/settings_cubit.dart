import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jim_hats_mobile/data/logged_user/dtos/update_logged_user_dto.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';
import 'package:jim_hats_mobile/data/logged_user/repositories/logged_user_repository.dart';
import 'package:jim_hats_mobile/data/uploads/dtos/upload_dto.dart';
import 'package:jim_hats_mobile/data/uploads/repositories/upload_repository.dart';
import 'package:meta/meta.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final LoggedUserRepository _loggedUserRepository;
  final UploadRepository _uploadRepository;
  SettingsCubit(
      {required UploadRepository uploadRepository,
      required LoggedUserRepository loggedUserRepository})
      : _uploadRepository = uploadRepository,
        _loggedUserRepository = loggedUserRepository,
        super(SettingsInitial());

  void loadSettingsData() async {
    emit(SettingsDataLoadInProgress());
    final loggedUser = await _loggedUserRepository.getLoggedUser();
    emit(SettingsDataLoadSuccess(loggedUser: loggedUser));
  }

  Future<void> updateLoggedUserProfilePicture(XFile? image) async {
    try {
      emit(SettingsDataLoadInProgress());
      String? uploadedUrl;
      if (image != null) {
        uploadedUrl =
            await _uploadRepository.uploadFile(UploadDto(fileToUpload: image));
      }
      final updatedLoggedUser = await _loggedUserRepository
          .updateLoggedUser(UpdateLoggedUserDto(profilePicture: uploadedUrl));
      emit(SettingsDataLoadSuccess(loggedUser: updatedLoggedUser));
    } catch (e) {
      emit(SettingsDataFailed());
    }
  }
}
