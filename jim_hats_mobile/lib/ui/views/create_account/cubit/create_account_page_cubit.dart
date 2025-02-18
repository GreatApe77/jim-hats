import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:jim_hats_mobile/shared/utils/nullable.dart';
import 'package:meta/meta.dart';

part 'create_account_page_state.dart';

class CreateAccountPageCubit extends Cubit<CreateAccountPageState> {
  CreateAccountPageCubit()
      : super(CreateAccountPageState(
            image: null,
            confirmPassword: '',
            email: '',
            password: '',
            username: ''));

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
    await Future.delayed(Duration(seconds: 2));
    emit(state.copyWith(
        username: '',
        email: '',
        password: '',
        confirmPassword: '',
        image: Nullable<XFile>(null)));
    
  }
}
