import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({
    required ThemeState themeState
  }) : super(themeState) {
    on<ThemeToggledEvent>((event, emit) {
      if(state is ThemeDark){
        emit(ThemeLight());
      }else{
        emit(ThemeDark());
      }
    });
  }
}
