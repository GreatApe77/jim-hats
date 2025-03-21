import 'package:bloc/bloc.dart';
import 'package:jim_hats_mobile/core/utils/application_exception.dart';
import 'package:jim_hats_mobile/data/auth/dtos/login_dto.dart';
import 'package:jim_hats_mobile/data/auth/repositories/auth_repository.dart';

part 'sign_in_page_event.dart';
part 'sign_in_page_state.dart';

class SignInPageBloc extends Bloc<SignInPageEvent, SignInPageState> {
  final AuthRepository _authRepository;

  SignInPageBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(SignInPageState.empty()) {
    on<SignInUsernameChanged>(
      (event, emit) {
        emit(state.copywith(username: event.username));
      },
    );
    on<SignInPasswordChanged>(
      (event, emit) {
        emit(state.copywith(password: event.password));
      },
    );
    on<SignInFormSubmitted>(
      (event, emit) async {
        try {
          emit(state.copywith(status: SignInPageStatus.loading));
          //await Future.delayed(Duration(seconds: 2));
          await _authRepository.login(
              LoginDto(username: state.username, password: state.password));

          emit(state.copywith(status: SignInPageStatus.success));
        } on ApplicationException catch (e) {
          emit(state.copywith(
            status: SignInPageStatus.failure,
            message: e.getMessage(),
          ));
        } catch (e) {
          
          emit(state.copywith(status: SignInPageStatus.failure,message: 'Unknown error while signing in'));
          //emit(SignInPageState.empty());
        }
      },
    );
  }
}
