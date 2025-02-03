import 'package:flutter/material.dart';
import 'package:jim_hats_mobile/routing/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: AppRouter.ongenerateRoute,
      initialRoute: AppRouter.initialRoute,
      
    );
  }

 
}