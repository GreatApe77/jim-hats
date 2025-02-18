import 'package:bloc/bloc.dart';

part 'sign_in_page_event.dart';
part 'sign_in_page_state.dart';

class SignInPageBloc extends Bloc<SignInPageEvent, SignInPageState> {
  SignInPageBloc() : super(SignInPageState.empty()) {
    
    on<SignInUsernameChanged>(
      (event, emit) {
        emit(state.copywith(username: event.username));
      },
    );
    on<SignInPasswordChanged>(
      (event, emit) {
        emit(state.copywith(username: event.password));
      },
    );
    on<SignInFormSubmitted>(
      (event, emit) {
        
      },
    );
  }
}
