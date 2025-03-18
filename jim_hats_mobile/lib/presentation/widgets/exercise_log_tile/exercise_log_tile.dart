import 'package:flutter/material.dart';
import 'package:jim_hats_mobile/core/utils/date_helper.dart';
import 'package:jim_hats_mobile/data/exercise_logs/models/exercise_log_with_user.dart';
import 'package:jim_hats_mobile/presentation/widgets/user_circle_avatar/user_circle_avatar.dart';

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
              
              UserCircleAvatar(
                username: exerciseLogWithUser.user.username,
                radius: 10,
                avatarUrl: exerciseLogWithUser.user.profilePicture,
              ),
              SizedBox(
                width: 4,
              ),
              Text(exerciseLogWithUser.user.username)
            ],
          ),
          Text(DateHelper.readableDate(exerciseLogWithUser.date))
        ],
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(exerciseLogWithUser.image ?? ''),
      ),
    );
  }
}
