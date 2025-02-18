import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:jim_hats_mobile/data/auth/dtos/register_dto.dart';
import 'package:jim_hats_mobile/data/auth/repositories/auth_repository.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/shared/utils/nullable.dart';
import 'package:meta/meta.dart';

part 'create_account_page_state.dart';

class CreateAccountPageCubit extends Cubit<CreateAccountPageState> {
  final AuthRepository _authRepository;
  CreateAccountPageCubit({AuthRepository? authRepository})
      : _authRepository = authRepository ?? locator.get<AuthRepository>(),
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
      await _authRepository.register(RegisterDto(
          username: state.username,
          email: state.email,
          password: state.password,
          profilePicture: 'https://someUploadedUrl'));
      emit(state.copyWith(
        status: Status.success
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
      emit(state.copyWith(status: Status.writingForm));
    }
  }
}
