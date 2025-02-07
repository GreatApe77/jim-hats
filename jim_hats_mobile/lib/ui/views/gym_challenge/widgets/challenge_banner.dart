import 'package:flutter/material.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/gym_challenge.dart';
import 'package:jim_hats_mobile/data/gym_challenges/models/ranking.dart';
import 'package:jim_hats_mobile/data/logged_user/models/logged_user.dart';
import 'package:jim_hats_mobile/shared/utils/get_days_between_dates.dart';

class ChallengeBanner extends StatelessWidget {
  final Function() onTap;
  final GymChallenge challenge;
  final Ranking leader;
  final Ranking user;
  const ChallengeBanner({
    required this.challenge,
    super.key,
    required this.leader,
    required this.user, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => onTap(),
      child: SizedBox(
        height: 220,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
                flex: 3,
                child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(challenge.image ??
                                'https://avatars.githubusercontent.com/u/99892494?s=200&v=4')),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        )
                        //color: Colors.amber,
                        ))),
            Expanded(
                child: Row(
              children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      //color: Colors.red,
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(8))),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Leader'),
                    subtitle: Text('${leader.logCount}'),
                    leading: CircleAvatar(
                      radius: 15,
                      backgroundImage:
                          NetworkImage(leader.profilePicture ?? ''),
                    ),
                    //leading: Icon(Icons.calendar_month),
                  ),
                )),
                Expanded(
                    child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text('You'),
                        subtitle: Text('${user.logCount}'),
                        leading: CircleAvatar(
                          radius: 15,
                          backgroundImage:
                              NetworkImage(user.profilePicture ?? ''),
                        ))),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(8)),
                    //color: Colors.purple,
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Days left'),
                    subtitle: Text('${_daysLeft()}'),
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
