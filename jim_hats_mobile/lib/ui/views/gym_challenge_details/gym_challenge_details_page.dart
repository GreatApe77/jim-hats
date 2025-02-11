import 'package:flutter/material.dart';
import 'package:jim_hats_mobile/shared/ui/constants/app_spacings.dart';
import 'package:jim_hats_mobile/ui/views/gym_challenge/gym_challenge_page_arguments.dart';

class GymChallengeDetailsPage extends StatelessWidget {
  const GymChallengeDetailsPage({super.key, required this.pageArguments});
  final GymChallengePageArguments pageArguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppSpacings.horizontalPadding.toDouble()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'TITLE',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('SomeUserName'),
              subtitle: Text('GroupAdmin'),
              leading: CircleAvatar(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('2 Members'),
                InkWell(
                  child: Text(
                    'All',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 60,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 10,
                  );
                },
                //children: [],
                itemCount: 20,
                itemBuilder: (context, index) {
                  return CircleAvatar();
                },
                //  List.generate(
                //   20,
                //   (index) => CircleAvatar(),
                // ),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: () {
                
              },
              textColor: Theme.of(context).colorScheme.error,
              leading: Icon(Icons.logout,color: Theme.of(context).colorScheme.error,),
              title: Text('Leave'),
            )
          ],
        ),
      )),
    );
  }
}
