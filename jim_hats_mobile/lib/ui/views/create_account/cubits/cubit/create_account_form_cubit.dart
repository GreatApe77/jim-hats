import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_account_form_state.dart';

class CreateAccountFormCubit extends Cubit<CreateAccountFormState> {
  CreateAccountFormCubit() : super(CreateAccountFormInitial());
}
