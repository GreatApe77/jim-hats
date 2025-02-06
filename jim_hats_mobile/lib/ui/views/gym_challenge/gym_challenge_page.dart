import 'package:flutter/material.dart';
import 'package:jim_hats_mobile/locator.dart';
import 'package:jim_hats_mobile/shared/ui/widgets/app_drawer/app_drawer.dart';
import 'package:jim_hats_mobile/shared/ui/widgets/app_drawer/cubit/app_drawer_cubit.dart';
import 'package:jim_hats_mobile/ui/views/gym_challenge/gym_challenge_page_arguments.dart';

class GymChallengePage extends StatelessWidget {
  final GymChallengePageArguments gymChallengePageArguments;
  const GymChallengePage({super.key, required this.gymChallengePageArguments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(appDrawerCubit: locator.get<AppDrawerCubit>()),
      appBar: AppBar(),
      body: SafeArea(child: Center(child: Text(

        'ARGUMENT: ${gymChallengePageArguments.challengeId}'
      ),)),
    );
  }
}