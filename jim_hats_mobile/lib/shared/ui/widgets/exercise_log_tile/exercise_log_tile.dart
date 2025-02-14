import 'package:flutter/material.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log_with_user.dart';
import 'package:jim_hats_mobile/shared/utils/readable_date.dart';

class ExerciseLogTile extends StatelessWidget {
  final ExerciseLogWithUser exerciseLogWithUser;
  final Function() onTap;
  const ExerciseLogTile({
    super.key,
    required this.exerciseLogWithUser,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      title: Text(exerciseLogWithUser.title),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 10,
              ),
              SizedBox(
                width: 4,
              ),
              Text(exerciseLogWithUser.user.username)
            ],
          ),
          Text(readableDate(exerciseLogWithUser.date))
        ],
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(exerciseLogWithUser.image ?? ''),
      ),
    );
  }
}
