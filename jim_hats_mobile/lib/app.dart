import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/routing/app_router.dart';
import 'package:jim_hats_mobile/ui/theme/bloc/theme_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      bloc: locator.get<ThemeBloc>(),
      builder: (context, state) {
        return MaterialApp(
          darkTheme: ThemeData.dark(),
          onGenerateRoute: AppRouter.ongenerateRoute,
          initialRoute: AppRouter.initialRoute,
          //themeMode: ThemeMode.dark,
          themeMode: state is ThemeDark?ThemeMode.dark:ThemeMode.light
        );
      },
    );
  }
}
