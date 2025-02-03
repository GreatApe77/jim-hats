import 'package:flutter/material.dart';
import 'package:jim_hats_mobile/routing/app_routes.dart';
import 'package:jim_hats_mobile/shared/ui/constants/app_spacings.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSpacings.horizontalPadding.toDouble()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FilledButton(onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.createAccount);
                  }, child: Text('Create account')),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text('Already have an account? '),
                      GestureDetector(
                        child: Text(
                          'Sign in.',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.edit,
                  size: 72,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Welcome to Jim Hats',
                  style: Theme.of(context).textTheme.headlineSmall,
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
