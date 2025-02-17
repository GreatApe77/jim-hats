import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:jim_hats_mobile/shared/utils/nullable.dart';
import 'package:jim_hats_mobile/ui/views/create_account/create_account_form_data.dart';
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
   
     
    
  }
  void clearImage(){
    
  }
}
