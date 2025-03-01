import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/presentation/routing/app_router.dart';
import 'package:jim_hats_mobile/presentation/blocs/theme/theme_bloc.dart';
import 'package:jim_hats_mobile/presentation/theme/fonts.dart';
import 'package:jim_hats_mobile/presentation/theme/materia_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Inter", "Inter");

    MaterialTheme theme = MaterialTheme(textTheme);
    return BlocBuilder<ThemeBloc, ThemeState>(
      bloc: context.read<ThemeBloc>(),
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
            darkTheme: theme.dark(),
            theme: theme.light(),
            onGenerateRoute: AppRouter.ongenerateRoute,
            initialRoute: AppRouter.initialRoute,
            //themeMode: ThemeMode.dark,
            
            themeMode: state is ThemeDark ? ThemeMode.dark : ThemeMode.light);
      },
    );
  }
}
