import 'package:flutter/material.dart';
import 'package:jim_hats_mobile/presentation/routing/app_routes.dart';
import 'package:jim_hats_mobile/core/constants/app_spacings.dart';

class ServerDownAlertPage extends StatelessWidget {
  const ServerDownAlertPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.error,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacings.horizontalPadding.toDouble()
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error,
                color: Theme.of(context).colorScheme.onError,
              ),
              Text(
                'Sorry, there is something wrong with the server',
                style: TextStyle(color: Theme.of(context).colorScheme.onError),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onError
                ),
                onPressed: () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.splash);
              }, child: Text('Retry'))
            ],
          ),
        ),
      ),
    );
  }
}
