import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:jim_hats_mobile/shared/utils/nullable.dart';

part 'check_in_page_state.dart';

class CheckInPageCubit extends Cubit<CheckInPageState> {
  CheckInPageCubit({required XFile checkInPhoto})
      : super(CheckInPageState(
            status: CheckInPageStatus.idle,
            photo: checkInPhoto,
            title: '',
            description: ''));

  void updateTitle(String title) {
    emit(state.copyWith(title: title));
  }

  void updateDescription(String description) {
    emit(state.copyWith(description: description));
  }

  void updateImage(XFile? image) {
    emit(state.copyWith(photo: Nullable(image)));
  }
}
