import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jim_hats_mobile/presentation/routing/app_router.dart';
import 'package:jim_hats_mobile/presentation/blocs/theme/theme_bloc.dart';
import 'package:jim_hats_mobile/presentation/theme/app_theme.dart';
import 'package:jim_hats_mobile/presentation/theme/fonts.dart';
import 'package:jim_hats_mobile/presentation/widgets/internet_checker_wrapper/internet_checker_wrapper.dart';


final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(
      context,
      "Inter",
      "Inter",
    );

    return BlocBuilder<ThemeBloc, ThemeState>(
      bloc: context.read<ThemeBloc>(),
      builder: (context, state) {
        return InternetCheckerWrapper(
          child: MaterialApp(
            scaffoldMessengerKey: scaffoldMessengerKey,
            theme: AppTheme.light(textTheme: textTheme),
            darkTheme: AppTheme.dark(textTheme: textTheme),
            themeMode: state is ThemeDark ? ThemeMode.dark : ThemeMode.light,
            onGenerateRoute: AppRouter.ongenerateRoute,
            initialRoute: AppRouter.initialRoute,
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
