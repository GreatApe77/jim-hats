import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:jim_hats_mobile/ui/views/create_account/create_account_form_data.dart';
import 'package:meta/meta.dart';

part 'create_account_page_state.dart';

class CreateAccountPageCubit extends Cubit<CreateAccountPageState> {
  CreateAccountPageCubit()
      : super(CreateAccountPageInitial(
            image: null,
            confirmPassword: '',
            email: '',
            password: '',
            username: ''));
}
