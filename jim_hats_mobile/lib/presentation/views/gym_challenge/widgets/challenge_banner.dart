import 'package:flutter/material.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/gym_challenge.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/ranking.dart';
import 'package:jim_hats_mobile/core/utils/get_days_between_dates.dart';
import 'package:jim_hats_mobile/presentation/widgets/user_circle_avatar/user_circle_avatar.dart';

class ChallengeBanner extends StatelessWidget {
  static const daysLeftKey = Key('ChallengeBanner.days_left_text');
   static const mainInkWellKey= Key('ChallengeBanner.main_ink_well');
  final Function() onTap;
  final GymChallenge challenge;
  final Ranking leader;
  final Ranking user;
  const ChallengeBanner({
    required this.challenge,
    super.key,
    required this.leader,
    required this.user,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: ChallengeBanner.mainInkWellKey,
      borderRadius: BorderRadius.circular(8),
      onTap: () => onTap(),
      child: SizedBox(
        height: 220,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 3,
              child: Ink(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(challenge.image ?? ''),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    )
                    //color: Colors.amber,
                    ),
              ),
            ),
            Expanded(
                child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      //color: Colors.red,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(
                          8,
                        ),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('Leader'),
                      subtitle: Text('${leader.logCount}'),
                      leading: UserCircleAvatar(
                        username: leader.username,
                        avatarUrl: leader.profilePicture,
                        radius: 15,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('You'),
                    subtitle: Text('${user.logCount}'),
                    leading: UserCircleAvatar(
                      username: user.username,
                      radius: 15,
                      avatarUrl: user.profilePicture,
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(8)),
                    //color: Colors.purple,
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      key: ChallengeBanner.daysLeftKey,
                      '${_daysLeft()}',
                    ),
                    subtitle: Text('Days left'),
                    leading: Icon(
                      Icons.calendar_month,
                      size: 20,
                    ),
                  ),
                )),
              ],
            )),
          ],
        ),
      ),
    );
  }

  int _daysLeft() {
    return getDaysBetweenDates(challenge.startAt, challenge.endAt);
  }
}
