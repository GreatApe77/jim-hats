import 'package:bloc/bloc.dart';
import 'package:jim_hats_mobile/data/settings/repositories/settings_repository.dart';
import 'package:meta/meta.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SettingsRepository _settingsRepository;
  ThemeBloc({
    required SettingsRepository settingsRepository,
    required ThemeState themeState
  }) :
    _settingsRepository=settingsRepository,
  
   super(themeState) {
    on<ThemeToggledEvent>((event, emit)async {
      final bool isDarkTheme =state is ThemeDark; 
      if(isDarkTheme){
        await _settingsRepository.setIsDarkTheme(!isDarkTheme);
        emit(ThemeLight());
      }else{
        await _settingsRepository.setIsDarkTheme(!isDarkTheme);
        emit(ThemeDark());
      }
    });
  }
}
