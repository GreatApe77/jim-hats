import 'package:flutter/widgets.dart';
import 'package:jim_hats_mobile/presentation/views/edit_gym_challenge/edit_gym_challenge_page_arguments.dart';

class EditGymChallengePage extends StatelessWidget {
  final EditGymChallengePageArguments editGymChallengePageArguments;
  const EditGymChallengePage({
    super.key,
    required this.editGymChallengePageArguments,
  });

  @override
  Widget build(BuildContext context) {
    return EditGymChallengeView();
  }
}

class EditGymChallengeView extends StatelessWidget {
  const EditGymChallengeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
