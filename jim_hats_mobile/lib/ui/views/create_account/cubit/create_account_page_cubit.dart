import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:jim_hats_mobile/data/auth/dtos/register_dto.dart';
import 'package:jim_hats_mobile/data/auth/repositories/auth_repository.dart';
import 'package:jim_hats_mobile/data/uploads/dtos/upload_dto.dart';
import 'package:jim_hats_mobile/data/uploads/repositories/upload_repository.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/shared/utils/nullable.dart';

part 'create_account_page_state.dart';

class CreateAccountPageCubit extends Cubit<CreateAccountPageState> {
  final AuthRepository _authRepository;
  final UploadRepository _uploadRepository;
  CreateAccountPageCubit(
      {AuthRepository? authRepository, UploadRepository? uploadRepository})
      : _uploadRepository = uploadRepository ?? locator.get<UploadRepository>(),
        _authRepository = authRepository ?? locator.get<AuthRepository>(),
        super(CreateAccountPageState.empty());

  void addImage(XFile image) {
    emit(state.copyWith(image: Nullable<XFile>(image)));
  }

  void clearImage() {
    emit(state.copyWith(image: Nullable<XFile>(null)));
  }

  void updateUsername(String username) {
    emit(state.copyWith(username: username));
  }

  void updateEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void updatePassword(String password) {
    emit(state.copyWith(password: password));
  }

  void updateConfirmPassword(String confirmPassword) {
    emit(state.copyWith(confirmPassword: confirmPassword));
  }

  void submitForm() async {
    try {
      emit(state.copyWith(status: Status.loading));
      //UPLOAD PHOTO USE URL IN REGISTER
      String? profilePicture;
      if (state.image != null) {
        print("ANTES DO ERRO");
        profilePicture = await _uploadRepository
            .uploadFile(UploadDto(fileToUpload: state.image!));
              print("Depois do erro");

      }
      await Future.delayed(Duration(seconds: 1));
      await _authRepository.register(RegisterDto(
          username: state.username,
          email: state.email,
          password: state.password,
          profilePicture: profilePicture));
      emit(state.copyWith(status: Status.success));
      emit(CreateAccountPageState.empty());
    } catch (e) {
      print(e);
      emit(state.copyWith(status: Status.error));
      emit(CreateAccountPageState.empty());
    }
  }
}
